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
import com.krazy.kcfw.modules.xmu.entity.res.XmuPagePub;
import com.krazy.kcfw.modules.xmu.entity.res.XmuWinningInfo;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectStudentDao;
import com.krazy.kcfw.modules.xmu.dao.res.XmuWinningInfoDao;

/**
 * 获奖信息Service
 * @author Krazy
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class XmuWinningInfoService extends CrudService<XmuWinningInfoDao, XmuWinningInfo> {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private XmuProjectStudentDao xmuProjectStudentDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	@Autowired
	private TaskService taskService;
	
	public XmuWinningInfo get(String id) {
		return super.get(id);
	}
	
	public List<XmuWinningInfo> findList(XmuWinningInfo xmuWinningInfo) {
		xmuWinningInfo.getSqlMap().put("dsf", dataScopeFilter(xmuWinningInfo.getCurrentUser(), "o", "u"));
		return super.findList(xmuWinningInfo);
	}
	
	public Page<XmuWinningInfo> findPage(Page<XmuWinningInfo> page, XmuWinningInfo xmuWinningInfo) {
		xmuWinningInfo.getSqlMap().put("dsf", dataScopeFilter(xmuWinningInfo.getCurrentUser(), "o", "u"));
		xmuWinningInfo.getSqlMap().put("actUser", "or (instr(a.xwi_college_standby,'"+xmuWinningInfo.getCurrentUser().getId()+"')>0 )");
		return super.findPage(page, xmuWinningInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuWinningInfo xmuWinningInfo) {
		if(!xmuWinningInfo.getIsNewRecord()){//编辑表单保存
			XmuWinningInfo t = this.get(xmuWinningInfo.getId());//从数据库取出记录的值
			try {
				MyBeanUtils.copyBeanNotNull2Bean(xmuWinningInfo, t);
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
				xmuWinningInfo.setXwiUserGrade(re.getXpuUserGrade());
				xmuWinningInfo.setXwiUserProfession(re.getXpuUserProfession());
			}
			xmuWinningInfo.setXwiStatus("1");
			super.save(xmuWinningInfo);//保存
		}
		
		if(StringUtils.isBlank(xmuWinningInfo.getAct().getFlag())) {
			return;
		}
		
		//第一次申请
		if(StringUtils.isBlank(xmuWinningInfo.getAct().getTaskId())){			
			Map<String, Object> vars = Maps.newHashMap();
			//判断角色
			User user=userDao.get(xmuWinningInfo.getCreateBy().getId());
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
			actTaskService.startProcess(ActUtils.PD_XMU_WINNING_INFO[0], ActUtils.PD_XMU_WINNING_INFO[1], xmuWinningInfo.getId(), xmuWinningInfo.getXwiWinningName(),vars);
		
			//更新状态为提交申请
			xmuWinningInfo.setXwiStatus("2");
			dao.updateStatus(xmuWinningInfo);
			
			xmuWinningInfo.setXwiCollegeStandby( ids.toString());
			dao.updateCollegeStandby(xmuWinningInfo);
		}else {
			// 重新编辑申请	
			xmuWinningInfo.getAct().setComment(("yes".equals(xmuWinningInfo.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(xmuWinningInfo.getAct().getFlag())? "1" : "0";
			if("no".equals(xmuWinningInfo.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				xmuWinningInfo.setXwiStatus("1");
				dao.updateStatus(xmuWinningInfo);
			}else{
				//判断角色
				User user=userDao.get(xmuWinningInfo.getCreateBy().getId());
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
				xmuWinningInfo.setXwiStatus("2");
				dao.updateStatus(xmuWinningInfo);
				
				xmuWinningInfo.setXwiCollegeStandby( ids.toString());
				dao.updateCollegeStandby(xmuWinningInfo);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(xmuWinningInfo.getAct().getAssignee())){
				actTaskService.claim(xmuWinningInfo.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(xmuWinningInfo.getAct().getTaskId(), xmuWinningInfo.getAct().getProcInsId(), xmuWinningInfo.getAct().getComment(),xmuWinningInfo.getXwiWinningName(), vars);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuWinningInfo xmuWinningInfo) {
		super.delete(xmuWinningInfo);
	}
	
	@Transactional(readOnly = false)
	public void saveAduit(XmuWinningInfo xmuWinningInfo) {
		
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		xmuWinningInfo.getAct().setComment(("yes".equals(xmuWinningInfo.getAct().getFlag())?"[同意] ":"[驳回] ")+xmuWinningInfo.getAct().getComment());
		
		xmuWinningInfo.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = xmuWinningInfo.getAct().getTaskDefKey();
		
		String pass="";
		String flag=xmuWinningInfo.getAct().getFlag();
		if("yes".equals(flag)){
			pass="1";
		}

		// 审核环节
		if ("mana_audit".equals(taskDefKey)){
			
			xmuWinningInfo.setXwiCollegeComment(xmuWinningInfo.getAct().getComment());
			xmuWinningInfo.setXwiStatus("3");
			dao.updateCollegeComment(xmuWinningInfo);
			
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
			xmuWinningInfo.setXwiManageStandby( ids.toString());
			dao.updateManageStandby(xmuWinningInfo);
			
		}else if ("sys_audit".equals(taskDefKey)){
			xmuWinningInfo.setXwiManageComment(xmuWinningInfo.getAct().getComment());
			xmuWinningInfo.setXwiStatus("5");
			dao.updateManageComment(xmuWinningInfo);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是不通过，更新状态为不通过
		if("reject".equals(xmuWinningInfo.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuWinningInfo.setXwiStatus("4");
				dao.updateStatus(xmuWinningInfo);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuWinningInfo.setXwiStatus("6");
				dao.updateStatus(xmuWinningInfo);
			}
			pass="2";
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(xmuWinningInfo.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuWinningInfo.setXwiStatus("1");
				dao.updateStatus(xmuWinningInfo);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuWinningInfo.setXwiStatus("2");
				dao.updateStatus(xmuWinningInfo);
			}
			pass="0";
		}
		
		// 提交流程任务		
		vars.put("pass",pass);
		if(StringUtils.isBlank(xmuWinningInfo.getAct().getAssignee())){
			actTaskService.claim(xmuWinningInfo.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(xmuWinningInfo.getAct().getTaskId(), xmuWinningInfo.getAct().getProcInsId(), xmuWinningInfo.getAct().getComment(), vars);
		
	}
	
	@Transactional(readOnly = false)
	public void backToEnd(XmuWinningInfo xmuWinningInfo) {
		//更新状态为提交申请
		xmuWinningInfo.setXwiStatus("1");
		dao.updateStatus(xmuWinningInfo);
		
		xmuWinningInfo.setXwiCollegeStandby( "");
		dao.updateCollegeStandby(xmuWinningInfo);
		xmuWinningInfo.setXwiManageStandby( "");
		dao.updateManageStandby(xmuWinningInfo);
		
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "3");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuWinningInfo.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuWinningInfo.setAct(e);
		actTaskService.complete(xmuWinningInfo.getAct().getTaskId(), xmuWinningInfo.getAct().getProcInsId(), "",xmuWinningInfo.getXwiWinningName(), vars);	
	}
	
	@Transactional(readOnly = false)
	public void back(XmuWinningInfo xmuWinningInfo) {
		//更新状态为提交申请
		if(xmuWinningInfo.getXwiStatus().equals("3")){
			xmuWinningInfo.setXwiStatus("2");
			dao.updateStatus(xmuWinningInfo);
		}
		
		xmuWinningInfo.setXwiManageStandby( "");
		dao.updateManageStandby(xmuWinningInfo);
//		actTaskService.taskBack(xmuAcademicEvent.getProcInsId(), null);
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "4");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuWinningInfo.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuWinningInfo.setAct(e);
		actTaskService.complete(xmuWinningInfo.getAct().getTaskId(), xmuWinningInfo.getAct().getProcInsId(), "",xmuWinningInfo.getXwiWinningName(), vars);
	}
}