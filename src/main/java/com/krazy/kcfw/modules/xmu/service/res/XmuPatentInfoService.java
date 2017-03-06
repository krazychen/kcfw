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
import com.krazy.kcfw.modules.xmu.entity.res.XmuPatentInfo;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectStudentDao;
import com.krazy.kcfw.modules.xmu.dao.res.XmuPatentInfoDao;

/**
 * 专利信息Service
 * @author Krazy
 * @version 2017-03-06
 */
@Service
@Transactional(readOnly = true)
public class XmuPatentInfoService extends CrudService<XmuPatentInfoDao, XmuPatentInfo> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private XmuProjectStudentDao xmuProjectStudentDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	@Autowired
	private TaskService taskService;
	
	public XmuPatentInfo get(String id) {
		return super.get(id);
	}
	
	public List<XmuPatentInfo> findList(XmuPatentInfo xmuPatentInfo) {
		xmuPatentInfo.getSqlMap().put("dsf", dataScopeFilter(xmuPatentInfo.getCurrentUser(), "o", "u"));
		return super.findList(xmuPatentInfo);
	}
	
	public Page<XmuPatentInfo> findPage(Page<XmuPatentInfo> page, XmuPatentInfo xmuPatentInfo) {
		xmuPatentInfo.getSqlMap().put("dsf", dataScopeFilter(xmuPatentInfo.getCurrentUser(), "o", "u"));
		xmuPatentInfo.getSqlMap().put("actUser", "or (instr(a.xpi_college_standby,'"+xmuPatentInfo.getCurrentUser().getId()+"')>0 )");
		return super.findPage(page, xmuPatentInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuPatentInfo xmuPatentInfo) {
		if(!xmuPatentInfo.getIsNewRecord()){//编辑表单保存
			XmuPatentInfo t = this.get(xmuPatentInfo.getId());//从数据库取出记录的值
			try {
				MyBeanUtils.copyBeanNotNull2Bean(xmuPatentInfo, t);
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
				xmuPatentInfo.setXpiUserGrade(re.getXpuUserGrade());
				xmuPatentInfo.setXpiUserProfession(re.getXpuUserProfession());
			}
			xmuPatentInfo.setXpiStatus("1");
			super.save(xmuPatentInfo);//保存
		}
		
		if(StringUtils.isBlank(xmuPatentInfo.getAct().getFlag())) {
			return;
		}
		
		//第一次申请
		if(StringUtils.isBlank(xmuPatentInfo.getAct().getTaskId())){			
			Map<String, Object> vars = Maps.newHashMap();
			//判断角色
			User user=userDao.get(xmuPatentInfo.getCreateBy().getId());
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
			actTaskService.startProcess(ActUtils.PD_XMU_PATENT_INFO[0], ActUtils.PD_XMU_PATENT_INFO[1], xmuPatentInfo.getId(), xmuPatentInfo.getXpiPatentName(),vars);
		
			//更新状态为提交申请
			xmuPatentInfo.setXpiStatus("2");
			dao.updateStatus(xmuPatentInfo);
			
			xmuPatentInfo.setXpiCollegeStandby( ids.toString());
			dao.updateCollegeStandby(xmuPatentInfo);
		}else {
			// 重新编辑申请	
			xmuPatentInfo.getAct().setComment(("yes".equals(xmuPatentInfo.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(xmuPatentInfo.getAct().getFlag())? "1" : "0";
			if("no".equals(xmuPatentInfo.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				xmuPatentInfo.setXpiStatus("1");
				dao.updateStatus(xmuPatentInfo);
			}else{
				//判断角色
				User user=userDao.get(xmuPatentInfo.getCreateBy().getId());
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
				xmuPatentInfo.setXpiStatus("2");
				dao.updateStatus(xmuPatentInfo);
				
				xmuPatentInfo.setXpiCollegeStandby( ids.toString());
				dao.updateCollegeStandby(xmuPatentInfo);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(xmuPatentInfo.getAct().getAssignee())){
				actTaskService.claim(xmuPatentInfo.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(xmuPatentInfo.getAct().getTaskId(), xmuPatentInfo.getAct().getProcInsId(), xmuPatentInfo.getAct().getComment(),xmuPatentInfo.getXpiPatentName(), vars);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuPatentInfo xmuPatentInfo) {
		super.delete(xmuPatentInfo);
	}

	public void saveAduit(XmuPatentInfo xmuPatentInfo) {
		
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		xmuPatentInfo.getAct().setComment(("yes".equals(xmuPatentInfo.getAct().getFlag())?"[同意] ":"[驳回] ")+xmuPatentInfo.getAct().getComment());
		
		xmuPatentInfo.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = xmuPatentInfo.getAct().getTaskDefKey();
		
		String pass="";
		String flag=xmuPatentInfo.getAct().getFlag();
		if("yes".equals(flag)){
			pass="1";
		}

		// 审核环节
		if ("mana_audit".equals(taskDefKey)){
			
			xmuPatentInfo.setXpiCollegeComment(xmuPatentInfo.getAct().getComment());
			xmuPatentInfo.setXpiStatus("3");
			dao.updateCollegeComment(xmuPatentInfo);
			
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
			xmuPatentInfo.setXpiManageStandby( ids.toString());
			dao.updateManageStandby(xmuPatentInfo);
			
		}else if ("sys_audit".equals(taskDefKey)){
			xmuPatentInfo.setXpiManageComment(xmuPatentInfo.getAct().getComment());
			xmuPatentInfo.setXpiStatus("5");
			dao.updateManageComment(xmuPatentInfo);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是不通过，更新状态为不通过
		if("reject".equals(xmuPatentInfo.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuPatentInfo.setXpiStatus("4");
				dao.updateStatus(xmuPatentInfo);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuPatentInfo.setXpiStatus("6");
				dao.updateStatus(xmuPatentInfo);
			}
			pass="2";
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(xmuPatentInfo.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuPatentInfo.setXpiStatus("1");
				dao.updateStatus(xmuPatentInfo);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuPatentInfo.setXpiStatus("2");
				dao.updateStatus(xmuPatentInfo);
			}
			pass="0";
		}
		
		// 提交流程任务		
		vars.put("pass",pass);
		if(StringUtils.isBlank(xmuPatentInfo.getAct().getAssignee())){
			actTaskService.claim(xmuPatentInfo.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(xmuPatentInfo.getAct().getTaskId(), xmuPatentInfo.getAct().getProcInsId(), xmuPatentInfo.getAct().getComment(), vars);

	}

	public void backToEnd(XmuPatentInfo xmuPatentInfo) {
		//更新状态为提交申请
		xmuPatentInfo.setXpiStatus("1");
		dao.updateStatus(xmuPatentInfo);
		
		xmuPatentInfo.setXpiCollegeStandby( "");
		dao.updateCollegeStandby(xmuPatentInfo);
		xmuPatentInfo.setXpiManageStandby( "");
		dao.updateManageStandby(xmuPatentInfo);
		
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "3");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuPatentInfo.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuPatentInfo.setAct(e);
		actTaskService.complete(xmuPatentInfo.getAct().getTaskId(), xmuPatentInfo.getAct().getProcInsId(), "",xmuPatentInfo.getXpiPatentName(), vars);	

		
	}

	public void back(XmuPatentInfo xmuPatentInfo) {
		//更新状态为提交申请
		if(xmuPatentInfo.getXpiStatus().equals("3")){
			xmuPatentInfo.setXpiStatus("2");
			dao.updateStatus(xmuPatentInfo);
		}
		
		xmuPatentInfo.setXpiManageStandby( "");
		dao.updateManageStandby(xmuPatentInfo);
//				actTaskService.taskBack(xmuAcademicEvent.getProcInsId(), null);
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "4");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuPatentInfo.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuPatentInfo.setAct(e);
		actTaskService.complete(xmuPatentInfo.getAct().getTaskId(), xmuPatentInfo.getAct().getProcInsId(), "",xmuPatentInfo.getXpiPatentName(), vars);

		
	}
	
	
}