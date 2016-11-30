/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.req;

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
import com.krazy.kcfw.modules.sch.entity.req.SchCompReq;
import com.krazy.kcfw.modules.sch.service.req.SchCompReqService;

/**
 * 需求Controller
 * @author Krazy
 * @version 2016-11-30
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/req/schCompReq")
public class SchCompReqController extends BaseController {

	@Autowired
	private SchCompReqService schCompReqService;
	
	@ModelAttribute
	public SchCompReq get(@RequestParam(required=false) String id) {
		SchCompReq entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schCompReqService.get(id);
		}
		if (entity == null){
			entity = new SchCompReq();
		}
		return entity;
	}
	
	@RequiresPermissions("sch:req:schCompReq:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchCompReq schCompReq, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchCompReq> page = schCompReqService.findPage(new Page<SchCompReq>(request, response), schCompReq); 
		model.addAttribute("page", page);
		return "modules/sch/req/schCompReqList";
	}

	@RequiresPermissions("sch:req:schCompReq:view")
	@RequestMapping(value = "form")
	public String form(SchCompReq schCompReq, Model model) {
		model.addAttribute("schCompReq", schCompReq);
		return "modules/sch/req/schCompReqForm";
	}

	@RequiresPermissions("sch:req:schCompReq:edit")
	@RequestMapping(value = "save")
	public String save(SchCompReq schCompReq, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schCompReq)){
			return form(schCompReq, model);
		}
		schCompReqService.save(schCompReq);
		addMessage(redirectAttributes, "保存企业需求成功");
		return "redirect:"+Global.getAdminPath()+"/sch/req/schCompReq/?repage";
	}
	
	@RequiresPermissions("sch:req:schCompReq:edit")
	@RequestMapping(value = "delete")
	public String delete(SchCompReq schCompReq, RedirectAttributes redirectAttributes) {
		schCompReqService.delete(schCompReq);
		addMessage(redirectAttributes, "删除企业需求成功");
		return "redirect:"+Global.getAdminPath()+"/sch/req/schCompReq/?repage";
	}

}