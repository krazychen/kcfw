/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.web.proj;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
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
import com.krazy.kcfw.common.utils.FileUtils;
import com.krazy.kcfw.common.utils.MyBeanUtils;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.utils.excel.ExportExcel;
import com.krazy.kcfw.common.utils.excel.ImportExcel;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.utils.UserUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProject;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectCource;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectCourceService;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectService;

/**
 * 项目课程Controller
 * @author Krazy
 * @version 2017-02-06
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/proj/xmuProjectCource")
public class XmuProjectCourceController extends BaseController {

	@Autowired
	private XmuProjectCourceService xmuProjectCourceService;
	
	@Autowired
	private XmuProjectService xmuProjectService;
	
	@ModelAttribute
	public XmuProjectCource get(@RequestParam(required=false) String id) {
		XmuProjectCource entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuProjectCourceService.get(id);
		}
		if (entity == null){
			entity = new XmuProjectCource();
		}
		return entity;
	}
	
	/**
	 * 项目课程列表页面
	 */
	@RequiresPermissions("xmu:proj:xmuProjectCource:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuProjectCource xmuProjectCource, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuProjectCource> page = xmuProjectCourceService.findPage(new Page<XmuProjectCource>(request, response), xmuProjectCource); 
		model.addAttribute("page", page);
		return "modules/xmu/proj/xmuProjectCourceList";
	}
	
	/**
	 * 项目课程列表页面
	 */
	@RequiresPermissions("xmu:proj:xmuProjectCource:list")
	@RequestMapping(value = {"listCourse"})
	public String listCourse(XmuProjectCource xmuProjectCource, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuProjectCource> page = xmuProjectCourceService.findCourceInfoPage(new Page<XmuProjectCource>(request, response), xmuProjectCource); 
		model.addAttribute("page", page);
		return "modules/xmu/proj/xmuProjectCourceSelect";
	}

	/**
	 * 查看，增加，编辑项目课程表单页面
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectCource:view","xmu:proj:xmuProjectCource:add","xmu:proj:xmuProjectCource:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuProjectCource xmuProjectCource, Model model) {
		model.addAttribute("xmuProjectCource", xmuProjectCource);
		return "modules/xmu/proj/xmuProjectCourceForm";
	}

	/**
	 * 保存项目课程
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectCource:add","xmu:proj:xmuProjectCource:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuProjectCource xmuProjectCource, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProjectCource)){
			return form(xmuProjectCource, model);
		}
		if(!xmuProjectCource.getIsNewRecord()){//编辑表单保存
			XmuProjectCource t = xmuProjectCourceService.get(xmuProjectCource.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(xmuProjectCource, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			xmuProjectCourceService.save(t);//保存
		}else{//新增表单保存
			xmuProjectCourceService.save(xmuProjectCource);//保存
		}
		addMessage(redirectAttributes, "保存项目课程成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectCource/?repage";
	}
	
	/**
	 * 删除项目课程
	 */
	@RequiresPermissions("xmu:proj:xmuProjectCource:del")
	@RequestMapping(value = "delete")
	public String delete(XmuProjectCource xmuProjectCource, RedirectAttributes redirectAttributes) {
		xmuProjectCourceService.delete(xmuProjectCource);
		addMessage(redirectAttributes, "删除项目课程成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectCource/?repage";
	}
	
	/**
	 * 批量删除项目课程
	 */
	@RequiresPermissions("xmu:proj:xmuProjectCource:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuProjectCourceService.delete(xmuProjectCourceService.get(id));
		}
		addMessage(redirectAttributes, "删除项目课程成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectCource/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:proj:xmuProjectCource:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuProjectCource xmuProjectCource, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目课程"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuProjectCource> page = xmuProjectCourceService.findPage(new Page<XmuProjectCource>(request, response, -1), xmuProjectCource);
    		new ExportExcel("项目课程", XmuProjectCource.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出项目课程记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectCource/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:proj:xmuProjectCource:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 0, 0);
			List<XmuProjectCource> list = ei.getDataList(XmuProjectCource.class);
			for (XmuProjectCource xmuProjectCource : list){
				try{
					xmuProjectCourceService.save(xmuProjectCource);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条项目课程记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条项目课程记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入项目课程失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectCource/?repage";
    }
	
	/**
	 * 下载导入项目课程数据模板
	 */
	@RequiresPermissions("xmu:proj:xmuProjectCource:import")
    @RequestMapping(value = "import/template")
    public void importFileTemplate(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目课程数据导入模板.xls";
//    		List<XmuProjectCource> list = Lists.newArrayList(); 
//    		new ExportExcel("项目课程数据", XmuProjectCource.class, 1).setDataList(list).write(response, fileName).dispose();
//    		return null;
            File file = new File(request.getSession().getServletContext().getRealPath("/")  +"WEB-INF/template/"+fileName);
            //判断文件是否存在
            if(!file.exists()) {
                return;
            }
            FileUtils.downFile(file, request, response);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
//		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectCource/?repage";
    }
	
	/**
	 * 选择项目
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "selectProject")
	public String selectProject(XmuProject xmuProject, String url, String fieldLabels, String fieldKeys, String searchLabel, String searchKey, HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
//		Page<XmuProject> page = xmuProjectService.findPage(new Page<XmuProject>(request, response), xmuProject); 
		
		List<Role> roles=UserUtils.getUser().getRoleList();
		Boolean isAdmin=false;
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			if(StringUtils.isNoneBlank(role.getEnname())&&("dept".equals(role.getEnname()))){
				isAdmin=true;
				break;
			}
		}
		if(!isAdmin){
			xmuProject.setXmpDescp(UserUtils.getUser().getOffice().getId());
		}
		xmuProject.setCurrentDate(new Date());
		Page<XmuProject> page = xmuProjectService.findPageForMana(new Page<XmuProject>(request, response), xmuProject); 
		
		try {
			fieldLabels = URLDecoder.decode(fieldLabels, "UTF-8");
			fieldKeys = URLDecoder.decode(fieldKeys, "UTF-8");
			searchLabel = URLDecoder.decode(searchLabel, "UTF-8");
			searchKey = URLDecoder.decode(searchKey, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		model.addAttribute("labelNames", fieldLabels.split("\\|"));
		model.addAttribute("labelValues", fieldKeys.split("\\|"));
		model.addAttribute("fieldLabels", fieldLabels);
		model.addAttribute("fieldKeys", fieldKeys);
		model.addAttribute("url", url);
		model.addAttribute("searchLabel", searchLabel);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("obj", xmuProject);
		model.addAttribute("page", page);
		return "modules/sys/gridselect";
	}
	
	/**
	 * 保存项目课程
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectCource:add","xmu:proj:xmuProjectCource:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveCourse")
	public String saveCourse(XmuProjectCource xmuProjectCource, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProjectCource)){
			return form(xmuProjectCource, model);
		}
		String message=xmuProjectCourceService.saveCourse(xmuProjectCource, xmuProjectCource.getCourseIdList());
		
		addMessage(redirectAttributes, "保存项目课程成功");
		//addMessage(redirectAttributes, message);
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectCource/listCourse?repage";
	}
	
	/**
	 * 查看，增加，编辑项目课程表单列表页面
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectCource:view","xmu:proj:xmuProjectCource:add","xmu:proj:xmuProjectCource:edit"},logical=Logical.OR)
	@RequestMapping(value = "formList")
	public String formList(XmuProject xmuProject, Model model) {
		List xcs=xmuProject.getXciCourseIds();
		List courseList=Lists.newArrayList();	
		for(int i=0;i<xcs.size();i++){
			String xcid=String.valueOf(xcs.get(i));
			XmuProjectCource xpc=xmuProjectCourceService.get(xcid);
			courseList.add(xpc);
		}
		xmuProject.setXmuProjectCourceList(courseList);
		model.addAttribute("xmuProject", xmuProject);
		return "modules/xmu/proj/xmuProjectCourceForm";
	}

	/**
	 * 保存项目课程
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectCource:add","xmu:proj:xmuProjectCource:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveList")
	public String saveList(XmuProject xmuProject, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProject)){
			return formList(xmuProject, model);
		}
		xmuProjectCourceService.saveCourseList(xmuProject.getXmuProjectCourceList());
		addMessage(redirectAttributes, "保存项目课程成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectCource/?repage";
	}
}