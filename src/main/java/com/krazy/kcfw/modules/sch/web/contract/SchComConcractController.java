/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.contract;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.sch.entity.contract.SchComConcract;
import com.krazy.kcfw.modules.sch.service.contract.SchComConcractService;

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
	@RequestMapping(value = "form")
	public String form(SchComConcract schComConcract, Model model) {
		model.addAttribute("schComConcract", schComConcract);
		return "modules/sch/contract/schComConcractForm";
	}

	@RequiresPermissions("sch:contract:schComConcract:edit")
	@RequestMapping(value = "save")
	public String save(SchComConcract schComConcract, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schComConcract)){
			return form(schComConcract, model);
		}
		schComConcractService.save(schComConcract);
		addMessage(redirectAttributes, "保存合同成功");
		return "redirect:"+Global.getAdminPath()+"/sch/contract/schComConcract/?repage";
	}
	
	@RequiresPermissions("sch:contract:schComConcract:edit")
	@RequestMapping(value = "delete")
	public String delete(SchComConcract schComConcract, RedirectAttributes redirectAttributes) {
		schComConcractService.delete(schComConcract);
		addMessage(redirectAttributes, "删除合同成功");
		return "redirect:"+Global.getAdminPath()+"/sch/contract/schComConcract/?repage";
	}

}