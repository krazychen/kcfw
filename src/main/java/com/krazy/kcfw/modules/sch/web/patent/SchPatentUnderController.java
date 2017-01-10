/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.patent;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.oa.entity.TestAudit;
import com.krazy.kcfw.modules.sch.entity.contract.SchComConcract;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentAgency;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnder;
import com.krazy.kcfw.modules.sch.service.patent.SchPatentAgencyService;
import com.krazy.kcfw.modules.sch.service.patent.SchPatentUnderService;
import com.krazy.kcfw.modules.sys.entity.Dict;
import com.krazy.kcfw.modules.sys.entity.Office;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.DictUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 发明专利（本科）Controller
 * @author Krazy
 * @version 2016-11-20
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/patent/schPatentUnder")
public class SchPatentUnderController extends BaseController {

	@Autowired
	private SchPatentUnderService schPatentUnderService;
	
	@Autowired
	private SchPatentAgencyService schPatentAgencyService;
	
	@ModelAttribute
	public SchPatentUnder get(@RequestParam(required=false) String id) {
		SchPatentUnder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schPatentUnderService.get(id);
		}
		if (entity == null){
			entity = new SchPatentUnder();
			//entity.setSpuApplySchoolName(UserUtils.getUser().getName());;
		}
		//如果是当前用户是老师
		List<Role> roles=UserUtils.getUser().getRoleList();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			if(StringUtils.isNoneBlank(role.getEnname())&&("PostgraduateStudent".equals(role.getEnname())||"teacher".equals(role.getEnname()))){
				entity.setIsTeacher("true");
				break;
			}
		}
		return entity;
	}
	
	@RequiresPermissions("sch:patent:schPatentUnder:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchPatentUnder schPatentUnder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchPatentUnder> page = schPatentUnderService.findPage(new Page<SchPatentUnder>(request, response), schPatentUnder); 
		model.addAttribute("page", page);
		return "modules/sch/patent/schPatentUnderList";
	}

	@RequiresPermissions("sch:patent:schPatentUnder:view")
	@RequestMapping(value = "form")
	public String form(SchPatentUnder schPatentUnder, Model model) {
		
		String view = "schPatentUnderForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(schPatentUnder.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = schPatentUnder.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(schPatentUnder.getProcInsId())){
				view="schPatentUnderForm";
			}else {
			
				if("1".equals(schPatentUnder.getSpuStatus())){
					view="schPatentUnderForm";
					
				}else if(schPatentUnder.getAct().isFinishTask()){
					// 查看工单
					view = "schPatentUnderFormView";
				}
				// 修改环节
				else if ("modify_audit".equals(taskDefKey)){
					view = "schPatentUnderForm";
				}
				// 审核环节
				else if ("first_audit".equals(taskDefKey)){
					view = "schPatentUnderFormAudit";
				}
				// 审核环节2
				else if ("lead_audit".equals(taskDefKey)){
					view = "schPatentUnderFormAudit";
				}
				// 审核环节3
				else if ("agency_audit".equals(taskDefKey)){
					view = "schPatentUnderFormAudit";
				}else if("apply_end".equals(taskDefKey)){
					view="schPatentUnderFormView";
				}
			}
		}
		
		List<SchPatentAgency> schPatentAgencyList=schPatentAgencyService.findList(new SchPatentAgency());
		
		Map<String,String> schPatentAgencys=new HashMap<String,String>();
		for(SchPatentAgency spa:schPatentAgencyList){
			schPatentAgencys.put(spa.getSpaCode(), spa.getSpaName());
		}
		//判断如果是超级管理员账户，则进入任意修改模式
		User user=UserUtils.getUser();
		if(user.getRoleNames().indexOf("系统管理员")!=-1){
			view="schPatentUnderFormSuper";
		}
				
		model.addAttribute("schPatentAgencyLiss", schPatentAgencys);
		model.addAttribute("schPatentUnder", schPatentUnder);
		return "modules/sch/patent/"+view;
	}

	@RequiresPermissions("sch:patent:schPatentUnder:edit")
	@RequestMapping(value = "save")
	public String save(SchPatentUnder schPatentUnder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schPatentUnder)){
			return form(schPatentUnder, model);
		}
		String flag=schPatentUnder.getAct().getTaskId();
		schPatentUnderService.save(schPatentUnder);
		if("".equals(flag)){
			addMessage(redirectAttributes, "保存专利申报成功");
			return "redirect:"+Global.getAdminPath()+"/sch/patent/schPatentUnder/?repage";
		}else{
			addMessage(redirectAttributes, "提交专利申报成功");
			return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
		}
	}
	
	@RequiresPermissions("sch:patent:schPatentUnder:edit")
	@RequestMapping(value = "saveSuper")
	public String saveSuper(SchPatentUnder schPatentUnder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schPatentUnder)){
			return form(schPatentUnder, model);
		}
		schPatentUnderService.saveSuper(schPatentUnder);
		addMessage(redirectAttributes, "保存专利申报成功");
		return "redirect:"+Global.getAdminPath()+"/sch/patent/schPatentUnder/?repage";
	}
	
	/**
	 * 工单执行（完成任务）
	 * @param testAudit
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sch:patent:schPatentUnder:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(SchPatentUnder schPatentUnder, Model model) {
		if (StringUtils.isBlank(schPatentUnder.getAct().getFlag())
				|| StringUtils.isBlank(schPatentUnder.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(schPatentUnder, model);
		}
		schPatentUnderService.auditSave(schPatentUnder);
		return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
	}
	
	@RequiresPermissions("sch:patent:schPatentUnder:edit")
	@RequestMapping(value = "delete")
	public String delete(SchPatentUnder schPatentUnder, RedirectAttributes redirectAttributes) {
		schPatentUnderService.delete(schPatentUnder);
		addMessage(redirectAttributes, "删除专利申报成功");
		return "redirect:"+Global.getAdminPath()+"/sch/patent/schPatentUnder/?repage";
	}
	
	@RequestMapping(value="getSpaProxyInfo")
	public @ResponseBody SchPatentAgency getSpaProxyInfo(String code){
		return schPatentAgencyService.get(code);
	}

}