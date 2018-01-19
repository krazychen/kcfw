/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.web.proj;

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
import com.krazy.kcfw.common.utils.MyBeanUtils;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.utils.excel.ExportExcel;
import com.krazy.kcfw.common.utils.excel.ImportExcel;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProject;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectService;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectStudentService;

/**
 * 项目人员Controller
 * @author Krazy
 * @version 2017-02-03
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/proj/xmuProjectStudent")
public class XmuProjectStudentController extends BaseController {

	@Autowired
	private XmuProjectStudentService xmuProjectStudentService;
	
	@Autowired
	private XmuProjectService xmuProjectService;
	
	@ModelAttribute
	public XmuProjectStudent get(@RequestParam(required=false) String id) {
		XmuProjectStudent entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuProjectStudentService.get(id);
		}
		if (entity == null){
			entity = new XmuProjectStudent();
		}
		return entity;
	}
	
	/**
	 * 项目人员列表页面
	 */
	@RequiresPermissions("xmu:proj:xmuProjectStudent:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuProjectStudent xmuProjectStudent, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuProjectStudent> page = xmuProjectStudentService.findPage(new Page<XmuProjectStudent>(request, response), xmuProjectStudent); 
		model.addAttribute("page", page);
		return "modules/xmu/proj/xmuProjectStudentList";
	}
	
	/**
	 * 项目人员学生选择页面
	 */
	@RequiresPermissions("xmu:proj:xmuProjectStudent:list")
	@RequestMapping(value = {"listStu"})
	public String listStu(XmuProjectStudent xmuProjectStudent, HttpServletRequest request, HttpServletResponse response, Model model) {
		//判断如果是超级管理员账户，则进入任意修改模式
		User user=UserUtils.getUser();
		if(user.getRoleNames().indexOf("系统管理员")==-1){
			xmuProjectStudent.setXpsOfficeId(UserUtils.getUser().getOffice().getId());
		}
		//xmuProjectStudent.setXpsOfficeId(UserUtils.getUser().getOffice().getId());
		Page<XmuProjectStudent> page = xmuProjectStudentService.findUserPage(new Page<XmuProjectStudent>(request, response), xmuProjectStudent); 
		model.addAttribute("page", page);
		return "modules/xmu/proj/xmuProjectStudentSelect";
	}

	
	/**
	 * 项目人员列表项目页面
	 */
	@RequiresPermissions("xmu:proj:xmuProjectStudent:list")
	@RequestMapping(value = {"listPro"})
	public String listPro(XmuProject xmuProject, HttpServletRequest request, HttpServletResponse response, Model model) {
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
		model.addAttribute("page", page);
		return "modules/xmu/proj/xmuProjectStudentList";
	}
	
	/**
	 * 查看，增加，编辑项目人员表单页面
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectStudent:view","xmu:proj:xmuProjectStudent:add","xmu:proj:xmuProjectStudent:edit"},logical=Logical.OR)
	@RequestMapping(value = "formList")
	public String formList(XmuProject xmuProject, HttpServletRequest request, HttpServletResponse response, Model model) {

		if(xmuProject.getXpsUserIds()!=null){
			//获取用户
			XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();
//			xmuProjectStudent.setXpsOfficeId(UserUtils.getUser().getOffice().getId());
			xmuProjectStudent.setXpsUserIds(xmuProject.getXpsUserIds());
			xmuProjectStudent.setXpsUserName(xmuProject.getXpsUserName());
			xmuProjectStudent.setXpuUserGrade(xmuProject.getXpuUserGrade());
			xmuProjectStudent.setXpuUserProfession(xmuProject.getXpuUserProfession());
			xmuProjectStudent.setXpuUserStuno(xmuProject.getXpuUserStuno());
			Page<XmuProjectStudent> page = xmuProjectStudentService.findUserPage(new Page<XmuProjectStudent>(request, response) , xmuProjectStudent);
			xmuProject.setXmuProjectStudentPage(page);
//			List<XmuProjectStudent> lists=xmuProjectStudentService.findUserList(xmuProjectStudent);
//			xmuProject.setXmuProjectStudentList(lists);
		}else{
			XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();
//			xmuProjectStudent.setXpsOfficeId(UserUtils.getUser().getOffice().getId());
			xmuProjectStudent.setXpsProjId(xmuProject.getId());
			xmuProjectStudent.setXpsUserName(xmuProject.getXpsUserName());
			xmuProjectStudent.setXpuUserGrade(xmuProject.getXpuUserGrade());
			xmuProjectStudent.setXpuUserProfession(xmuProject.getXpuUserProfession());
			xmuProjectStudent.setXpuUserStuno(xmuProject.getXpuUserStuno());
//			List<XmuProjectStudent> lists=xmuProjectStudentService.findList(xmuProjectStudent);
//			xmuProject.setXmuProjectStudentList(lists);
			Page<XmuProjectStudent> page = xmuProjectStudentService.findPage(new Page<XmuProjectStudent>(request, response) , xmuProjectStudent);
			xmuProject.setXmuProjectStudentPage(page);
		}
		model.addAttribute("xmuProject", xmuProject);
		return "modules/xmu/proj/xmuProjectStudentForm";
	}
	
	/**
	 * 保存项目人员
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectStudent:add","xmu:proj:xmuProjectStudent:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveList")
	public String saveList(XmuProject xmuProject, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProject)){
			return formList(xmuProject, null, null, model);
		}
		this.xmuProjectStudentService.saveList(xmuProject.getXmuProjectStudentList());
		addMessage(redirectAttributes, "保存项目人员成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectStudent/listPro?repage";
	}
	

	/**
	 * 查看，增加，编辑项目人员表单页面
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectStudent:view","xmu:proj:xmuProjectStudent:add","xmu:proj:xmuProjectStudent:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuProjectStudent xmuProjectStudent, Model model) {
		model.addAttribute("xmuProjectStudent", xmuProjectStudent);
		return "modules/xmu/proj/xmuProjectStudentForm";
	}

	/**
	 * 保存项目人员
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectStudent:add","xmu:proj:xmuProjectStudent:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuProjectStudent xmuProjectStudent, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuProjectStudent)){
			return form(xmuProjectStudent, model);
		}
		if(!xmuProjectStudent.getIsNewRecord()){//编辑表单保存
			XmuProjectStudent t = xmuProjectStudentService.get(xmuProjectStudent.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(xmuProjectStudent, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			xmuProjectStudentService.save(t);//保存
		}else{//新增表单保存
			xmuProjectStudentService.save(xmuProjectStudent);//保存
		}
		addMessage(redirectAttributes, "保存项目人员成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectStudent/?repage";
	}
	
	/**
	 * 删除项目人员
	 */
	@RequiresPermissions("xmu:proj:xmuProjectStudent:del")
	@RequestMapping(value = "delete")
	public String delete(XmuProjectStudent xmuProjectStudent, RedirectAttributes redirectAttributes) {
		xmuProjectStudentService.delete(xmuProjectStudent);
		addMessage(redirectAttributes, "删除项目人员成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectStudent/?repage";
	}
	
	/**
	 * 批量删除项目人员
	 */
	@RequiresPermissions("xmu:proj:xmuProjectStudent:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuProjectStudentService.delete(xmuProjectStudentService.get(id));
		}
		addMessage(redirectAttributes, "删除项目人员成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectStudent/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:proj:xmuProjectStudent:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuProjectStudent xmuProjectStudent, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目人员"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuProjectStudent> page = xmuProjectStudentService.findPage(new Page<XmuProjectStudent>(request, response, -1), xmuProjectStudent);
    		new ExportExcel("项目人员", XmuProjectStudent.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出项目人员记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectStudent/?repage";
    }

	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions(value={"xmu:proj:xmuProjectStudent:view","xmu:proj:xmuProjectStudent:add","xmu:proj:xmuProjectStudent:edit"},logical=Logical.OR)
	@RequestMapping(value = "exportIn", method=RequestMethod.POST)
    public String exportFileIn(XmuProjectStudent xmuProjectStudent, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目人员"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            xmuProjectStudent.setXpsProjId(xmuProjectStudent.getId());
            Page<XmuProjectStudent> page = xmuProjectStudentService.findPage(new Page<XmuProjectStudent>(request, response, -1), xmuProjectStudent);
    		new ExportExcel("项目人员", XmuProjectStudent.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出项目人员记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"xmu/proj/xmuProjectStudent/formList?id="+xmuProjectStudent.getId();
    }
	
	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:proj:xmuProjectStudent:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuProjectStudent> list = ei.getDataList(XmuProjectStudent.class);
			for (XmuProjectStudent xmuProjectStudent : list){
				try{
					xmuProjectStudentService.save(xmuProjectStudent);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条项目人员记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条项目人员记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入项目人员失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectStudent/?repage";
    }
	
	/**
	 * 下载导入项目人员数据模板
	 */
	@RequiresPermissions("xmu:proj:xmuProjectStudent:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目人员数据导入模板.xlsx";
    		List<XmuProjectStudent> list = Lists.newArrayList(); 
    		new ExportExcel("项目人员数据", XmuProjectStudent.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/proj/xmuProjectStudent/?repage";
    }
	

}