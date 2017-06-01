/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.req;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.common.utils.CacheUtils;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.act.service.ActTaskService;
import com.krazy.kcfw.modules.act.utils.ActUtils;
import com.krazy.kcfw.modules.cms.entity.Article;
import com.krazy.kcfw.modules.cms.entity.Category;
import com.krazy.kcfw.modules.sch.entity.req.SchCompReq;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResource;
import com.krazy.kcfw.modules.sch.dao.req.SchCompReqDao;
import com.krazy.kcfw.modules.sys.dao.UserDao;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 需求Service
 * @author Krazy
 * @version 2016-11-30
 */
@Service
@Transactional(readOnly = true)
public class SchCompReqService extends CrudService<SchCompReqDao, SchCompReq> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	public SchCompReq get(String id) {
		return super.get(id);
	}
	
	public List<SchCompReq> findPageList(SchCompReq schCompReq) {
		return super.findList(schCompReq);
	}
	
	public List<SchCompReq> findList(SchCompReq schCompReq) {
		if(schCompReq.getCurrentUser()!=null){
			schCompReq.getSqlMap().put("dsf", dataScopeFilter(schCompReq.getCurrentUser(), "o", "u"));
		}
		return super.findList(schCompReq);
	}
	
	public Page<SchCompReq> findPage(Page<SchCompReq> page, SchCompReq schCompReq) {
		if(schCompReq!=null&&schCompReq.getCurrentUser()!=null){
			schCompReq.getSqlMap().put("dsf", dataScopeFilter(schCompReq.getCurrentUser(), "o", "u"));
		}
		return super.findPage(page, schCompReq);
	}
	
	public Page<SchCompReq> findPageArt(Page<SchCompReq> page, SchCompReq schCompReq) {
		return super.findPage(page, schCompReq);
	}
	
	@Transactional(readOnly = false)
	public void save(SchCompReq schCompReq) {
		
		if (StringUtils.isBlank(schCompReq.getId())){
			schCompReq.preInsert();
			schCompReq.setScrStatus("1");
			dao.insert(schCompReq);
		}else{
			schCompReq.preUpdate();
			dao.update(schCompReq);
		}
		
		if(StringUtils.isBlank(schCompReq.getAct().getFlag())) {
			return;
		}
		
		//第一次申请
		if(StringUtils.isBlank(schCompReq.getAct().getTaskId())){
			
			Map<String, Object> vars = Maps.newHashMap();
//			//获取所有老师
//			HashMap<String,String> pars=new HashMap<String,String>();
//			pars.put("roleEnName", "teacher");
//			//User user=userDao.get(schCompReq.getCreateBy().getId());
//			//pars.put("officeId", user.getOffice().getId());
//			List<User> users=userDao.findUsersByRoleEnName(pars);					
//			StringBuffer teacher=new StringBuffer();;
//			for(int j=0;j<users.size();j++){
//				teacher.append(users.get(j).getLoginName());
//				if(j<users.size()-1){
//					teacher.append(",");
//				}
//			}
//			vars.put("teachers", teacher.toString());
			//获取本部门的合同管理员
			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "reqmana");
//			User user=userDao.get(schCompReq.getCreateBy().getId());
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
			// 启动流程
			//vars.put("pass", pass);
			actTaskService.startProcess(ActUtils.PD_COMP_REQ[0], ActUtils.PD_COMP_REQ[1], schCompReq.getId(), schCompReq.getScrName(),vars);
		
			//更新状态为提交申请
			schCompReq.setScrStatus("2");
			dao.updateStatus(schCompReq);
		}else {
			// 重新编辑申请	
			schCompReq.getAct().setComment(("yes".equals(schCompReq.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(schCompReq.getAct().getFlag())? "1" : "0";
			if("no".equals(schCompReq.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				schCompReq.setScrStatus("1");
				dao.updateStatus(schCompReq);
			}else{
				//获取当前用户的角色
				//获取所有老师
				HashMap<String,String> pars=new HashMap<String,String>();
				pars.put("roleEnName", "teacher");
				//User user=userDao.get(schCompReq.getCreateBy().getId());
				//pars.put("officeId", user.getOffice().getId());
				List<User> users=userDao.findUsersByRoleEnName(pars);					
				StringBuffer teacher=new StringBuffer();;
				for(int j=0;j<users.size();j++){
					teacher.append(users.get(j).getLoginName());
					if(j<users.size()-1){
						teacher.append(",");
					}
				}
				vars.put("teachers", teacher.toString());
				//更新状态为提交申请
				schCompReq.setScrStatus("2");
				dao.updateStatus(schCompReq);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(schCompReq.getAct().getAssignee())){
				actTaskService.claim(schCompReq.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(schCompReq.getAct().getTaskId(), schCompReq.getAct().getProcInsId(), schCompReq.getAct().getComment(),schCompReq.getScrName(), vars);
		}
		
//		super.save(schCompReq);
	}
	
	@Transactional(readOnly = false)
	public void delete(SchCompReq schCompReq) {
		super.delete(schCompReq);
	}
	
	@Transactional(readOnly = false)
	public void auditSave(SchCompReq schCompReq) {
		Map<String, Object> vars = Maps.newHashMap();
		
		schCompReq.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = schCompReq.getAct().getTaskDefKey();
		
		String pass= "yes".equals(schCompReq.getAct().getFlag())? "1" : "0";

		//合同管理员审核环节
		if ("mana_audit".equals(taskDefKey)){
			// 设置意见
			schCompReq.getAct().setComment(("yes".equals(schCompReq.getAct().getFlag())?"[审核通过] ":"[审核不通过] ")+schCompReq.getAct().getComment());
			schCompReq.setScrManaComment(schCompReq.getAct().getComment());
			schCompReq.setScrStatus("3");
			dao.updateManaComment(schCompReq);
			
			//获取所有老师
			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "teacher");
			//User user=userDao.get(schCompReq.getCreateBy().getId());
			//pars.put("officeId", user.getOffice().getId());
			List<User> users=userDao.findUsersByRoleEnName(pars);					
			StringBuffer teacher=new StringBuffer();;
			for(int j=0;j<users.size();j++){
				teacher.append(users.get(j).getLoginName());
				if(j<users.size()-1){
					teacher.append(",");
				}
			}
			vars.put("teachers", teacher.toString());
		}
		// 接受环节
		else if ("teacher_receive".equals(taskDefKey)){
			// 设置意见
			schCompReq.getAct().setComment(("yes".equals(schCompReq.getAct().getFlag())?"[已接受] ":"[拒绝] ")+schCompReq.getAct().getComment());
			schCompReq.setScrRecComment(schCompReq.getAct().getComment());
			schCompReq.setScrStatus("4");
			schCompReq.setScrRecTeachId(UserUtils.getUser().getId());
			dao.updateRecComment(schCompReq);

			vars.put("teacher", UserUtils.getUser().getLoginName());
			
		}
		//解决环节
		else if("teacher_audit".equals(taskDefKey)){
			// 设置意见
			schCompReq.getAct().setComment(("yes".equals(schCompReq.getAct().getFlag())?"[已解决] ":"[退回] ")+schCompReq.getAct().getComment());
			schCompReq.setScrFinalComment(schCompReq.getAct().getComment());
			schCompReq.setScrStatus("5");
			dao.updateFinalComment(schCompReq);

		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是驳回，更新状态为提交申请
		if("no".equals(schCompReq.getAct().getFlag())){
			schCompReq.setScrStatus("2");
			dao.updateStatus(schCompReq);
		}
		// 提交流程任务
		
		vars.put("pass",pass);
		if(StringUtils.isBlank(schCompReq.getAct().getAssignee())){
			actTaskService.claim(schCompReq.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(schCompReq.getAct().getTaskId(), schCompReq.getAct().getProcInsId(), schCompReq.getAct().getComment(), vars);

	}
	
	@Transactional(readOnly = false)
	public void saveList(List<SchCompReq> lists) {
		for(int i=0;i<lists.size();i++){
			SchCompReq strl=lists.get(i);
//			strl.preInsert();
//			strl.setScrStatus("1");
//			dao.insert(strl);
			this.save(strl);
		}
	}
	
	public Integer getAcceptTimes(){
		SchCompReq schCompReq =new SchCompReq();
		schCompReq.setScrStatus("4");
		schCompReq.setScrRecTeachId(UserUtils.getUser().getId());
		return this.dao.getAcceptTimes(schCompReq);
	}
	
	@Transactional(readOnly = false)
	public void saveSuper(SchCompReq schCompReq) {
		this.dao.updateAll(schCompReq);
	}
}