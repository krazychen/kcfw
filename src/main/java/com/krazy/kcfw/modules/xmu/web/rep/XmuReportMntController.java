/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.web.rep;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
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
import com.krazy.kcfw.common.json.AjaxJson;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.utils.excel.ExportExcel;
import com.krazy.kcfw.common.utils.excel.ImportExcel;
import com.krazy.kcfw.modules.act.entity.Act;
import com.krazy.kcfw.modules.act.utils.ProcessDefCache;
import com.krazy.kcfw.modules.sys.entity.Dict;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.service.DictService;
import com.krazy.kcfw.modules.sys.utils.DictUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProject;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.entity.rep.XmuReportMnt;
import com.krazy.kcfw.modules.xmu.entity.res.XmuAcademicEvent;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectService;
import com.krazy.kcfw.modules.xmu.service.rep.XmuReportMntService;

/**
 * 项目汇报管理Controller
 * @author Krazy
 * @version 2017-06-03
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/rep/xmuReportMnt")
public class XmuReportMntController extends BaseController {

	@Autowired
	private XmuReportMntService xmuReportMntService;
	
	@Autowired
	private DictService dictService;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private XmuProjectService xmuProjectService;
	
	@RequiresPermissions("xmu:rep:xmuReportMnt:list")
	@RequestMapping(value ="uploadTemplate")
	public String uploadTemplate(XmuReportMnt xmuReportMnt, Model model, RedirectAttributes redirectAttributes) {

		if (StringUtils.isNotBlank(xmuReportMnt.getXrmTemplate())){
			
			Dict dict=DictUtils.getDictList("XMU_REPORT_TEMPLATE").get(0);
			dict.setType("XMU_REPORT_TEMPLATE");
			dict.setValue(xmuReportMnt.getXrmTemplate());
			dict.preUpdate();
			dictService.updateByType(dict);
		}
		addMessage(redirectAttributes, "保存项目模版成功");
		return "modules/xmu/rep/xmuReportMntList";
	}
	
	@RequiresPermissions("xmu:rep:xmuReportMnt:list")
	@RequestMapping(value ="gotoUploadTemplate")
	public String gotoUploadTemplate(XmuReportMnt xmuReportMnt, Model model) {

		XmuReportMnt entity = new XmuReportMnt();
		String template=DictUtils.getDictValue("项目汇报下载模版","XMU_REPORT_TEMPLATE","");
		if(StringUtils.isNoneBlank(template)){
			entity.setXrmTemplate(template);
		}
	
		return "modules/xmu/rep/xmuReportUploadTemplate";
	}
	
	@ModelAttribute
	public XmuReportMnt get(@RequestParam(required=false) String id) {
		XmuReportMnt entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuReportMntService.get(id);
		}
		if (entity == null){
			entity = new XmuReportMnt();
		}
		entity.setXrmTemplate(DictUtils.getDictValue("项目汇报下载模版","XMU_REPORT_TEMPLATE",""));
		return entity;
	}
	
	/**
	 * 项目汇报列表页面
	 */
	@RequiresPermissions("xmu:rep:xmuReportMnt:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuReportMnt xmuReportMnt, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Role> roles=UserUtils.getUser().getRoleList();
		StringBuffer roleB=new StringBuffer();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleB.append(role.getEnname());
			if(i<roles.size()-1){
				roleB.append(",");
			}
		}
		model.addAttribute("role",roleB.toString());
		Page<XmuReportMnt> page = xmuReportMntService.findPage(new Page<XmuReportMnt>(request, response), xmuReportMnt); 
		model.addAttribute("page", page);
		return "modules/xmu/rep/xmuReportMntList";
	}

	/**
	 * 查看，增加，编辑项目汇报表单页面
	 */
	@RequiresPermissions(value={"xmu:rep:xmuReportMnt:view","xmu:rep:xmuReportMnt:add","xmu:rep:xmuReportMnt:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuReportMnt xmuReportMnt, Model model) {
		
		String view = "xmuReportMntForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(xmuReportMnt.getId())){
			
			// 环节编号
			String taskDefKey = xmuReportMnt.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(xmuReportMnt.getProcInsId())){
				view="xmuReportMntForm";
			}else {
				if("view".equals(xmuReportMnt.getUrlType())){
					view = "xmuReportMntFormView";
				}else if("audit".equals(xmuReportMnt.getUrlType())){
					view = "xmuReportMntFormAudit";
				}else if("form".equals(xmuReportMnt.getUrlType())){
					view="xmuReportMntForm";
				}
			}
		}

		
		if(view.equals("xmuReportMntFormAudit")){
			Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuReportMnt.getProcInsId()).singleResult();
			Act e = new Act();
			e.setTask(xaeTask);
			e.setVars(xaeTask.getProcessVariables());
			e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
			xmuReportMnt.setAct(e);
		}
		List<Role> roles=UserUtils.getUser().getRoleList();
		StringBuffer roleB=new StringBuffer();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleB.append(role.getEnname());
			if(i<roles.size()-1){
				roleB.append(",");
			}
		}
		model.addAttribute("role",roleB.toString());
		xmuReportMnt.setXrmTemplate(DictUtils.getDictValue("项目汇报下载模版","XMU_REPORT_TEMPLATE",""));
		model.addAttribute("xmuReportMnt", xmuReportMnt);
		return "modules/xmu/rep/"+view;
	}

	/**
	 * 保存项目汇报
	 */
	@RequiresPermissions(value={"xmu:rep:xmuReportMnt:add","xmu:rep:xmuReportMnt:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuReportMnt xmuReportMnt, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuReportMnt)){
			return form(xmuReportMnt, model);
		}
		
		String flag=xmuReportMnt.getAct().getFlag();
		xmuReportMntService.save(xmuReportMnt);//保存
		if(StringUtils.isBlank(flag)) {
			addMessage(redirectAttributes, "保存学术活动成功");
		}else{
			addMessage(redirectAttributes, "提交学术活动成功");
		}
//		
//		if(!xmuReportMnt.getIsNewRecord()){//编辑表单保存
//			XmuReportMnt t = xmuReportMntService.get(xmuReportMnt.getId());//从数据库取出记录的值
//			MyBeanUtils.copyBeanNotNull2Bean(xmuReportMnt, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
//			xmuReportMntService.save(t);//保存
//		}else{//新增表单保存
//			xmuReportMntService.save(xmuReportMnt);//保存
//		}
//		addMessage(redirectAttributes, "保存项目汇报成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
	}
	
	/**
	 * 保存项目汇报
	 */
	@RequiresPermissions(value={"xmu:rep:xmuReportMnt:view"},logical=Logical.OR)
	@RequestMapping(value = "saveAudit")
	public String saveAduit(XmuReportMnt xmuReportMnt, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (StringUtils.isBlank(xmuReportMnt.getAct().getFlag())
				|| StringUtils.isBlank(xmuReportMnt.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(xmuReportMnt, model);
		}

		xmuReportMntService.saveAduit(xmuReportMnt);//审核
		if("yes".equals(xmuReportMnt.getAct().getFlag())){
			addMessage(redirectAttributes, "项目汇报审核通过");
		}else if("reject".equals(xmuReportMnt.getAct().getFlag())){
			addMessage(redirectAttributes, "项目汇报审核不通过");
		}else if("no".equals(xmuReportMnt.getAct().getFlag())){
			addMessage(redirectAttributes, "项目汇报退回");
		}	
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
	}
	
	/**
	 * 撤回项目汇报
	 */
	@RequiresPermissions(value={"xmu:rep:xmuReportMnt:view"},logical=Logical.OR)
	@RequestMapping(value = "backToEnd")
	public String backToEnd(XmuReportMnt xmuReportMnt, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuReportMnt)){
			return form(xmuReportMnt, model);
		}
		xmuReportMntService.backToEnd(xmuReportMnt);//保存
		addMessage(redirectAttributes, "撤回项目汇报成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
	}
	
	/**
	 * 撤回项目汇报
	 */
	@RequiresPermissions(value={"xmu:rep:xmuReportMnt:view"},logical=Logical.OR)
	@RequestMapping(value = "back")
	public String back(XmuReportMnt xmuReportMnt, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuReportMnt)){
			return form(xmuReportMnt, model);
		}
		if(xmuReportMnt.getXrmStatus().equals("2")){
			xmuReportMntService.backToEnd(xmuReportMnt);
		}else{
			xmuReportMntService.back(xmuReportMnt);//保存
		}
		addMessage(redirectAttributes, "撤回项目汇报成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
	}
	
	/**
	 * 删除项目汇报
	 */
	@RequiresPermissions("xmu:rep:xmuReportMnt:del")
	@RequestMapping(value = "delete")
	public String delete(XmuReportMnt xmuReportMnt, RedirectAttributes redirectAttributes) {
		if(!xmuReportMnt.getXrmStatus().equals("1")){
			addMessage(redirectAttributes, "只能选择待创建的数据进行删除!");
		}else{
			xmuReportMntService.delete(xmuReportMnt);
			addMessage(redirectAttributes, "删除项目汇报成功");
		}
//		xmuReportMntService.delete(xmuReportMnt);
//		addMessage(redirectAttributes, "删除项目汇报成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
	}
	
	/**
	 * 批量删除项目汇报
	 */
	@RequiresPermissions("xmu:rep:xmuReportMnt:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuReportMntService.delete(xmuReportMntService.get(id));
		}
		addMessage(redirectAttributes, "删除项目汇报成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:rep:xmuReportMnt:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuReportMnt xmuReportMnt, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目汇报"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuReportMnt> page = xmuReportMntService.findPage(new Page<XmuReportMnt>(request, response, -1), xmuReportMnt);
    		new ExportExcel("项目汇报", XmuReportMnt.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出项目汇报记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:rep:xmuReportMnt:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuReportMnt> list = ei.getDataList(XmuReportMnt.class);
			for (XmuReportMnt xmuReportMnt : list){
				try{
					xmuReportMntService.save(xmuReportMnt);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条项目汇报记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条项目汇报记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入项目汇报失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
    }
	
	/**
	 * 下载导入项目汇报数据模板
	 */
	@RequiresPermissions("xmu:rep:xmuReportMnt:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目汇报数据导入模板.xlsx";
    		List<XmuReportMnt> list = Lists.newArrayList(); 
    		new ExportExcel("项目汇报数据", XmuReportMnt.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/rep/xmuReportMnt/?repage";
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
}