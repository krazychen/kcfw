/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.service.res;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
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
import com.krazy.kcfw.modules.sys.dao.UserDao;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.entity.res.XmuAcademicEvent;
import com.krazy.kcfw.modules.xmu.entity.res.XmuPagePub;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectStudentDao;
import com.krazy.kcfw.modules.xmu.dao.res.XmuPagePubDao;

/**
 * 论文发表Service
 * @author Krazy
 * @version 2017-03-06
 */
@Service
@Transactional(readOnly = true)
public class XmuPagePubService extends CrudService<XmuPagePubDao, XmuPagePub> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private XmuProjectStudentDao xmuProjectStudentDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	@Autowired
	private TaskService taskService;
	
	public XmuPagePub get(String id) {
		return super.get(id);
	}
	
	public List<XmuPagePub> findList(XmuPagePub xmuPagePub) {
		xmuPagePub.getSqlMap().put("dsf", dataScopeFilter(xmuPagePub.getCurrentUser(), "o", "u"));
		return super.findList(xmuPagePub);
	}
	
	public Page<XmuPagePub> findPage(Page<XmuPagePub> page, XmuPagePub xmuPagePub) {
		xmuPagePub.getSqlMap().put("dsf", dataScopeFilter(xmuPagePub.getCurrentUser(), "o", "u"));
		xmuPagePub.getSqlMap().put("actUser", "or (instr(a.xpp_college_standby,'"+xmuPagePub.getCurrentUser().getId()+"')>0 )");
		return super.findPage(page, xmuPagePub);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuPagePub xmuPagePub) {
		if(!xmuPagePub.getIsNewRecord()){//编辑表单保存
			XmuPagePub t = this.get(xmuPagePub.getId());//从数据库取出记录的值
			try {
				MyBeanUtils.copyBeanNotNull2Bean(xmuPagePub, t);
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
				xmuPagePub.setXppUserGrade(re.getXpuUserGrade());
				xmuPagePub.setXppUserProfession(re.getXpuUserProfession());
			}
			xmuPagePub.setXppStatus("1");
			super.save(xmuPagePub);//保存
		}
		
		if(StringUtils.isBlank(xmuPagePub.getAct().getFlag())) {
			return;
		}
		
		//第一次申请
		if(StringUtils.isBlank(xmuPagePub.getAct().getTaskId())){			
			Map<String, Object> vars = Maps.newHashMap();
			//判断角色
			User user=userDao.get(xmuPagePub.getCreateBy().getId());
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
			actTaskService.startProcess(ActUtils.PD_XMU_PAGE_PUB[0], ActUtils.PD_XMU_PAGE_PUB[1], xmuPagePub.getId(), xmuPagePub.getXppPageName(),vars);
		
			//更新状态为提交申请
			xmuPagePub.setXppStatus("2");
			dao.updateStatus(xmuPagePub);
			
			xmuPagePub.setXppCollegeStandby( ids.toString());
			dao.updateCollegeStandby(xmuPagePub);
		}else {
			// 重新编辑申请	
			xmuPagePub.getAct().setComment(("yes".equals(xmuPagePub.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(xmuPagePub.getAct().getFlag())? "1" : "0";
			if("no".equals(xmuPagePub.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				xmuPagePub.setXppStatus("1");
				dao.updateStatus(xmuPagePub);
			}else{
				//判断角色
				User user=userDao.get(xmuPagePub.getCreateBy().getId());
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
				xmuPagePub.setXppStatus("2");
				dao.updateStatus(xmuPagePub);
				
				xmuPagePub.setXppCollegeStandby( ids.toString());
				dao.updateCollegeStandby(xmuPagePub);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(xmuPagePub.getAct().getAssignee())){
				actTaskService.claim(xmuPagePub.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(xmuPagePub.getAct().getTaskId(), xmuPagePub.getAct().getProcInsId(), xmuPagePub.getAct().getComment(),xmuPagePub.getXppPageName(), vars);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuPagePub xmuPagePub) {
		super.delete(xmuPagePub);
	}

	@Transactional(readOnly = false)
	public void saveAduit(XmuPagePub xmuPagePub) {
		
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		xmuPagePub.getAct().setComment(("yes".equals(xmuPagePub.getAct().getFlag())?"[同意] ":"[驳回] ")+xmuPagePub.getAct().getComment());
		
		xmuPagePub.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = xmuPagePub.getAct().getTaskDefKey();
		
		String pass="";
		String flag=xmuPagePub.getAct().getFlag();
		if("yes".equals(flag)){
			pass="1";
		}

		// 审核环节
		if ("mana_audit".equals(taskDefKey)){
			
			xmuPagePub.setXppCollegeComment(xmuPagePub.getAct().getComment());
			xmuPagePub.setXppStatus("3");
			dao.updateCollegeComment(xmuPagePub);
			
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
			xmuPagePub.setXppManageStandby( ids.toString());
			dao.updateManageStandby(xmuPagePub);
			
		}else if ("sys_audit".equals(taskDefKey)){
			xmuPagePub.setXppManageComment(xmuPagePub.getAct().getComment());
			xmuPagePub.setXppStatus("5");
			dao.updateManageComment(xmuPagePub);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是不通过，更新状态为不通过
		if("reject".equals(xmuPagePub.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuPagePub.setXppStatus("4");
				dao.updateStatus(xmuPagePub);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuPagePub.setXppStatus("6");
				dao.updateStatus(xmuPagePub);
			}
			pass="2";
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(xmuPagePub.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuPagePub.setXppStatus("1");
				dao.updateStatus(xmuPagePub);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuPagePub.setXppStatus("2");
				dao.updateStatus(xmuPagePub);
			}
			pass="0";
		}
		
		// 提交流程任务		
		vars.put("pass",pass);
		if(StringUtils.isBlank(xmuPagePub.getAct().getAssignee())){
			actTaskService.claim(xmuPagePub.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(xmuPagePub.getAct().getTaskId(), xmuPagePub.getAct().getProcInsId(), xmuPagePub.getAct().getComment(), vars);
		
	}

	@Transactional(readOnly = false)
	public void backToEnd(XmuPagePub xmuPagePub) {
		//更新状态为提交申请
		xmuPagePub.setXppStatus("1");
		dao.updateStatus(xmuPagePub);
		
		xmuPagePub.setXppCollegeStandby( "");
		dao.updateCollegeStandby(xmuPagePub);
		xmuPagePub.setXppManageStandby( "");
		dao.updateManageStandby(xmuPagePub);
		
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "2");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuPagePub.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuPagePub.setAct(e);
		actTaskService.complete(xmuPagePub.getAct().getTaskId(), xmuPagePub.getAct().getProcInsId(), "",xmuPagePub.getXppPageName(), vars);	
	}

	@Transactional(readOnly = false)
	public void back(XmuPagePub xmuPagePub) {
		//更新状态为提交申请
		if(xmuPagePub.getXppStatus().equals("3")){
			xmuPagePub.setXppStatus("2");
			dao.updateStatus(xmuPagePub);
		}
		
		xmuPagePub.setXppManageStandby( "");
		dao.updateManageStandby(xmuPagePub);
//		actTaskService.taskBack(xmuAcademicEvent.getProcInsId(), null);
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "4");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuPagePub.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuPagePub.setAct(e);
		actTaskService.complete(xmuPagePub.getAct().getTaskId(), xmuPagePub.getAct().getProcInsId(), "",xmuPagePub.getXppPageName(), vars);
	}
	
	
}