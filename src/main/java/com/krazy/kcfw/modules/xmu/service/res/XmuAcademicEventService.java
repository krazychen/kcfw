/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.service.res;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.common.utils.MyBeanUtils;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.act.entity.Act;
import com.krazy.kcfw.modules.act.service.ActTaskService;
import com.krazy.kcfw.modules.act.utils.ActUtils;
import com.krazy.kcfw.modules.act.utils.ProcessDefCache;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnder;
import com.krazy.kcfw.modules.sys.dao.UserDao;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.entity.res.XmuAcademicEvent;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectStudentDao;
import com.krazy.kcfw.modules.xmu.dao.res.XmuAcademicEventDao;

/**
 * 学术活动Service
 * @author Krazy
 * @version 2017-02-18
 */
@Service
@Transactional(readOnly = true)
public class XmuAcademicEventService extends CrudService<XmuAcademicEventDao, XmuAcademicEvent> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private XmuProjectStudentDao xmuProjectStudentDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	@Autowired
	private TaskService taskService;
	
	public XmuAcademicEvent get(String id) {
		return super.get(id);
	}
	
	public List<XmuAcademicEvent> findList(XmuAcademicEvent xmuAcademicEvent) {
		xmuAcademicEvent.getSqlMap().put("dsf", dataScopeFilter(xmuAcademicEvent.getCurrentUser(), "o", "u"));
		return super.findList(xmuAcademicEvent);
	}
	
	public Page<XmuAcademicEvent> findPage(Page<XmuAcademicEvent> page, XmuAcademicEvent xmuAcademicEvent) {
		xmuAcademicEvent.getSqlMap().put("dsf", dataScopeFilter(xmuAcademicEvent.getCurrentUser(), "o", "u"));
		xmuAcademicEvent.getSqlMap().put("actUser", "or (instr(a.xae_college_standby,'"+xmuAcademicEvent.getCurrentUser().getId()+"')>0 ");
		xmuAcademicEvent.getSqlMap().put("actUser2", " )");
		return super.findPage(page, xmuAcademicEvent);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuAcademicEvent xmuAcademicEvent) {
		
		if(!xmuAcademicEvent.getIsNewRecord()){//编辑表单保存
			XmuAcademicEvent t = this.get(xmuAcademicEvent.getId());//从数据库取出记录的值
			try {
				MyBeanUtils.copyBeanNotNull2Bean(xmuAcademicEvent, t);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//将编辑表单中的非NULL值覆盖数据库记录中的值
			super.save(t);
		}else{//新增表单保存
			User user=UserUtils.getUser();
			XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
			xmuProjectStudent.setXpuUserStuno(user.getNo());
			List<XmuProjectStudent> list=xmuProjectStudentDao.findUserList(xmuProjectStudent);
			if(list!=null&&list.size()>0){
				XmuProjectStudent re=list.get(0);
				xmuAcademicEvent.setXaeUserGrade(re.getXpuUserGrade());
				xmuAcademicEvent.setXaeUserProfession(re.getXpuUserProfession());
			}
			xmuAcademicEvent.setXaeStatus("1");
			super.save(xmuAcademicEvent);//保存
		}
		
		if(StringUtils.isBlank(xmuAcademicEvent.getAct().getFlag())) {
			return;
		}
		
		//第一次申请
		if(StringUtils.isBlank(xmuAcademicEvent.getAct().getTaskId())){			
			Map<String, Object> vars = Maps.newHashMap();
			//判断角色
			User user=userDao.get(xmuAcademicEvent.getCreateBy().getId());
			List<Role> roles=UserUtils.getUser().getRoleList();
			StringBuffer ids=new StringBuffer();
			for(int i=0;i<roles.size();i++){
				Role role=roles.get(i);
				if(StringUtils.isNoneBlank(role.getEnname())&&"Student".equals(role.getEnname())){
					
					//获取院系管理员								
					HashMap<String,String> pars=new HashMap<String,String>();
					pars.put("roleEnName", "Manager");			
					pars.put("officeId", user.getOffice().getId());
					List<User> users=userDao.findUsersByRoleEnName(pars);					
					StringBuffer mana=new StringBuffer();
					for(int j=0;j<users.size();j++){
						mana.append(users.get(j).getLoginName());
						ids.append(users.get(j).getId());
						if(j<users.size()-1){
							mana.append(",");
							ids.append(",");
						}
					}
					vars.put("mana", mana.toString());
					vars.put("pass", "0");
					break;
				}
				if(StringUtils.isNoneBlank(role.getEnname())&&"Manager".equals(role.getEnname())){
					//获取系统管理员								
					HashMap<String,String> pars=new HashMap<String,String>();
					pars.put("roleEnName", "dept");
					List<User> users=userDao.findUsersByRoleEnName(pars);
					StringBuffer resp=new StringBuffer();;
					for(int j=0;j<users.size();j++){
						resp.append(users.get(j).getLoginName());
						ids.append(users.get(j).getId());
						if(j<users.size()-1){
							resp.append(",");
							ids.append(",");
						}
					}
					vars.put("sys", resp.toString());
					vars.put("pass", "1");
					break;
				}
			}
			
			// 启动流程
			//vars.put("pass", pass);
			actTaskService.startProcess(ActUtils.PD_XMU_ACADEMIC_EVENT[0], ActUtils.PD_XMU_ACADEMIC_EVENT[1], xmuAcademicEvent.getId(), xmuAcademicEvent.getXaeEventName(),vars);
		
			//更新状态为提交申请
			xmuAcademicEvent.setXaeStatus("2");
			dao.updateStatus(xmuAcademicEvent);
			
			xmuAcademicEvent.setXaeCollegeStandby( ids.toString());
			dao.updateCollegeStandby(xmuAcademicEvent);
		}else {
			// 重新编辑申请	
			xmuAcademicEvent.getAct().setComment(("yes".equals(xmuAcademicEvent.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(xmuAcademicEvent.getAct().getFlag())? "1" : "0";
			if("no".equals(xmuAcademicEvent.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				xmuAcademicEvent.setXaeStatus("1");
				dao.updateStatus(xmuAcademicEvent);
			}else{
				//判断角色
				User user=userDao.get(xmuAcademicEvent.getCreateBy().getId());
				List<Role> roles=UserUtils.getUser().getRoleList();
				StringBuffer ids=new StringBuffer();
				for(int i=0;i<roles.size();i++){
					Role role=roles.get(i);
					if(StringUtils.isNoneBlank(role.getEnname())&&"student".equals(role.getEnname())){
						
						//获取院系管理员								
						HashMap<String,String> pars=new HashMap<String,String>();
						pars.put("roleEnName", "Manager");			
						pars.put("officeId", user.getOffice().getId());
						List<User> users=userDao.findUsersByRoleEnName(pars);					
						StringBuffer mana=new StringBuffer();
						for(int j=0;j<users.size();j++){
							mana.append(users.get(j).getLoginName());
							ids.append(users.get(j).getId());
							if(j<users.size()-1){
								mana.append(",");
								ids.append(",");
							}
						}
						vars.put("mana", mana.toString());
						break;
					}
					if(StringUtils.isNoneBlank(role.getEnname())&&"Manager".equals(role.getEnname())){
						//获取系统管理员								
						HashMap<String,String> pars=new HashMap<String,String>();
						pars.put("roleEnName", "dept");
						List<User> users=userDao.findUsersByRoleEnName(pars);
						StringBuffer resp=new StringBuffer();;
						for(int j=0;j<users.size();j++){
							resp.append(users.get(j).getLoginName());
							ids.append(users.get(j).getId());
							if(j<users.size()-1){
								resp.append(",");
								ids.append(",");
							}
						}
						vars.put("sys", resp.toString());
						break;
					}
				}
				//更新状态为提交申请
				xmuAcademicEvent.setXaeStatus("2");
				dao.updateStatus(xmuAcademicEvent);
				
				xmuAcademicEvent.setXaeCollegeStandby( ids.toString());
				dao.updateCollegeStandby(xmuAcademicEvent);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(xmuAcademicEvent.getAct().getAssignee())){
				actTaskService.claim(xmuAcademicEvent.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(xmuAcademicEvent.getAct().getTaskId(), xmuAcademicEvent.getAct().getProcInsId(), xmuAcademicEvent.getAct().getComment(),xmuAcademicEvent.getXaeEventName(), vars);
		}
	}
	
	@Transactional(readOnly = false)
	public void backToEnd(XmuAcademicEvent xmuAcademicEvent) {
		//更新状态为提交申请
		xmuAcademicEvent.setXaeStatus("1");
		dao.updateStatus(xmuAcademicEvent);
		
		xmuAcademicEvent.setXaeCollegeStandby( "");
		dao.updateCollegeStandby(xmuAcademicEvent);
		xmuAcademicEvent.setXaeManageStandby( "");
		dao.updateManageStandby(xmuAcademicEvent);
		
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "3");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuAcademicEvent.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuAcademicEvent.setAct(e);
		actTaskService.complete(xmuAcademicEvent.getAct().getTaskId(), xmuAcademicEvent.getAct().getProcInsId(), "",xmuAcademicEvent.getXaeEventName(), vars);
	}
	
	@Transactional(readOnly = false)
	public void back(XmuAcademicEvent xmuAcademicEvent) {
		//更新状态为提交申请
		if(xmuAcademicEvent.getXaeStatus().equals("3")){
			xmuAcademicEvent.setXaeStatus("2");
			dao.updateStatus(xmuAcademicEvent);
		}
		
		xmuAcademicEvent.setXaeManageStandby( "");
		dao.updateManageStandby(xmuAcademicEvent);
//		actTaskService.taskBack(xmuAcademicEvent.getProcInsId(), null);
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "4");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuAcademicEvent.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuAcademicEvent.setAct(e);
		actTaskService.complete(xmuAcademicEvent.getAct().getTaskId(), xmuAcademicEvent.getAct().getProcInsId(), "",xmuAcademicEvent.getXaeEventName(), vars);

	}
	
	@Transactional(readOnly = false)
	public void saveAduit(XmuAcademicEvent xmuAcademicEvent) {
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		xmuAcademicEvent.getAct().setComment(("yes".equals(xmuAcademicEvent.getAct().getFlag())?"[同意] ":"[驳回] ")+xmuAcademicEvent.getAct().getComment());
		
		xmuAcademicEvent.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = xmuAcademicEvent.getAct().getTaskDefKey();
		
		String pass="";
		String flag=xmuAcademicEvent.getAct().getFlag();
		if("yes".equals(flag)){
			pass="1";
		}

		// 审核环节
		if ("mana_audit".equals(taskDefKey)){
			
			xmuAcademicEvent.setXaeCollegeComment(xmuAcademicEvent.getAct().getComment());
			xmuAcademicEvent.setXaeStatus("3");
			dao.updateCollegeComment(xmuAcademicEvent);
			
			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "dept");
			List<User> users=userDao.findUsersByRoleEnName(pars);
			StringBuffer resp=new StringBuffer();
			StringBuffer ids=new StringBuffer();
			for(int j=0;j<users.size();j++){
				resp.append(users.get(j).getLoginName());
				ids.append(users.get(j).getId());
				if(j<users.size()-1){
					resp.append(",");
					ids.append(",");
				}
			}
			vars.put("sys", resp.toString());
			xmuAcademicEvent.setXaeManageStandby( ids.toString());
			dao.updateManageStandby(xmuAcademicEvent);
			
		}else if ("sys_audit".equals(taskDefKey)){
			xmuAcademicEvent.setXaeManageComment(xmuAcademicEvent.getAct().getComment());
			xmuAcademicEvent.setXaeStatus("5");
			dao.updateManageComment(xmuAcademicEvent);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是不通过，更新状态为不通过
		if("reject".equals(xmuAcademicEvent.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuAcademicEvent.setXaeStatus("4");
				dao.updateStatus(xmuAcademicEvent);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuAcademicEvent.setXaeStatus("6");
				dao.updateStatus(xmuAcademicEvent);
			}
			pass="2";
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(xmuAcademicEvent.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuAcademicEvent.setXaeStatus("1");
				dao.updateStatus(xmuAcademicEvent);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuAcademicEvent.setXaeStatus("2");
				dao.updateStatus(xmuAcademicEvent);
			}
			pass="0";
		}
		
		// 提交流程任务		
		vars.put("pass",pass);
		if(StringUtils.isBlank(xmuAcademicEvent.getAct().getAssignee())){
			actTaskService.claim(xmuAcademicEvent.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(xmuAcademicEvent.getAct().getTaskId(), xmuAcademicEvent.getAct().getProcInsId(), xmuAcademicEvent.getAct().getComment(), vars);

	}
	
	@Transactional(readOnly = false)
	public void delete(XmuAcademicEvent xmuAcademicEvent) {
		super.delete(xmuAcademicEvent);
	}
	
	
}