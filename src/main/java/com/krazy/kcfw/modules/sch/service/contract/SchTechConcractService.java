/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.contract;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.act.service.ActTaskService;
import com.krazy.kcfw.modules.act.utils.ActUtils;
import com.krazy.kcfw.modules.sch.entity.contract.SchTechConcract;
import com.krazy.kcfw.modules.sch.dao.contract.SchTechConcractDao;
import com.krazy.kcfw.modules.sys.dao.UserDao;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 技贸合同Service
 * @author Krazy
 * @version 2016-11-27
 */
@Service
@Transactional(readOnly = true)
public class SchTechConcractService extends CrudService<SchTechConcractDao, SchTechConcract> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	public SchTechConcract get(String id) {
		return super.get(id);
	}
	
	public List<SchTechConcract> findList(SchTechConcract schTechConcract) {
		schTechConcract.getSqlMap().put("dsf", dataScopeFilter(schTechConcract.getCurrentUser(), "o", "u"));
		return super.findList(schTechConcract);
	}
	
	public Page<SchTechConcract> findAllPage(Page<SchTechConcract> page, SchTechConcract schTechConcract) {
		return super.findPage(page, schTechConcract);
	}
	
	public Page<SchTechConcract> findPage(Page<SchTechConcract> page, SchTechConcract schTechConcract) {
		schTechConcract.getSqlMap().put("dsf", dataScopeFilter(schTechConcract.getCurrentUser(), "o", "u"));
		return super.findPage(page, schTechConcract);
	}
	
	@Transactional(readOnly = false)
	public void save(SchTechConcract schTechConcract) {
		
		if (StringUtils.isBlank(schTechConcract.getId())){
			schTechConcract.preInsert();
			//获取当前年月日
			SimpleDateFormat df = new SimpleDateFormat("yyMMdd");//设置日期格式
			SchTechConcract schSTCNO=new SchTechConcract();
			schSTCNO.setStcNo(df.format(new Date()));// new Date()为获取当前系统时间
			SchTechConcract schTechConcractCurr=dao.getStcNO(schSTCNO);
			if(schTechConcractCurr!=null){
				String ss=schTechConcractCurr.getStcNo().substring(4);
				Integer sccNo=Integer.parseInt(ss)+1;
				schTechConcract.setStcNo("XMUT"+sccNo.toString());
			}else{
				schTechConcract.setStcNo("XMUT"+df.format(new Date())+"001");
			}
			schTechConcract.setStcStatus("1");
			dao.insert(schTechConcract);
		}else{
			schTechConcract.preUpdate();
			dao.update(schTechConcract);
		}
		
		if(StringUtils.isBlank(schTechConcract.getAct().getFlag())) {
			return;
		}
		//第一次申请
		if(StringUtils.isBlank(schTechConcract.getAct().getTaskId())){
			
			Map<String, Object> vars = Maps.newHashMap();
			//获取院系秘书
			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "DepartmentSecretary");
			User user=userDao.get(schTechConcract.getCreateBy().getId());
			pars.put("officeId", user.getOffice().getId());
			List<User> users=userDao.findUsersByRoleEnName(pars);					
			StringBuffer sec=new StringBuffer();;
			for(int j=0;j<users.size();j++){
				sec.append(users.get(j).getLoginName());
				if(j<users.size()-1){
					sec.append(",");
				}
			}
			vars.put("sec", sec.toString());
			// 启动流程
			//vars.put("pass", pass);
			actTaskService.startProcess(ActUtils.PD_TECH_CONCRACT[0], ActUtils.PD_TECH_CONCRACT[1], schTechConcract.getId(), schTechConcract.getStcName(),vars);
		
			//更新状态为提交申请
			schTechConcract.setStcStatus("2");
			dao.updateStatus(schTechConcract);
		}else {
			// 重新编辑申请	
			schTechConcract.getAct().setComment(("yes".equals(schTechConcract.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(schTechConcract.getAct().getFlag())? "1" : "0";
			if("no".equals(schTechConcract.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				schTechConcract.setStcStatus("1");
				dao.updateStatus(schTechConcract);
			}else{
				//获取当前用户的角色
				//获取院系秘书
				HashMap<String,String> pars=new HashMap<String,String>();
				pars.put("roleEnName", "DepartmentSecretary");
				User user=userDao.get(schTechConcract.getCreateBy().getId());
				pars.put("officeId", user.getOffice().getId());
				List<User> users=userDao.findUsersByRoleEnName(pars);					
				StringBuffer sec=new StringBuffer();;
				for(int j=0;j<users.size();j++){
					sec.append(users.get(j).getLoginName());
					if(j<users.size()-1){
						sec.append(",");
					}
				}
				vars.put("sec", sec.toString());
				//更新状态为提交申请
				schTechConcract.setStcStatus("2");
				dao.updateStatus(schTechConcract);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(schTechConcract.getAct().getAssignee())){
				actTaskService.claim(schTechConcract.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(schTechConcract.getAct().getTaskId(), schTechConcract.getAct().getProcInsId(), schTechConcract.getAct().getComment(),schTechConcract.getStcName(), vars);
		}
		

		//super.save(schTechConcract);
	}
	
	@Transactional(readOnly = false)
	public void delete(SchTechConcract schTechConcract) {
		super.delete(schTechConcract);
	}
	
	
	@Transactional(readOnly = false)
	public void auditSave(SchTechConcract schTechConcract) {
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		schTechConcract.getAct().setComment(("yes".equals(schTechConcract.getAct().getFlag())?"[同意] ":"[驳回] ")+schTechConcract.getAct().getComment());
		
		schTechConcract.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = schTechConcract.getAct().getTaskDefKey();
		
		String pass= "yes".equals(schTechConcract.getAct().getFlag())? "1" : "0";

		// 审核环节
		if ("teacher_audit".equals(taskDefKey)){
			schTechConcract.setStcTeachComment(schTechConcract.getAct().getComment());
			schTechConcract.setStcStatus("3");
			dao.updateTeachComment(schTechConcract);
			
			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "ResearchResp");
			User user=userDao.get(schTechConcract.getCreateBy().getId());
			pars.put("officeId", user.getOffice().getId());
			List<User> users=userDao.findUsersByRoleEnName(pars);
			StringBuffer resp=new StringBuffer();;
			for(int j=0;j<users.size();j++){
				resp.append(users.get(j).getLoginName());
				if(j<users.size()-1){
					resp.append(",");
				}
			}
			vars.put("resp", resp.toString());
		}
		else if ("resp_audit".equals(taskDefKey)){
			schTechConcract.setStcRespComment(schTechConcract.getAct().getComment());
			schTechConcract.setStcStatus("3");
			dao.updateRespComment(schTechConcract);

			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "ContractMana");
			User user=userDao.get(schTechConcract.getCreateBy().getId());
//			pars.put("officeId", user.getOffice().getId());
			List<User> users=userDao.findUsersByRoleEnName(pars);
			StringBuffer mana=new StringBuffer();;
			for(int j=0;j<users.size();j++){
				mana.append(users.get(j).getLoginName());
				if(j<users.size()-1){
					mana.append(",");
				}
			}
			vars.put("mana", mana.toString());

		}
		else if ("mana_audit".equals(taskDefKey)){
			schTechConcract.setStcManaComment(schTechConcract.getAct().getComment());
			schTechConcract.setStcStatus("3");
			
			HashMap<String,String> pars=new HashMap<String,String>();
			
			//获取金额低于5W
			if(schTechConcract.getStcMoney()<Double.parseDouble(Global.getConfig("commonConcractMin"))){
				schTechConcract.setStcStatus("4");
			}else if(schTechConcract.getStcMoney()>=Double.parseDouble(Global.getConfig("commonConcractMin"))&&schTechConcract.getStcMoney()<Double.parseDouble(Global.getConfig("commonConcractMax"))){
				//获取副处长
				pars.put("roleEnName", "DeputyDirector");
				User userdd=userDao.get(schTechConcract.getCreateBy().getId());
//				pars.put("officeId", userdd.getOffice().getId());
				pars.put("isLike", "false");
				List<User> users=userDao.findUsersByRoleEnName(pars);
				StringBuffer ddirector=new StringBuffer();;
				for(int j=0;j<users.size();j++){
					ddirector.append(users.get(j).getLoginName());
					if(j<users.size()-1){
						ddirector.append(",");
					}
				}
				vars.put("ddirector", ddirector.toString());
				pass="2";
			}else{
				//获取处长
				pars.put("roleEnName", "Director");
				User userD=userDao.get(schTechConcract.getCreateBy().getId());
//				pars.put("officeId", userD.getOffice().getId());
				pars.put("isLike", "false");
				List<User> users=userDao.findUsersByRoleEnName(pars);
				StringBuffer director=new StringBuffer();;
				for(int j=0;j<users.size();j++){
					director.append(users.get(j).getLoginName());
					if(j<users.size()-1){
						director.append(",");
					}
				}
				vars.put("director", director.toString());
				pass="3";
			}
				
			dao.updateManaComment(schTechConcract);
			
		}else if ("ddirect_audit".equals(taskDefKey)){
			schTechConcract.setStcFinalComment(schTechConcract.getAct().getComment());
			schTechConcract.setStcStatus("4");
			dao.updateFinalComment(schTechConcract);
		}else if ("direct_audit".equals(taskDefKey)){
			schTechConcract.setStcFinalComment(schTechConcract.getAct().getComment());
			schTechConcract.setStcStatus("4");
			dao.updateFinalComment(schTechConcract);
		}
		
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(schTechConcract.getAct().getFlag())){
			schTechConcract.setStcStatus("5");
			dao.updateStatus(schTechConcract);
			pass="0";
		}
		// 提交流程任务
		
		vars.put("pass",pass);
		if(StringUtils.isBlank(schTechConcract.getAct().getAssignee())){
			actTaskService.claim(schTechConcract.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(schTechConcract.getAct().getTaskId(), schTechConcract.getAct().getProcInsId(), schTechConcract.getAct().getComment(), vars);

	}
	
	public void saveSuper(SchTechConcract schTechConcract) {
		// TODO Auto-generated method stub
		this.dao.updateAll(schTechConcract);
	}
}