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
import com.krazy.kcfw.modules.xmu.entity.res.XmuReserachInfo;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectStudentDao;
import com.krazy.kcfw.modules.xmu.dao.res.XmuReserachInfoDao;

/**
 * 科研信息Service
 * @author Krazy
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class XmuReserachInfoService extends CrudService<XmuReserachInfoDao, XmuReserachInfo> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private XmuProjectStudentDao xmuProjectStudentDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	@Autowired
	private TaskService taskService;
	
	public XmuReserachInfo get(String id) {
		return super.get(id);
	}
	
	public List<XmuReserachInfo> findList(XmuReserachInfo xmuReserachInfo) {
		xmuReserachInfo.getSqlMap().put("dsf", dataScopeFilter(xmuReserachInfo.getCurrentUser(), "o", "u"));
		return super.findList(xmuReserachInfo);
	}
	
	public Page<XmuReserachInfo> findPage(Page<XmuReserachInfo> page, XmuReserachInfo xmuReserachInfo) {
		xmuReserachInfo.getSqlMap().put("dsf", dataScopeFilter(xmuReserachInfo.getCurrentUser(), "o", "u"));
		xmuReserachInfo.getSqlMap().put("actUser", "or (instr(a.xpi_college_standby,'"+xmuReserachInfo.getCurrentUser().getId()+"')>0 )");
		return super.findPage(page, xmuReserachInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuReserachInfo xmuReserachInfo) {
		if(!xmuReserachInfo.getIsNewRecord()){//编辑表单保存
			XmuReserachInfo t = this.get(xmuReserachInfo.getId());//从数据库取出记录的值
			try {
				MyBeanUtils.copyBeanNotNull2Bean(xmuReserachInfo, t);
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
				xmuReserachInfo.setXpiUserGrade(re.getXpuUserGrade());
				xmuReserachInfo.setXpiUserProfession(re.getXpuUserProfession());
			}
			xmuReserachInfo.setXpiStatus("1");
			super.save(xmuReserachInfo);//保存
		}
		
		if(StringUtils.isBlank(xmuReserachInfo.getAct().getFlag())) {
			return;
		}
		
		//第一次申请
		if(StringUtils.isBlank(xmuReserachInfo.getAct().getTaskId())){			
			Map<String, Object> vars = Maps.newHashMap();
			//判断角色
			User user=userDao.get(xmuReserachInfo.getCreateBy().getId());
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
			actTaskService.startProcess(ActUtils.PD_XMU_RESERACH_INFO[0], ActUtils.PD_XMU_RESERACH_INFO[1], xmuReserachInfo.getId(), xmuReserachInfo.getXpiResearchName(),vars);
		
			//更新状态为提交申请
			xmuReserachInfo.setXpiStatus("2");
			dao.updateStatus(xmuReserachInfo);
			
			xmuReserachInfo.setXpiCollegeStandby( ids.toString());
			dao.updateCollegeStandby(xmuReserachInfo);
		}else {
			// 重新编辑申请	
			xmuReserachInfo.getAct().setComment(("yes".equals(xmuReserachInfo.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(xmuReserachInfo.getAct().getFlag())? "1" : "0";
			if("no".equals(xmuReserachInfo.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				xmuReserachInfo.setXpiStatus("1");
				dao.updateStatus(xmuReserachInfo);
			}else{
				//判断角色
				User user=userDao.get(xmuReserachInfo.getCreateBy().getId());
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
				xmuReserachInfo.setXpiStatus("2");
				dao.updateStatus(xmuReserachInfo);
				
				xmuReserachInfo.setXpiCollegeStandby( ids.toString());
				dao.updateCollegeStandby(xmuReserachInfo);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(xmuReserachInfo.getAct().getAssignee())){
				actTaskService.claim(xmuReserachInfo.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(xmuReserachInfo.getAct().getTaskId(), xmuReserachInfo.getAct().getProcInsId(), xmuReserachInfo.getAct().getComment(),xmuReserachInfo.getXpiResearchName(), vars);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuReserachInfo xmuReserachInfo) {
		super.delete(xmuReserachInfo);
	}
	
	@Transactional(readOnly = false)
	public void saveAduit(XmuReserachInfo xmuReserachInfo) {
		
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		xmuReserachInfo.getAct().setComment(("yes".equals(xmuReserachInfo.getAct().getFlag())?"[同意] ":"[驳回] ")+xmuReserachInfo.getAct().getComment());
		
		xmuReserachInfo.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = xmuReserachInfo.getAct().getTaskDefKey();
		
		String pass="";
		String flag=xmuReserachInfo.getAct().getFlag();
		if("yes".equals(flag)){
			pass="1";
		}

		// 审核环节
		if ("mana_audit".equals(taskDefKey)){
			
			xmuReserachInfo.setXpiCollegeComment(xmuReserachInfo.getAct().getComment());
			xmuReserachInfo.setXpiStatus("3");
			dao.updateCollegeComment(xmuReserachInfo);
			
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
			xmuReserachInfo.setXpiManageStandby( ids.toString());
			dao.updateManageStandby(xmuReserachInfo);
			
		}else if ("sys_audit".equals(taskDefKey)){
			xmuReserachInfo.setXpiManageComment(xmuReserachInfo.getAct().getComment());
			xmuReserachInfo.setXpiStatus("5");
			dao.updateManageComment(xmuReserachInfo);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是不通过，更新状态为不通过
		if("reject".equals(xmuReserachInfo.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuReserachInfo.setXpiStatus("4");
				dao.updateStatus(xmuReserachInfo);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuReserachInfo.setXpiStatus("6");
				dao.updateStatus(xmuReserachInfo);
			}
			pass="2";
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(xmuReserachInfo.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuReserachInfo.setXpiStatus("1");
				dao.updateStatus(xmuReserachInfo);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuReserachInfo.setXpiStatus("2");
				dao.updateStatus(xmuReserachInfo);
			}
			pass="0";
		}
		
		// 提交流程任务		
		vars.put("pass",pass);
		if(StringUtils.isBlank(xmuReserachInfo.getAct().getAssignee())){
			actTaskService.claim(xmuReserachInfo.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(xmuReserachInfo.getAct().getTaskId(), xmuReserachInfo.getAct().getProcInsId(), xmuReserachInfo.getAct().getComment(), vars);

	}

	@Transactional(readOnly = false)
	public void backToEnd(XmuReserachInfo xmuReserachInfo) {
		//更新状态为提交申请
		xmuReserachInfo.setXpiStatus("1");
		dao.updateStatus(xmuReserachInfo);
		
		xmuReserachInfo.setXpiCollegeStandby( "");
		dao.updateCollegeStandby(xmuReserachInfo);
		xmuReserachInfo.setXpiManageStandby( "");
		dao.updateManageStandby(xmuReserachInfo);
		
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "3");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuReserachInfo.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuReserachInfo.setAct(e);
		actTaskService.complete(xmuReserachInfo.getAct().getTaskId(), xmuReserachInfo.getAct().getProcInsId(), "",xmuReserachInfo.getXpiResearchName(), vars);	

		
	}

	@Transactional(readOnly = false)
	public void back(XmuReserachInfo xmuReserachInfo) {
		//更新状态为提交申请
		if(xmuReserachInfo.getXpiStatus().equals("3")){
			xmuReserachInfo.setXpiStatus("2");
			dao.updateStatus(xmuReserachInfo);
		}
		
		xmuReserachInfo.setXpiManageStandby( "");
		dao.updateManageStandby(xmuReserachInfo);
//				actTaskService.taskBack(xmuAcademicEvent.getProcInsId(), null);
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "4");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuReserachInfo.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuReserachInfo.setAct(e);
		actTaskService.complete(xmuReserachInfo.getAct().getTaskId(), xmuReserachInfo.getAct().getProcInsId(), "",xmuReserachInfo.getXpiResearchName(), vars);

		
	}
}