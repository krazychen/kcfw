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
import com.krazy.kcfw.modules.sch.entity.contract.SchComConcract;
import com.krazy.kcfw.modules.sch.dao.contract.SchComConcractDao;
import com.krazy.kcfw.modules.sys.dao.UserDao;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 普通合同Service
 * @author Krazy
 * @version 2016-11-27
 */
@Service
@Transactional(readOnly = true)
public class SchComConcractService extends CrudService<SchComConcractDao, SchComConcract> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	public SchComConcract get(String id) {
		return super.get(id);
	}
	
	public List<SchComConcract> findList(SchComConcract schComConcract) {
		schComConcract.getSqlMap().put("dsf", dataScopeFilter(schComConcract.getCurrentUser(), "o", "u"));
		return super.findList(schComConcract);
	}
	
	public Page<SchComConcract> findAllPage(Page<SchComConcract> page, SchComConcract schComConcract) {
		return super.findPage(page, schComConcract);
	}
	
	public Page<SchComConcract> findPage(Page<SchComConcract> page, SchComConcract schComConcract) {
		schComConcract.getSqlMap().put("dsf", dataScopeFilter(schComConcract.getCurrentUser(), "o", "u"));
		return super.findPage(page, schComConcract);
	}
	
	@Transactional(readOnly = false)
	public void save(SchComConcract schComConcract) {
		
		if (StringUtils.isBlank(schComConcract.getId())){
			schComConcract.preInsert();
			//获取当前年月日
			SimpleDateFormat df = new SimpleDateFormat("yyMMdd");//设置日期格式
			SchComConcract schSCCNO=new SchComConcract();
			schSCCNO.setSccNo(df.format(new Date()));// new Date()为获取当前系统时间
			SchComConcract schComConcractCurr=dao.getSCCNO(schSCCNO);
			if(schComConcractCurr!=null){
				String ss=schComConcractCurr.getSccNo().substring(4);
				Integer sccNo=Integer.parseInt(ss)+1;
				schComConcract.setSccNo("XMUT"+sccNo.toString());
			}else{
				schComConcract.setSccNo("XMUT"+df.format(new Date())+"001");
			}
			schComConcract.setSccStatus("1");
			dao.insert(schComConcract);
		}else{
			schComConcract.preUpdate();
			dao.update(schComConcract);
		}
		
		if(StringUtils.isBlank(schComConcract.getAct().getFlag())) {
			return;
		}
		//第一次申请
		if(StringUtils.isBlank(schComConcract.getAct().getTaskId())){
			
			Map<String, Object> vars = Maps.newHashMap();
			//获取院系秘书
			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "DepartmentSecretary");
			User user=userDao.get(schComConcract.getCreateBy().getId());
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
			actTaskService.startProcess(ActUtils.PD_COMMON_CONCRACT[0], ActUtils.PD_COMMON_CONCRACT[1], schComConcract.getId(), schComConcract.getSccName(),vars);
		
			//更新状态为提交申请
			schComConcract.setSccStatus("2");
			dao.updateStatus(schComConcract);
		}else {
			// 重新编辑申请	
			schComConcract.getAct().setComment(("yes".equals(schComConcract.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(schComConcract.getAct().getFlag())? "1" : "0";
			if("no".equals(schComConcract.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				schComConcract.setSccStatus("1");
				dao.updateStatus(schComConcract);
			}else{
				//获取当前用户的角色
				//获取院系秘书
				HashMap<String,String> pars=new HashMap<String,String>();
				pars.put("roleEnName", "DepartmentSecretary");
				User user=userDao.get(schComConcract.getCreateBy().getId());
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
				schComConcract.setSccStatus("2");
				dao.updateStatus(schComConcract);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(schComConcract.getAct().getAssignee())){
				actTaskService.claim(schComConcract.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(schComConcract.getAct().getTaskId(), schComConcract.getAct().getProcInsId(), schComConcract.getAct().getComment(),schComConcract.getSccName(), vars);
		}
		

		//super.save(schComConcract);
	}
	
	@Transactional(readOnly = false)
	public void delete(SchComConcract schComConcract) {
		super.delete(schComConcract);
	}
	
	
	@Transactional(readOnly = false)
	public void auditSave(SchComConcract schComConcract) {
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		schComConcract.getAct().setComment(("yes".equals(schComConcract.getAct().getFlag())?"[同意] ":"[驳回] ")+schComConcract.getAct().getComment());
		
		schComConcract.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = schComConcract.getAct().getTaskDefKey();
		
		String pass= "yes".equals(schComConcract.getAct().getFlag())? "1" : "0";

		// 审核环节
		if ("teacher_audit".equals(taskDefKey)){
			schComConcract.setSccTeachComment(schComConcract.getAct().getComment());
			schComConcract.setSccStatus("3");
			dao.updateTeachComment(schComConcract);
			
			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "ResearchResp");
			User user=userDao.get(schComConcract.getCreateBy().getId());
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
			schComConcract.setSccRespComment(schComConcract.getAct().getComment());
			schComConcract.setSccStatus("3");
			dao.updateRespComment(schComConcract);

			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "ContractMana");
			User user=userDao.get(schComConcract.getCreateBy().getId());
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
			schComConcract.setSccManaComment(schComConcract.getAct().getComment());
			schComConcract.setSccStatus("3");
			
			HashMap<String,String> pars=new HashMap<String,String>();
			
			//获取金额低于5W
			if(schComConcract.getSccMoney()<Double.parseDouble(Global.getConfig("commonConcractMin"))){
				schComConcract.setSccStatus("4");
			}else if(schComConcract.getSccMoney()>=Double.parseDouble(Global.getConfig("commonConcractMin"))&&schComConcract.getSccMoney()<Double.parseDouble(Global.getConfig("commonConcractMax"))){
				//获取副处长
				pars.put("roleEnName", "DeputyDirector");
				User userdd=userDao.get(schComConcract.getCreateBy().getId());
				pars.put("officeId", userdd.getOffice().getId());
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
				User userD=userDao.get(schComConcract.getCreateBy().getId());
				pars.put("officeId", userD.getOffice().getId());
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
				
			dao.updateManaComment(schComConcract);
			
		}else if ("ddirect_audit".equals(taskDefKey)){
			schComConcract.setSccFinalComment(schComConcract.getAct().getComment());
			schComConcract.setSccStatus("4");
			dao.updateFinalComment(schComConcract);
		}else if ("direct_audit".equals(taskDefKey)){
			schComConcract.setSccFinalComment(schComConcract.getAct().getComment());
			schComConcract.setSccStatus("4");
			dao.updateFinalComment(schComConcract);
		}
		
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(schComConcract.getAct().getFlag())){
			schComConcract.setSccStatus("5");
			dao.updateStatus(schComConcract);
			pass="0";
		}
		// 提交流程任务
		
		vars.put("pass",pass);
		if(StringUtils.isBlank(schComConcract.getAct().getAssignee())){
			actTaskService.claim(schComConcract.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(schComConcract.getAct().getTaskId(), schComConcract.getAct().getProcInsId(), schComConcract.getAct().getComment(), vars);

	}

	public void saveSuper(SchComConcract schComConcract) {
		// TODO Auto-generated method stub
		this.dao.updateAll(schComConcract);
	}
}