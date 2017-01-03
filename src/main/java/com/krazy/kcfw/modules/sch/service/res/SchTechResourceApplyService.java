/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.res;

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
import com.krazy.kcfw.modules.sch.entity.res.SchTechResource;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResourceApply;
import com.krazy.kcfw.modules.sch.dao.res.SchTechResourceApplyDao;
import com.krazy.kcfw.modules.sch.dao.res.SchTechResourceDao;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 科研资源申请Service
 * @author Krazy
 * @version 2016-12-14
 */
@Service
@Transactional(readOnly = true)
public class SchTechResourceApplyService extends CrudService<SchTechResourceApplyDao, SchTechResourceApply> {

	@Autowired
	private ActTaskService actTaskService;
	
	@Autowired
	private SchTechResourceDao schTechResourceDao;
	
	public SchTechResourceApply get(String id) {
		return super.get(id);
	}
	
	public List<SchTechResourceApply> findList(SchTechResourceApply schTechResourceApply) {
		schTechResourceApply.getSqlMap().put("dsf", dataScopeFilter(schTechResourceApply.getCurrentUser(), "o", "u"));
		return super.findList(schTechResourceApply);
	}
	
	public List<SchTechResourceApply> findListWithoutPer(SchTechResourceApply schTechResourceApply) {
		return super.findList(schTechResourceApply);
	}
	
	public Page<SchTechResourceApply> findPage(Page<SchTechResourceApply> page, SchTechResourceApply schTechResourceApply) {
		schTechResourceApply.getSqlMap().put("dsf", dataScopeFilter(schTechResourceApply.getCurrentUser(), "o", "u"));
		return super.findPage(page, schTechResourceApply);
	}
	
	@Transactional(readOnly = false)
	public void save(SchTechResourceApply schTechResourceApply) {
		if (StringUtils.isBlank(schTechResourceApply.getId())){
			schTechResourceApply.preInsert();
			schTechResourceApply.setScaApplyStatus("1");
			dao.insert(schTechResourceApply);
		}else{
			schTechResourceApply.preUpdate();
			dao.update(schTechResourceApply);
		}
		
//		if(StringUtils.isBlank(schTechResourceApply.getAct().getFlag())) {
//			return;
//		}
//		
		//第一次申请
		if(StringUtils.isBlank(schTechResourceApply.getAct().getTaskId())){
			
			Map<String, Object> vars = Maps.newHashMap();
			//获取资源的所有者
			SchTechResource str=schTechResourceDao.get(schTechResourceApply.getScaSchId());
			User owner=UserUtils.get(str.getStrUserId());
			vars.put("owner",owner.getLoginName() );
			// 启动流程
			//vars.put("pass", pass);
			actTaskService.startProcess(ActUtils.PD_TECH_RES[0], ActUtils.PD_TECH_RES[1], schTechResourceApply.getId(),"科研资源:"+str.getStrName()+"预约申请，预定时段："+ schTechResourceApply.getScaApplyDate()+" "+schTechResourceApply.getScaApplyTimeRange(),vars);
		
		}else {
			// 重新编辑申请	
			schTechResourceApply.getAct().setComment(("yes".equals(schTechResourceApply.getAct().getFlag())?"[重新申请] ":"[取消申请] "));
			
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			String pass="yes".equals(schTechResourceApply.getAct().getFlag())? "1" : "0";
			if("no".equals(schTechResourceApply.getAct().getFlag())){
				pass="0";
				//取消提交后更新状态为新增
				schTechResourceApply.setScaApplyStatus("1");
				dao.updateStatus(schTechResourceApply);
			}
			//获取资源的所有者
			SchTechResource str=schTechResourceDao.get(schTechResourceApply.getScaSchId());
			vars.put("owner", str.getStrUserId());
			
			vars.put("pass", pass);
			if(StringUtils.isBlank(schTechResourceApply.getAct().getAssignee())){
				actTaskService.claim(schTechResourceApply.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
			}
			actTaskService.complete(schTechResourceApply.getAct().getTaskId(), schTechResourceApply.getAct().getProcInsId(), schTechResourceApply.getAct().getComment(),"科研资源:"+str.getStrName()+"预约申请，预定时段："+ schTechResourceApply.getScaApplyDate()+" "+schTechResourceApply.getScaApplyTimeRange(), vars);
		}
		//super.save(schTechResourceApply);
	}
	
	@Transactional(readOnly = false)
	public void delete(SchTechResourceApply schTechResourceApply) {
		super.delete(schTechResourceApply);
	}
	
	@Transactional(readOnly = false)
	public void auditSave(SchTechResourceApply schTechResourceApply) {
		Map<String, Object> vars = Maps.newHashMap();
		
		schTechResourceApply.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = schTechResourceApply.getAct().getTaskDefKey();
		
		String pass= "yes".equals(schTechResourceApply.getAct().getFlag())? "1" : "0";

		// 接受环节
		if ("receive".equals(taskDefKey)){
			// 设置意见
			schTechResourceApply.getAct().setComment(("yes".equals(schTechResourceApply.getAct().getFlag())?"[已同意] ":"[拒绝] ")+schTechResourceApply.getAct().getComment());
			schTechResourceApply.setScaApplyComment(schTechResourceApply.getAct().getComment());
			schTechResourceApply.setScaApplyStatus("2");
			dao.updateApplyComment(schTechResourceApply);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		
		//如果是驳回，更新状态为驳回
		if("no".equals(schTechResourceApply.getAct().getFlag())){
			schTechResourceApply.setScaApplyStatus("3");
			dao.updateStatus(schTechResourceApply);
		}
		// 提交流程任务
		
		vars.put("pass",pass);
		if(StringUtils.isBlank(schTechResourceApply.getAct().getAssignee())){
			actTaskService.claim(schTechResourceApply.getAct().getTaskId(),  UserUtils.getUser().getLoginName());
		}
		actTaskService.complete(schTechResourceApply.getAct().getTaskId(), schTechResourceApply.getAct().getProcInsId(), schTechResourceApply.getAct().getComment(), vars);

	}
	
}