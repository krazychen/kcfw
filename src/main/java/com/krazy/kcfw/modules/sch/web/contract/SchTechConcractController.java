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
import com.krazy.kcfw.modules.sch.entity.contract.SchTechConcract;
import com.krazy.kcfw.modules.sch.service.contract.SchTechConcractService;
import com.krazy.kcfw.modules.sys.entity.Dict;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.DictUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 技贸合同Controller
 * @author Krazy
 * @version 2016-11-27
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/contract/schTechConcract")
public class SchTechConcractController extends BaseController {

	@Autowired
	private SchTechConcractService schTechConcractService;
	
	@ModelAttribute
	public SchTechConcract get(@RequestParam(required=false) String id) {
		SchTechConcract entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schTechConcractService.get(id);
		}
		if (entity == null){
			entity = new SchTechConcract();
		}
		return entity;
	}
	
	@RequiresPermissions("sch:contract:schTechConcract:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchTechConcract schTechConcract, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchTechConcract> page = schTechConcractService.findPage(new Page<SchTechConcract>(request, response), schTechConcract); 
		model.addAttribute("page", page);
		return "modules/sch/contract/schTechConcractList";
	}

	@RequiresPermissions("sch:contract:schTechConcract:view")
	@RequestMapping(value = "form")
	public String form(SchTechConcract schTechConcract, Model model) {
		
		String view = "schTechConcractForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(schTechConcract.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = schTechConcract.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(schTechConcract.getProcInsId())){
				view="schTechConcractForm";
			}else {
			
				if("1".equals(schTechConcract.getStcStatus())){
					view="schTechConcractForm";
					
				}else if(schTechConcract.getAct().isFinishTask()){
					// 查看工单
					view = "schTechConcractFormView";
				}
				// 修改环节
				else if ("modify_audit".equals(taskDefKey)){
					view = "schTechConcractForm";
				}
				// 院系秘书审核环节
				else if ("teacher_audit".equals(taskDefKey)){
					view = "schTechConcractFormAudit";
				}
				// 科研负责人审核环节
				else if ("resp_audit".equals(taskDefKey)){
					view = "schTechConcractFormAudit";
				}
				// 合同管理员审核环节
				else if ("mana_audit".equals(taskDefKey)){
					view = "schTechConcractFormAudit";
				}
				// 处长审核环节
				else if ("direct_audit".equals(taskDefKey)){
					view = "schTechConcractFormAudit";
				}
				// 副处长审核环节
				else if ("ddirect_audit".equals(taskDefKey)){
					view = "schTechConcractFormAudit";
				}else if("apply_end".equals(taskDefKey)){
					view="schTechConcractFormView";
				}
			}
		}
		
		//判断如果是超级管理员账户，则进入任意修改模式
		User user=UserUtils.getUser();
		if(user.getRoleNames().indexOf("系统管理员")!=-1){
			view="schTechConcractFormSuper";
		}

		model.addAttribute("schTechConcract", schTechConcract);
		String resType=schTechConcract.getStcResearchType();
		List<Dict> dicts=DictUtils.getDictList("CONTRACT_RESEARCH_TYPE_SUB"+resType);
		model.addAttribute("dicts", dicts);
		model.addAttribute("resTypeSub",DictUtils.getDictLabel(schTechConcract.getStcResearchTypeSub(), "CONTRACT_RESEARCH_TYPE_SUB"+resType, ""));
		return "modules/sch/contract/"+view;
	}

	@RequiresPermissions("sch:contract:schTechConcract:view")
	@RequestMapping(value = {"listSuper"})
	public String listSuper(SchTechConcract schTechConcract, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchTechConcract> page = schTechConcractService.findAllPage(new Page<SchTechConcract>(request, response), schTechConcract); 
		model.addAttribute("page", page);
		return "modules/sch/contract/schTechConcractListSuper";
	}

	@RequiresPermissions("sch:contract:schTechConcract:view")
	@RequestMapping(value = "formSuper")
	public String formSuper(SchTechConcract schTechConcract, Model model) {
		
		String view="schTechConcractFormSuper";

		model.addAttribute("schTechConcract", schTechConcract);
		String resType=schTechConcract.getStcResearchType();
		List<Dict> dicts=DictUtils.getDictList("CONTRACT_RESEARCH_TYPE_SUB"+resType);
		model.addAttribute("dicts", dicts);
		model.addAttribute("resTypeSub",DictUtils.getDictLabel(schTechConcract.getStcResearchTypeSub(), "CONTRACT_RESEARCH_TYPE_SUB"+resType, ""));
		return "modules/sch/contract/"+view;
	}
	
	@RequiresPermissions("sch:contract:schTechConcract:edit")
	@RequestMapping(value = "save")
	public String save(SchTechConcract schTechConcract, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schTechConcract)){
			return form(schTechConcract, model);
		}
		String flag=schTechConcract.getAct().getTaskId();
		schTechConcractService.save(schTechConcract);
		if("".equals(flag)){
			addMessage(redirectAttributes, "保存合同成功");
			return "redirect:"+Global.getAdminPath()+"/sch/contract/schTechConcract/?repage";

		}else{
			addMessage(redirectAttributes, "提交合同审批成功");
			return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
		}
	}
	
	/**
	 * 工单执行（完成任务）
	 * @param testAudit
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sch:contract:schTechConcract:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(SchTechConcract schTechConcract, Model model) {
		if (StringUtils.isBlank(schTechConcract.getAct().getFlag())
				|| StringUtils.isBlank(schTechConcract.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(schTechConcract, model);
		}
		schTechConcractService.auditSave(schTechConcract);
		return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
	}
	
	@RequiresPermissions("sch:contract:schTechConcract:edit")
	@RequestMapping(value = "saveSuper")
	public String saveSuper(SchTechConcract schTechConcract, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schTechConcract)){
			return form(schTechConcract, model);
		}
		schTechConcractService.saveSuper(schTechConcract);
		addMessage(redirectAttributes, "保存合同成功");
		return "redirect:"+Global.getAdminPath()+"/sch/contract/schTechConcract/?repage";
	}
	
	@RequiresPermissions("sch:contract:schTechConcract:edit")
	@RequestMapping(value = "delete")
	public String delete(SchTechConcract schTechConcract, RedirectAttributes redirectAttributes) {
		schTechConcractService.delete(schTechConcract);
		addMessage(redirectAttributes, "删除合同成功");
		return "redirect:"+Global.getAdminPath()+"/sch/contract/schTechConcract/?repage";
	}
	
	@RequestMapping(value="getResTypeSub")
	public @ResponseBody List<Dict> getResTypeSub(String type){
		return DictUtils.getDictList("CONTRACT_RESEARCH_TYPE_SUB"+type);
	}

}