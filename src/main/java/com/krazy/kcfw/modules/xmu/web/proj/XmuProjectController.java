/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.web.proj;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.krazy.kcfw.common.utils.DateUtils;
import com.krazy.kcfw.common.utils.MyBeanUtils;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.utils.excel.ExportExcel;
import com.krazy.kcfw.common.utils.excel.ImportExcel;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProject;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectService;

/**
 * 项目Controller
 * @author Krazy
 * @version 2017-01-29
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/proj/xmuProject")
public class XmuProjectController extends BaseController {

	@Autowired
	private XmuProjectService xmuProjectService;
	
	@ModelAttribute
	public XmuProject get(@RequestParam(required=false) String id) {
		XmuProject entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuProjectService.get(id);
		}
		if (entity == null){
			entity = new XmuProject();
		}
		return entity;
	}
	
	/**
	 * 项目列表页面
	 */
	@RequiresPermissions("xmu:proj:xmuProject:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuProject xmuProject, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuProject> page = xmuProjectService.findPage(new Page<XmuProject>(request, response), xmuProject); 
		model.addAttribute("page", page);
		return "modules/xmu/proj/xmuProjectList";
	}

	/**
	 * 查看，增加，编辑项目表单页面
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProject:view","xmu:proj:xmuProject:add","xmu:proj:xmuProject:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuProject xmuProject, Model model) {
		model.addAttribute("xmuProject", xmuProject);
		return "modules/xmu/proj/xmuProjectForm";
	}

	/**
	 * 保存项目
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProject:add","xmu:proj:xmuProject:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuProject xmuProject, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProject)){
			return form(xmuProject, model);
		}
		if(!xmuProject.getIsNewRecord()){//编辑表单保存
			XmuProject t = xmuProjectService.get(xmuProject.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(xmuProject, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			xmuProjectService.save(t);//保存
		}else{//新增表单保存
			xmuProjectService.save(xmuProject);//保存
		}
		addMessage(redirectAttributes, "保存项目成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProject/?repage";
	}
	
	/**
	 * 删除项目
	 */
	@RequiresPermissions("xmu:proj:xmuProject:del")
	@RequestMapping(value = "delete")
	public String delete(XmuProject xmuProject, RedirectAttributes redirectAttributes) {
		xmuProjectService.delete(xmuProject);
		addMessage(redirectAttributes, "删除项目成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProject/?repage";
	}
	
	/**
	 * 批量删除项目
	 */
	@RequiresPermissions("xmu:proj:xmuProject:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuProjectService.delete(xmuProjectService.get(id));
		}
		addMessage(redirectAttributes, "删除项目成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProject/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:proj:xmuProject:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuProject xmuProject, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuProject> page = xmuProjectService.findPage(new Page<XmuProject>(request, response, -1), xmuProject);
    		new ExportExcel("项目", XmuProject.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出项目记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProject/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:proj:xmuProject:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuProject> list = ei.getDataList(XmuProject.class);
			for (XmuProject xmuProject : list){
				try{
					xmuProjectService.save(xmuProject);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条项目记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条项目记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入项目失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProject/?repage";
    }
	
	/**
	 * 下载导入项目数据模板
	 */
	@RequiresPermissions("xmu:proj:xmuProject:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目数据导入模板.xlsx";
    		List<XmuProject> list = Lists.newArrayList(); 
    		new ExportExcel("项目数据", XmuProject.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProject/?repage";
    }
	

}