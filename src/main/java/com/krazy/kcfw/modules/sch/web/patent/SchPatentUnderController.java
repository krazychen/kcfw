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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnder;
import com.krazy.kcfw.modules.sch.service.patent.SchPatentUnderService;

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
	
	@ModelAttribute
	public SchPatentUnder get(@RequestParam(required=false) String id) {
		SchPatentUnder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schPatentUnderService.get(id);
		}
		if (entity == null){
			entity = new SchPatentUnder();
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
		model.addAttribute("schPatentUnder", schPatentUnder);
		return "modules/sch/patent/schPatentUnderForm";
	}

	@RequiresPermissions("sch:patent:schPatentUnder:edit")
	@RequestMapping(value = "save")
	public String save(SchPatentUnder schPatentUnder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schPatentUnder)){
			return form(schPatentUnder, model);
		}
		schPatentUnderService.save(schPatentUnder);
		addMessage(redirectAttributes, "保存发明专利成功");
		return "redirect:"+Global.getAdminPath()+"/sch/patent/schPatentUnder/?repage";
	}
	
	@RequiresPermissions("sch:patent:schPatentUnder:edit")
	@RequestMapping(value = "delete")
	public String delete(SchPatentUnder schPatentUnder, RedirectAttributes redirectAttributes) {
		schPatentUnderService.delete(schPatentUnder);
		addMessage(redirectAttributes, "删除发明专利成功");
		return "redirect:"+Global.getAdminPath()+"/sch/patent/schPatentUnder/?repage";
	}

}