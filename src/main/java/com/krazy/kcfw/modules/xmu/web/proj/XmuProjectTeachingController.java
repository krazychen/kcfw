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
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectTeaching;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectTeachingService;

/**
 * 项目开课Controller
 * @author Krazy
 * @version 2017-02-13
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/proj/xmuProjectTeaching")
public class XmuProjectTeachingController extends BaseController {

	@Autowired
	private XmuProjectTeachingService xmuProjectTeachingService;
	
	@ModelAttribute
	public XmuProjectTeaching get(@RequestParam(required=false) String id) {
		XmuProjectTeaching entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuProjectTeachingService.get(id);
		}
		if (entity == null){
			entity = new XmuProjectTeaching();
		}
		return entity;
	}
	
	/**
	 * 学年教学列表页面
	 */
	@RequiresPermissions("xmu:proj:xmuProjectTeaching:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuProjectTeaching xmuProjectTeaching, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuProjectTeaching> page = xmuProjectTeachingService.findPage(new Page<XmuProjectTeaching>(request, response), xmuProjectTeaching); 
		model.addAttribute("page", page);
		return "modules/xmu/proj/xmuProjectTeachingList";
	}

	/**
	 * 查看，增加，编辑学年教学表单页面
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectTeaching:view","xmu:proj:xmuProjectTeaching:add","xmu:proj:xmuProjectTeaching:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuProjectTeaching xmuProjectTeaching, Model model) {
		model.addAttribute("xmuProjectTeaching", xmuProjectTeaching);
		return "modules/xmu/proj/xmuProjectTeachingForm";
	}

	/**
	 * 保存学年教学
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectTeaching:add","xmu:proj:xmuProjectTeaching:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuProjectTeaching xmuProjectTeaching, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProjectTeaching)){
			return form(xmuProjectTeaching, model);
		}
		if(!xmuProjectTeaching.getIsNewRecord()){//编辑表单保存
			XmuProjectTeaching t = xmuProjectTeachingService.get(xmuProjectTeaching.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(xmuProjectTeaching, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			xmuProjectTeachingService.save(t);//保存
		}else{//新增表单保存
			xmuProjectTeachingService.save(xmuProjectTeaching);//保存
		}
		addMessage(redirectAttributes, "保存学年教学成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectTeaching/?repage";
	}
	
	/**
	 * 删除学年教学
	 */
	@RequiresPermissions("xmu:proj:xmuProjectTeaching:del")
	@RequestMapping(value = "delete")
	public String delete(XmuProjectTeaching xmuProjectTeaching, RedirectAttributes redirectAttributes) {
		xmuProjectTeachingService.delete(xmuProjectTeaching);
		addMessage(redirectAttributes, "删除学年教学成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectTeaching/?repage";
	}
	
	/**
	 * 批量删除学年教学
	 */
	@RequiresPermissions("xmu:proj:xmuProjectTeaching:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuProjectTeachingService.delete(xmuProjectTeachingService.get(id));
		}
		addMessage(redirectAttributes, "删除学年教学成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectTeaching/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:proj:xmuProjectTeaching:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuProjectTeaching xmuProjectTeaching, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "学年教学"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuProjectTeaching> page = xmuProjectTeachingService.findPage(new Page<XmuProjectTeaching>(request, response, -1), xmuProjectTeaching);
    		new ExportExcel("学年教学", XmuProjectTeaching.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出学年教学记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectTeaching/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:proj:xmuProjectTeaching:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuProjectTeaching> list = ei.getDataList(XmuProjectTeaching.class);
			for (XmuProjectTeaching xmuProjectTeaching : list){
				try{
					xmuProjectTeachingService.save(xmuProjectTeaching);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条学年教学记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条学年教学记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入学年教学失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectTeaching/?repage";
    }
	
	/**
	 * 下载导入学年教学数据模板
	 */
	@RequiresPermissions("xmu:proj:xmuProjectTeaching:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "学年教学数据导入模板.xlsx";
    		List<XmuProjectTeaching> list = Lists.newArrayList(); 
    		new ExportExcel("学年教学数据", XmuProjectTeaching.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectTeaching/?repage";
    }
	
	/**
	 * 项目课程列表页面
	 */
	@RequiresPermissions("xmu:proj:xmuProjectTeaching:list")
	@RequestMapping(value = {"listTeaching"})
	public String listTeaching(XmuProjectTeaching xmuProjectTeaching, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuProjectTeaching> page = xmuProjectTeachingService.findCourceInfoPage(new Page<XmuProjectTeaching>(request, response), xmuProjectTeaching); 
		model.addAttribute("page", page);
		return "modules/xmu/proj/xmuProjectTeachingSelect";
	}

	/**
	 * 保存学年教学
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectTeaching:add","xmu:proj:xmuProjectTeaching:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveTeaching")
	public String saveTeaching(XmuProjectTeaching xmuProjectTeaching, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProjectTeaching)){
			return form(xmuProjectTeaching, model);
		}
		xmuProjectTeachingService.saveTeaching(xmuProjectTeaching,xmuProjectTeaching.getTeachingIdList());//保存
		addMessage(redirectAttributes, "保存学年教学成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectTeaching/listTeaching?repage";
	}
	
	/**
	 * 查看，增加，编辑学年教学表单页面
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectTeaching:view","xmu:proj:xmuProjectTeaching:add","xmu:proj:xmuProjectTeaching:edit"},logical=Logical.OR)
	@RequestMapping(value = "formList")
	public String formList(XmuProject xmuProject, Model model) {
		List xpts=xmuProject.getXptTeachingIds();
		List teachingList=Lists.newArrayList();
		for(int i=0;i<xpts.size();i++){
			String xpid=String.valueOf(xpts.get(i));
			XmuProjectTeaching xpt=this.get(xpid);
			teachingList.add(xpt);
		}
		xmuProject.setXmuProjectTeachingList(teachingList);
		model.addAttribute("xmuProject", xmuProject);
		return "modules/xmu/proj/xmuProjectTeachingForm";
	}
	
	/**
	 * 保存学年教学
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectTeaching:add","xmu:proj:xmuProjectTeaching:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveList")
	public String saveList(XmuProject xmuProject, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProject)){
			return formList(xmuProject, model);
		}
		xmuProjectTeachingService.saveTeachingList(xmuProject.getXmuProjectTeachingList());
		addMessage(redirectAttributes, "保存学年教学成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectTeaching/?repage";
	}
}