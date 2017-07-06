/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.service.rep;

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
import com.krazy.kcfw.modules.xmu.entity.rep.XmuReportMnt;
import com.krazy.kcfw.modules.xmu.dao.rep.XmuReportMntDao;

/**
 * 项目汇报管理Service
 * @author Krazy
 * @version 2017-06-03
 */
@Service
@Transactional(readOnly = true)
public class XmuReportMntService extends CrudService<XmuReportMntDao, XmuReportMnt> {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	@Autowired
	private TaskService taskService;
	
	public XmuReportMnt get(String id) {
		return super.get(id);
	}
	
	public List<XmuReportMnt> findList(XmuReportMnt xmuReportMnt) {
		xmuReportMnt.getSqlMap().put("dsf", dataScopeFilter(xmuReportMnt.getCurrentUser(), "o", "u"));
		return super.findList(xmuReportMnt);
	}
	
	public Page<XmuReportMnt> findPage(Page<XmuReportMnt> page, XmuReportMnt xmuReportMnt) {
		xmuReportMnt.getSqlMap().put("dsf", dataScopeFilter(xmuReportMnt.getCurrentUser(), "o", "u"));
		xmuReportMnt.getSqlMap().put("actUser", "or (instr(a.xrm_college_standby,'"+xmuReportMnt.getCurrentUser().getId()+"')>0 )");
		return super.findPage(page, xmuReportMnt);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuReportMnt xmuReportMnt) {
		if(!xmuReportMnt.getIsNewRecord()){//编辑表单保存
			XmuReportMnt t = this.get(xmuReportMnt.getId());//从数据库取出记录的值
			try {
				MyBeanUtils.copyBeanNotNull2Bean(xmuReportMnt, t);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//将编辑表单中的非NULL值覆盖数据库记录中的值
			super.save(t);
		}else{//新增表单保存
			User user=UserUtils.getUser();
			xmuReportMnt.setXrmStatus("1");
			super.save(xmuReportMnt);//保存
		}
		
		if(StringUtils.isBlank(xmuReportMnt.getAct().getFlag())) {
			return;
		}
		
		//第一次申请
		if(StringUtils.isBlank(xmuReportMnt.getAct().getTaskId())){			
			Map<String, Object> vars = Maps.newHashMap();
			//判断角色
			User user=userDao.get(xmuReportMnt.getCreateBy().getId());
			List<Role> roles=UserUtils.getUser().getRoleList();
			StringBuffer ids=new StringBuffer();
			for(int i=0;i<roles.size();i++){
				Role role=roles.get(i);
				if(StringUtils.isNoneBlank(role.getEnname())&&"Manager".equals(role.getEnname())){
					
					//获取院系负责人								
					HashMap<String,String> pars=new HashMap<String,String>();
					pars.put("roleEnName", "RESP");			
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
			}
			
			// 启动流程
			//vars.put("pass", pass);
			actTaskService.startProcess(ActUtils.PD_XMU_REPORT_MNT[0], ActUtils.PD_XMU_REPORT_MNT[1], xmuReportMnt.getId(), xmuReportMnt.getXrmProjName(),vars);
		
			//更新状态为提交申请
			xmuReportMnt.setXrmStatus("2");
			dao.updateStatus(xmuReportMnt);
			
			xmuReportMnt.setXrmCollegeStandby( ids.toString());
			dao.updateCollegeStandby(xmuReportMnt);
		}else {
			// 重新编辑申请	
			xmuReportMnt.getAct().setComment(("yes".equals(xmuReportMnt.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(xmuReportMnt.getAct().getFlag())? "1" : "0";
			if("no".equals(xmuReportMnt.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				xmuReportMnt.setXrmStatus("1");
				dao.updateStatus(xmuReportMnt);
			}else{
				//判断角色
				User user=userDao.get(xmuReportMnt.getCreateBy().getId());
				List<Role> roles=UserUtils.getUser().getRoleList();
				StringBuffer ids=new StringBuffer();
				for(int i=0;i<roles.size();i++){
					Role role=roles.get(i);
					if(StringUtils.isNoneBlank(role.getEnname())&&"Manager".equals(role.getEnname())){
						
						//获取院系负责人								
						HashMap<String,String> pars=new HashMap<String,String>();
						pars.put("roleEnName", "RESP");			
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
				}
				//更新状态为提交申请
				xmuReportMnt.setXrmStatus("2");
				dao.updateStatus(xmuReportMnt);
				
				xmuReportMnt.setXrmCollegeStandby( ids.toString());
				dao.updateCollegeStandby(xmuReportMnt);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(xmuReportMnt.getAct().getAssignee())){
				actTaskService.claim(xmuReportMnt.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(xmuReportMnt.getAct().getTaskId(), xmuReportMnt.getAct().getProcInsId(), xmuReportMnt.getAct().getComment(),xmuReportMnt.getXrmProjName(), vars);
		}
//		super.save(xmuReportMnt);
	}
	
	@Transactional(readOnly = false)
	public void backToEnd(XmuReportMnt xmuReportMnt) {
		//更新状态为提交申请
		xmuReportMnt.setXrmStatus("1");
		dao.updateStatus(xmuReportMnt);
		
		xmuReportMnt.setXrmCollegeStandby( "");
		dao.updateCollegeStandby(xmuReportMnt);
		xmuReportMnt.setXrmManageStandby( "");
		dao.updateManageStandby(xmuReportMnt);
		
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "3");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuReportMnt.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuReportMnt.setAct(e);
		actTaskService.complete(xmuReportMnt.getAct().getTaskId(), xmuReportMnt.getAct().getProcInsId(), "",xmuReportMnt.getXrmProjName(), vars);
	}
	
	@Transactional(readOnly = false)
	public void back(XmuReportMnt xmuReportMnt) {
		//更新状态为提交申请
		if(xmuReportMnt.getXrmStatus().equals("3")){
			xmuReportMnt.setXrmStatus("2");
			dao.updateStatus(xmuReportMnt);
		}
		
		xmuReportMnt.setXrmManageStandby( "");
		dao.updateManageStandby(xmuReportMnt);
//		actTaskService.taskBack(xmuReportMnt.getProcInsId(), null);
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "4");
	
		Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuReportMnt.getProcInsId()).singleResult();
		Act e = new Act();
		e.setTask(xaeTask);
		e.setVars(xaeTask.getProcessVariables());
		e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
		xmuReportMnt.setAct(e);
		actTaskService.complete(xmuReportMnt.getAct().getTaskId(), xmuReportMnt.getAct().getProcInsId(), "",xmuReportMnt.getXrmProjName(), vars);

	}
	
	@Transactional(readOnly = false)
	public void saveAduit(XmuReportMnt xmuReportMnt) {
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		xmuReportMnt.getAct().setComment(("yes".equals(xmuReportMnt.getAct().getFlag())?"[同意] ":"[驳回] ")+xmuReportMnt.getAct().getComment());
		
		xmuReportMnt.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = xmuReportMnt.getAct().getTaskDefKey();
		
		String pass="";
		String flag=xmuReportMnt.getAct().getFlag();
		if("yes".equals(flag)){
			pass="1";
		}

		// 审核环节
		if ("mana_audit".equals(taskDefKey)){
			
			xmuReportMnt.setXrmCollegeComment(xmuReportMnt.getAct().getComment());
			xmuReportMnt.setXrmStatus("3");
			dao.updateCollegeComment(xmuReportMnt);
			
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
			xmuReportMnt.setXrmManageStandby( ids.toString());
			dao.updateManageStandby(xmuReportMnt);
			
		}else if ("sys_audit".equals(taskDefKey)){
			xmuReportMnt.setXrmManageComment(xmuReportMnt.getAct().getComment());
			xmuReportMnt.setXrmStatus("5");
			dao.updateManageComment(xmuReportMnt);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是不通过，更新状态为不通过
		if("reject".equals(xmuReportMnt.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuReportMnt.setXrmStatus("4");
				dao.updateStatus(xmuReportMnt);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuReportMnt.setXrmStatus("6");
				dao.updateStatus(xmuReportMnt);
			}
			pass="2";
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(xmuReportMnt.getAct().getFlag())){
			if ("mana_audit".equals(taskDefKey)){
				xmuReportMnt.setXrmStatus("1");
				dao.updateStatus(xmuReportMnt);
			}else if ("sys_audit".equals(taskDefKey)){
				xmuReportMnt.setXrmStatus("2");
				dao.updateStatus(xmuReportMnt);
			}
			pass="0";
		}
		
		// 提交流程任务		
		vars.put("pass",pass);
		if(StringUtils.isBlank(xmuReportMnt.getAct().getAssignee())){
			actTaskService.claim(xmuReportMnt.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(xmuReportMnt.getAct().getTaskId(), xmuReportMnt.getAct().getProcInsId(), xmuReportMnt.getAct().getComment(), vars);

	}
	
	@Transactional(readOnly = false)
	public void delete(XmuReportMnt xmuReportMnt) {
		super.delete(xmuReportMnt);
	}
	
	
}