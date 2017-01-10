/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.patent;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.act.service.ActTaskService;
import com.krazy.kcfw.modules.act.utils.ActUtils;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnder;
import com.krazy.kcfw.modules.sch.dao.patent.SchPatentUnderDao;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnderInventor;
import com.krazy.kcfw.modules.sch.dao.patent.SchPatentUnderInventorDao;
import com.krazy.kcfw.modules.sys.dao.UserDao;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 发明专利（本科）Service
 * @author Krazy
 * @version 2016-11-20
 */
@Service
@Transactional(readOnly = true)
public class SchPatentUnderService extends CrudService<SchPatentUnderDao, SchPatentUnder> {

	@Autowired
	private SchPatentUnderInventorDao schPatentUnderInventorDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ActTaskService actTaskService;
	
	public SchPatentUnder get(String id) {
		SchPatentUnder schPatentUnder = super.get(id);
		schPatentUnder.setSchPatentUnderInventorList(schPatentUnderInventorDao.findList(new SchPatentUnderInventor(schPatentUnder)));
		return schPatentUnder;
	}
	
	public List<SchPatentUnder> findList(SchPatentUnder schPatentUnder) {
		schPatentUnder.getSqlMap().put("dsf", dataScopeFilter(schPatentUnder.getCurrentUser(), "o", "u"));
		return super.findList(schPatentUnder);
	}
	
	public Page<SchPatentUnder> findPage(Page<SchPatentUnder> page, SchPatentUnder schPatentUnder) {
		schPatentUnder.getSqlMap().put("dsf", dataScopeFilter(schPatentUnder.getCurrentUser(), "o", "u"));
		return super.findPage(page, schPatentUnder);
	}
	
	@Transactional(readOnly = false)
	public void save(SchPatentUnder schPatentUnder) {
		
		if (StringUtils.isBlank(schPatentUnder.getId())){
			schPatentUnder.preInsert();
			schPatentUnder.setSpuStatus("1");
			dao.insert(schPatentUnder);
		}else{
			schPatentUnder.preUpdate();
			dao.update(schPatentUnder);
		}

		for (SchPatentUnderInventor schPatentUnderInventor : schPatentUnder.getSchPatentUnderInventorList()){
			if (schPatentUnderInventor.getId() == null){
				continue;
			}
			if (SchPatentUnderInventor.DEL_FLAG_NORMAL.equals(schPatentUnderInventor.getDelFlag())){
				if (StringUtils.isBlank(schPatentUnderInventor.getId())){
					schPatentUnderInventor.setSpiPatent(schPatentUnder);
					schPatentUnderInventor.preInsert();
					schPatentUnderInventorDao.insert(schPatentUnderInventor);
				}else{
					schPatentUnderInventor.preUpdate();
					schPatentUnderInventorDao.update(schPatentUnderInventor);
				}
			}else{
				schPatentUnderInventorDao.delete(schPatentUnderInventor);
			}
		}
		if(StringUtils.isBlank(schPatentUnder.getAct().getFlag())) {
			return;
		}
		//第一次申请
		if(StringUtils.isBlank(schPatentUnder.getAct().getTaskId())){
			
			Map<String, Object> vars = Maps.newHashMap();
			//获取当前用户的角色
			String pass="0";
			List<Role> roles=UserUtils.getUser().getRoleList();
			for(int i=0;i<roles.size();i++){
				Role role=roles.get(i);
				if(StringUtils.isNoneBlank(role.getEnname())&&"UndergraduateStudents".equals(role.getEnname())){
					pass="0";
					SchPatentUnder underTemp=this.dao.get(schPatentUnder.getId());
					vars.put("teacher", underTemp.getSpuAdvisTeacherLoginName());
					break;
				}
				if(StringUtils.isNoneBlank(role.getEnname())&&("PostgraduateStudent".equals(role.getEnname())||"teacher".equals(role.getEnname()))){
					pass="1";
					
					HashMap<String,String> pars=new HashMap<String,String>();
					pars.put("roleEnName", "DepartmentSecretary");
					User patentUser=userDao.get(schPatentUnder.getCreateBy().getId());
					pars.put("officeId", patentUser.getOffice().getId());
					List<User> users=userDao.findUsersByRoleEnName(pars);
					StringBuffer sec=new StringBuffer();;
					for(int j=0;j<users.size();j++){
						sec.append(users.get(j).getLoginName());
						if(j<users.size()-1){
							sec.append(",");
						}
					}
					vars.put("sec", sec.toString());
					break;
				}
			}
			// 启动流程

			vars.put("pass", pass);
			actTaskService.startProcess(ActUtils.PD_PATENT_APPROVE[0], ActUtils.PD_PATENT_APPROVE[1], schPatentUnder.getId(), schPatentUnder.getSpuName(),vars);
		
			//更新状态为提交申请
			schPatentUnder.setSpuStatus("2");
			dao.updateStatus(schPatentUnder);
		}else {
			// 重新编辑申请	
			//schPatentUnder.getAct().setComment(("yes".equals(schPatentUnder.getAct().getFlag())?"[重新申请] ":"[取消申请] ")+schPatentUnder.getAct().getComment());
			schPatentUnder.getAct().setComment(("yes".equals(schPatentUnder.getAct().getFlag())?"[重新申请] ":"[取消申请] "));

			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(schPatentUnder.getAct().getFlag())? "1" : "0";
			if("no".equals(schPatentUnder.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				schPatentUnder.setSpuStatus("1");
				dao.updateStatus(schPatentUnder);
			}else{
				//获取当前用户的角色
				List<Role> roles=UserUtils.getUser().getRoleList();
				for(int i=0;i<roles.size();i++){
					Role role=roles.get(i);
					if(StringUtils.isNoneBlank(role.getEnname())&&"UndergraduateStudents".equals(role.getEnname())){
						pass="1";
						vars.put("teacher", schPatentUnder.getSpuAdvisTeacherLoginName());
						break;
					}
					if(StringUtils.isNoneBlank(role.getEnname())&&"PostgraduateStudent".equals(role.getEnname())){
						pass="2";
						HashMap<String,String> pars=new HashMap<String,String>();
						pars.put("roleEnName", "DepartmentSecretary");
						User patentUser=userDao.get(schPatentUnder.getCreateBy().getId());
						pars.put("officeId", patentUser.getOffice().getId());
						List<User> users=userDao.findUsersByRoleEnName(pars);					
						StringBuffer sec=new StringBuffer();;
						for(int j=0;j<users.size();j++){
							sec.append(users.get(j).getLoginName());
							if(j<users.size()-1){
								sec.append(",");
							}
						}
						vars.put("sec", sec.toString());
						break;
					}
				}
				//更新状态为提交申请
				schPatentUnder.setSpuStatus("2");
				dao.updateStatus(schPatentUnder);
			}
			vars.put("pass", pass);
			if(StringUtils.isBlank(schPatentUnder.getAct().getAssignee())){
				actTaskService.claim(schPatentUnder.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(schPatentUnder.getAct().getTaskId(), schPatentUnder.getAct().getProcInsId(), schPatentUnder.getAct().getComment(),schPatentUnder.getSpuName(), vars);
		}
//		
//		super.save(schPatentUnder);

	}
	
	@Transactional(readOnly = false)
	public void delete(SchPatentUnder schPatentUnder) {
		super.delete(schPatentUnder);
		schPatentUnderInventorDao.delete(new SchPatentUnderInventor(schPatentUnder));
	}

	@Transactional(readOnly = false)
	public void auditSave(SchPatentUnder schPatentUnder) {
		Map<String, Object> vars = Maps.newHashMap();
		
		// 设置意见
		schPatentUnder.getAct().setComment(("yes".equals(schPatentUnder.getAct().getFlag())?"[同意] ":"[驳回] ")+schPatentUnder.getAct().getComment());
		
		schPatentUnder.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = schPatentUnder.getAct().getTaskDefKey();

		// 审核环节
		if ("first_audit".equals(taskDefKey)){
			schPatentUnder.setFirstText(schPatentUnder.getAct().getComment());
			schPatentUnder.setSpuStatus("3");
			dao.updateFirstText(schPatentUnder);
			
			HashMap<String,String> pars=new HashMap<String,String>();
			pars.put("roleEnName", "DepartmentSecretary");
			User patentUser=userDao.get(schPatentUnder.getCreateBy().getId());
			pars.put("officeId", patentUser.getOffice().getId());
			List<User> users=userDao.findUsersByRoleEnName(pars);
			StringBuffer sec=new StringBuffer();;
			for(int j=0;j<users.size();j++){
				sec.append(users.get(j).getLoginName());
				if(j<users.size()-1){
					sec.append(",");
				}
			}
			vars.put("sec", sec.toString());
		}
		else if ("lead_audit".equals(taskDefKey)){
			schPatentUnder.setLeadText(schPatentUnder.getAct().getComment());
			schPatentUnder.setSpuStatus("4");
			dao.updateLeadText(schPatentUnder);

			vars.put("agency", schPatentUnder.getSpuProxyId());
		}
		else if ("agency_audit".equals(taskDefKey)){
			schPatentUnder.setAgencyText(schPatentUnder.getAct().getComment());
			schPatentUnder.setSpuStatus("5");
			dao.updateAgencyText(schPatentUnder);
		}
		
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(schPatentUnder.getAct().getFlag())){
			schPatentUnder.setSpuStatus("6");
			dao.updateStatus(schPatentUnder);
		}
		// 提交流程任务
		
		vars.put("pass", "yes".equals(schPatentUnder.getAct().getFlag())? "1" : "0");
		if(StringUtils.isBlank(schPatentUnder.getAct().getAssignee())){
			actTaskService.claim(schPatentUnder.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(schPatentUnder.getAct().getTaskId(), schPatentUnder.getAct().getProcInsId(), schPatentUnder.getAct().getComment(), vars);

	}

	public void saveSuper(SchPatentUnder schPatentUnder) {
		// TODO Auto-generated method stub
		this.dao.updateAll(schPatentUnder);
	}
	
}