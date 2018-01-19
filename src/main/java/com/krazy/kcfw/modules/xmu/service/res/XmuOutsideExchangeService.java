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
import com.krazy.kcfw.modules.xmu.entity.res.XmuOutsideExchange;
import com.krazy.kcfw.modules.xmu.entity.res.XmuPatentInfo;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectStudentDao;
import com.krazy.kcfw.modules.xmu.dao.res.XmuOutsideExchangeDao;

/**
 * 校外交流Service
 * @author Krazy
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class XmuOutsideExchangeService extends CrudService<XmuOutsideExchangeDao, XmuOutsideExchange> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private XmuProjectStudentDao xmuProjectStudentDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	@Autowired
	private TaskService taskService;
	
	public XmuOutsideExchange get(String id) {
		return super.get(id);
	}
	
	public List<XmuOutsideExchange> findList(XmuOutsideExchange xmuOutsideExchange) {
		xmuOutsideExchange.getSqlMap().put("dsf", dataScopeFilter(xmuOutsideExchange.getCurrentUser(), "o", "u"));
		return super.findList(xmuOutsideExchange);
	}
	
	public Page<XmuOutsideExchange> findPage(Page<XmuOutsideExchange> page, XmuOutsideExchange xmuOutsideExchange) {
		xmuOutsideExchange.getSqlMap().put("dsf", dataScopeFilter(xmuOutsideExchange.getCurrentUser(), "o", "u"));
		xmuOutsideExchange.getSqlMap().put("actUser", "or (instr(a.xoe_college_standby,'"+xmuOutsideExchange.getCurrentUser().getId()+"')>0 ");
		xmuOutsideExchange.getSqlMap().put("actUser2", " )");
		return super.findPage(page, xmuOutsideExchange);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuOutsideExchange xmuOutsideExchange) {
		
		if(!xmuOutsideExchange.getIsNewRecord()){//编辑表单保存
			XmuOutsideExchange t = this.get(xmuOutsideExchange.getId());//从数据库取出记录的值
			try {
				MyBeanUtils.copyBeanNotNull2Bean(xmuOutsideExchange, t);
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
				xmuOutsideExchange.setXoeUserGrade(re.getXpuUserGrade());
				xmuOutsideExchange.setXoeUserProfession(re.getXpuUserProfession());
			}
			xmuOutsideExchange.setXoeStatus("1");
			super.save(xmuOutsideExchange);//保存
		}
		
		if(StringUtils.isBlank(xmuOutsideExchange.getAct().getFlag())) {
			return;
		}
		
		//第一次申请
		if(StringUtils.isBlank(xmuOutsideExchange.getAct().getTaskId())){			
			Map<String, Object> vars = Maps.newHashMap();
			//判断角色
			User user=userDao.get(xmuOutsideExchange.getCreateBy().getId());
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
			actTaskService.startProcess(ActUtils.PD_XMU_OUTSIDE_EXCHANGE[0], ActUtils.PD_XMU_OUTSIDE_EXCHANGE[1], xmuOutsideExchange.getId(), xmuOutsideExchange.getXoeExchangeSchool(),vars);
		
			//更新状态为提交申请
			xmuOutsideExchange.setXoeStatus("2");
			dao.updateStatus(xmuOutsideExchange);
			
			xmuOutsideExchange.setXoeCollegeStandby( ids.toString());
			dao.updateCollegeStandby(xmuOutsideExchange);
		}else {
			// 重新编辑申请	
			xmuOutsideExchange.getAct().setComment(("yes".equals(xmuOutsideExchange.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(xmuOutsideExchange.getAct().getFlag())? "1" : "0";
			if("no".equals(xmuOutsideExchange.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				xmuOutsideExchange.setXoeStatus("1");
				dao.updateStatus(xmuOutsideExchange);
			}else{
				//判断角色
				User user=userDao.get(xmuOutsideExchange.getCreateBy().getId());
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
				xmuOutsideExchange.setXoeStatus("2");
				dao.updateStatus(xmuOutsideExchange);
				
				xmuOutsideExchange.setXoeCollegeStandby( ids.toString());
				dao.updateCollegeStandby(xmuOutsideExchange);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(xmuOutsideExchange.getAct().getAssignee())){
				actTaskService.claim(xmuOutsideExchange.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(xmuOutsideExchange.getAct().getTaskId(), xmuOutsideExchange.getAct().getProcInsId(), xmuOutsideExchange.getAct().getComment(),xmuOutsideExchange.getXoeExchangeSchool(), vars);
		}
	}
	
	@Transactional(readOnly = false)
	public void saveAduit(XmuOutsideExchange xmuOutsideExchange) {
		
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		xmuOutsideExchange.getAct().setComment(("yes".equals(xmuOutsideExchange.getAct().getFlag())?"[同意] ":"[驳回] ")+xmuOutsideExchange.getAct().getComment());
		
		xmuOutsideExchange.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = xmuOutsideExchange.getAct().getTaskDefKey();
		
		String pass="";
		String flag=xmuOutsideExchange.getAct().getFlag();
		if("yes".equals(flag)){
			pass="1";
		}

		// 审核环节
		if ("mana_audit".equals(taskDefKey)){
			
			xmuOutsideExchange.setXoeCollegeComment(xmuOutsideExchange.getAct().getComment());
			xmuOutsideExchange.setXoeStatus("3");
			dao.updateCollegeComment(xmuOutsideExchange);
			
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
			xmuOutsideExchange.setXoeManageStandby( ids.toString());
			dao.updateManageStandby(xmuOutsideExchange);
			
		}else if ("sys_audit".equals(taskDefKey)){
			xmuOutsideExchange.setXoeManageComment(xmuOutsideExchange.getAct().getComment());
			xmuOutsideExchange.setXoeStatus("5");
			dao.updateManageComment(xmuOutsideExchange);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是不通过，更新状态为不通过
		if("reject".equals(xmuOutsideExchange.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuOutsideExchange.setXoeStatus("4");
				dao.updateStatus(xmuOutsideExchange);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuOutsideExchange.setXoeStatus("6");
				dao.updateStatus(xmuOutsideExchange);
			}
			pass="2";
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(xmuOutsideExchange.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuOutsideExchange.setXoeStatus("1");
				dao.updateStatus(xmuOutsideExchange);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuOutsideExchange.setXoeStatus("2");
				dao.updateStatus(xmuOutsideExchange);
			}
			pass="0";
		}
		
		// 提交流程任务		
		vars.put("pass",pass);
		if(StringUtils.isBlank(xmuOutsideExchange.getAct().getAssignee())){
			actTaskService.claim(xmuOutsideExchange.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(xmuOutsideExchange.getAct().getTaskId(), xmuOutsideExchange.getAct().getProcInsId(), xmuOutsideExchange.getAct().getComment(), vars);

	}

	@Transactional(readOnly = false)
	public void backToEnd(XmuOutsideExchange xmuOutsideExchange) {
		//更新状态为提交申请
		xmuOutsideExchange.setXoeStatus("1");
		dao.updateStatus(xmuOutsideExchange);
		
		xmuOutsideExchange.setXoeCollegeStandby( "");
		dao.updateCollegeStandby(xmuOutsideExchange);
		xmuOutsideExchange.setXoeManageStandby( "");
		dao.updateManageStandby(xmuOutsideExchange);
		
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "3");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuOutsideExchange.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuOutsideExchange.setAct(e);
		actTaskService.complete(xmuOutsideExchange.getAct().getTaskId(), xmuOutsideExchange.getAct().getProcInsId(), "",xmuOutsideExchange.getXoeExchangeSchool(), vars);	

		
	}

	@Transactional(readOnly = false)
	public void back(XmuOutsideExchange xmuOutsideExchange) {
		//更新状态为提交申请
		if(xmuOutsideExchange.getXoeStatus().equals("3")){
			xmuOutsideExchange.setXoeStatus("2");
			dao.updateStatus(xmuOutsideExchange);
		}
		
		xmuOutsideExchange.setXoeManageStandby( "");
		dao.updateManageStandby(xmuOutsideExchange);
//				actTaskService.taskBack(xmuAcademicEvent.getProcInsId(), null);
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "4");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuOutsideExchange.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuOutsideExchange.setAct(e);
		actTaskService.complete(xmuOutsideExchange.getAct().getTaskId(), xmuOutsideExchange.getAct().getProcInsId(), "",xmuOutsideExchange.getXoeExchangeSchool(), vars);

		
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuOutsideExchange xmuOutsideExchange) {
		super.delete(xmuOutsideExchange);
	}
	
	
}