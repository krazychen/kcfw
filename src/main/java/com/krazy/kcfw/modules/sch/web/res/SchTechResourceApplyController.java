/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.res;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResource;
import com.krazy.kcfw.modules.sch.service.res.SchTechResourceService;

/**
 * 科研资源Controller
 * @author Krazy
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/res/schTechResourceApply")
public class SchTechResourceApplyController extends BaseController {

	@Autowired
	private SchTechResourceService schTechResourceService;
	
	@ModelAttribute
	public SchTechResource get(@RequestParam(required=false) String id) {
		SchTechResource entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schTechResourceService.get(id);
		}
		if (entity == null){
			entity = new SchTechResource();
		}
		return entity;
	}
	
	@RequiresPermissions("sch:res:schTechResourceApply:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchTechResource schTechResource, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchTechResource> page = schTechResourceService.findPage(new Page<SchTechResource>(request, response), schTechResource); 
		model.addAttribute("page", page);
		return "modules/sch/res/schTechResourceApplyList";
	}
}