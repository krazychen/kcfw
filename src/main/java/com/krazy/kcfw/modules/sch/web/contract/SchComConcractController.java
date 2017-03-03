/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.contract;

import java.util.List;

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

import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.sch.entity.contract.SchComConcract;
import com.krazy.kcfw.modules.sch.service.contract.SchComConcractService;
import com.krazy.kcfw.modules.sys.entity.Dict;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.DictUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 普通合同Controller
 * @author Krazy
 * @version 2016-11-27
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/contract/schComConcract")
public class SchComConcractController extends BaseController {

	@Autowired
	private SchComConcractService schComConcractService;
	
	@ModelAttribute
	public SchComConcract get(@RequestParam(required=false) String id) {
		SchComConcract entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schComConcractService.get(id);
		}
		if (entity == null){
			entity = new SchComConcract();
		}
		return entity;
	}
	
	@RequiresPermissions("sch:contract:schComConcract:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchComConcract schComConcract, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchComConcract> page = schComConcractService.findPage(new Page<SchComConcract>(request, response), schComConcract); 
		model.addAttribute("page", page);
		return "modules/sch/contract/schComConcractList";
	}
	
	@RequiresPermissions("sch:contract:schComConcract:view")
	@RequestMapping(value = {"listSuper"})
	public String listSuper(SchComConcract schComConcract, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchComConcract> page = schComConcractService.findPage(new Page<SchComConcract>(request, response), schComConcract); 
		model.addAttribute("page", page);
		return "modules/sch/contract/schComConcractListSuper";
	}
	
	@RequiresPermissions("sch:contract:schComConcract:view")
	@RequestMapping(value = "formSuper")
	public String formSuper(SchComConcract schComConcract, Model model) {

		String view="schComConcractFormSuper";
		
		model.addAttribute("schComConcract", schComConcract);
		String resType=schComConcract.getSccResearchType();
		List<Dict> dicts=DictUtils.getDictList("CONTRACT_RESEARCH_TYPE_SUB"+resType);
		model.addAttribute("dicts", dicts);
		model.addAttribute("resTypeSub",DictUtils.getDictLabel(schComConcract.getSccResearchTypeSub(), "CONTRACT_RESEARCH_TYPE_SUB"+resType, ""));
		return "modules/sch/contract/"+view;
	}

	@RequiresPermissions("sch:contract:schComConcract:view")
	@RequestMapping(value = "form")
	public String form(SchComConcract schComConcract, Model model) {

		String view = "schComConcractForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(schComConcract.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = schComConcract.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(schComConcract.getProcInsId())){
				view="schComConcractForm";
			}else {
			
				if("1".equals(schComConcract.getSccStatus())){
					view="schComConcractForm";
					
				}else if(schComConcract.getAct().isFinishTask()){
					// 查看工单
					view = "schComConcractFormView";
				}
				// 修改环节
				else if ("modify_audit".equals(taskDefKey)){
					view = "schComConcractForm";
				}
				// 院系秘书审核环节
				else if ("teacher_audit".equals(taskDefKey)){
					view = "schComConcractFormAudit";
				}
				// 科研负责人审核环节
				else if ("resp_audit".equals(taskDefKey)){
					view = "schComConcractFormAudit";
				}
				// 合同管理员审核环节
				else if ("mana_audit".equals(taskDefKey)){
					view = "schComConcractFormAudit";
				}
				// 处长审核环节
				else if ("direct_audit".equals(taskDefKey)){
					view = "schComConcractFormAudit";
				}
				// 副处长审核环节
				else if ("ddirect_audit".equals(taskDefKey)){
					view = "schComConcractFormAudit";
				}else if("apply_end".equals(taskDefKey)){
					view="schComConcractFormView";
				}
			}
		}
		
		//判断如果是超级管理员账户，则进入任意修改模式
		User user=UserUtils.getUser();
		if(user.getRoleNames().indexOf("系统管理员")!=-1){
			view="schComConcractFormSuper";
		}
		
		model.addAttribute("schComConcract", schComConcract);
		String resType=schComConcract.getSccResearchType();
		List<Dict> dicts=DictUtils.getDictList("CONTRACT_RESEARCH_TYPE_SUB"+resType);
		model.addAttribute("dicts", dicts);
		model.addAttribute("resTypeSub",DictUtils.getDictLabel(schComConcract.getSccResearchTypeSub(), "CONTRACT_RESEARCH_TYPE_SUB"+resType, ""));
		return "modules/sch/contract/"+view;
	}

	@RequiresPermissions("sch:contract:schComConcract:edit")
	@RequestMapping(value = "save")
	public String save(SchComConcract schComConcract, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schComConcract)){
			return form(schComConcract, model);
		}
		String flag=schComConcract.getAct().getTaskId();
		schComConcractService.save(schComConcract);
		if("".equals(flag)){
			addMessage(redirectAttributes, "保存合同成功");
			return "redirect:"+Global.getAdminPath()+"/sch/contract/schComConcract/?repage";
		}else{
			addMessage(redirectAttributes, "提交合同审批成功");
			return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
		}
	}
	
	@RequiresPermissions("sch:contract:schComConcract:edit")
	@RequestMapping(value = "saveSuper")
	public String saveSuper(SchComConcract schComConcract, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schComConcract)){
			return form(schComConcract, model);
		}
		schComConcractService.saveSuper(schComConcract);
		addMessage(redirectAttributes, "保存合同成功");
		return "redirect:"+Global.getAdminPath()+"/sch/contract/schComConcract/?repage";
	}
	
	/**
	 * 工单执行（完成任务）
	 * @param testAudit
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sch:contract:schComConcract:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(SchComConcract schComConcract, Model model) {
		if (StringUtils.isBlank(schComConcract.getAct().getFlag())
				|| StringUtils.isBlank(schComConcract.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(schComConcract, model);
		}
		schComConcractService.auditSave(schComConcract);
		return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
	}
	
	@RequiresPermissions("sch:contract:schComConcract:edit")
	@RequestMapping(value = "delete")
	public String delete(SchComConcract schComConcract, RedirectAttributes redirectAttributes) {
		schComConcractService.delete(schComConcract);
		addMessage(redirectAttributes, "删除合同成功");
		return "redirect:"+Global.getAdminPath()+"/sch/contract/schComConcract/?repage";
	}
	
	@RequestMapping(value="getResTypeSub")
	public @ResponseBody List<Dict> getResTypeSub(String type){
		return DictUtils.getDictList("CONTRACT_RESEARCH_TYPE_SUB"+type);
	}

}