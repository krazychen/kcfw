/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.patent;

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
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentAgency;
import com.krazy.kcfw.modules.sch.service.patent.SchPatentAgencyService;

/**
 * 专利机构信息Controller
 * @author Krazy
 * @version 2016-11-21
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/patent/schPatentAgency")
public class SchPatentAgencyController extends BaseController {

	@Autowired
	private SchPatentAgencyService schPatentAgencyService;
	
	@ModelAttribute
	public SchPatentAgency get(@RequestParam(required=false) String id) {
		SchPatentAgency entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schPatentAgencyService.get(id);
		}
		if (entity == null){
			entity = new SchPatentAgency();
		}
		return entity;
	}
	
	@RequiresPermissions("sch:patent:schPatentAgency:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchPatentAgency schPatentAgency, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchPatentAgency> page = schPatentAgencyService.findPage(new Page<SchPatentAgency>(request, response), schPatentAgency); 
		model.addAttribute("page", page);
		return "modules/sch/patent/schPatentAgencyList";
	}

	@RequiresPermissions("sch:patent:schPatentAgency:view")
	@RequestMapping(value = "form")
	public String form(SchPatentAgency schPatentAgency, Model model) {
		model.addAttribute("schPatentAgency", schPatentAgency);
		return "modules/sch/patent/schPatentAgencyForm";
	}

	@RequiresPermissions("sch:patent:schPatentAgency:edit")
	@RequestMapping(value = "save")
	public String save(SchPatentAgency schPatentAgency, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schPatentAgency)){
			return form(schPatentAgency, model);
		}
		if("true".equals(checkAgencyCode(schPatentAgency.getSpaCode()))){
			addMessage(model, "保存专利机构'" +schPatentAgency.getSpaCode() + "'失败，机构代码已存在");
			return form(schPatentAgency, model);
		}
		schPatentAgencyService.save(schPatentAgency);
		
		addMessage(redirectAttributes, "保存专利机构成功");
		return "redirect:"+Global.getAdminPath()+"/sch/patent/schPatentAgency/?repage";
	}
	
	@RequiresPermissions("sch:patent:schPatentAgency:edit")
	@RequestMapping(value = "delete")
	public String delete(SchPatentAgency schPatentAgency, RedirectAttributes redirectAttributes) {
		schPatentAgencyService.delete(schPatentAgency);

		addMessage(redirectAttributes, "删除专利机构成功");
		return "redirect:"+Global.getAdminPath()+"/sch/patent/schPatentAgency/?repage";
	}
	
	@RequestMapping(value = "changePW")
	public @ResponseBody String changePW(SchPatentAgency schPatentAgency) {
		
		schPatentAgencyService.changePW(schPatentAgency);

		return "{\"result\": \"success\", \"message\": \""+"修改密码成功"+"\"}";
	}

	public String checkAgencyCode(String spaCode) {

		if (spaCode !=null && schPatentAgencyService.get(spaCode)!= null) {
			return "true";
		}
		return "false";
	}
}