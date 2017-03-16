/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.web.res;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.utils.excel.ExportExcel;
import com.krazy.kcfw.common.utils.excel.ImportExcel;
import com.krazy.kcfw.modules.act.entity.Act;
import com.krazy.kcfw.modules.act.utils.ProcessDefCache;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.UserUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProject;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.entity.res.XmuAcademicEvent;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectStudentService;
import com.krazy.kcfw.modules.xmu.service.res.XmuAcademicEventService;

/**
 * 学术活动Controller
 * @author Krazy
 * @version 2017-02-18
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/res/xmuAcademicEvent")
public class XmuAcademicEventController extends BaseController {

	@Autowired
	private XmuAcademicEventService xmuAcademicEventService;
	
	@Autowired
	private XmuProjectStudentService xmuProjectStudentService;
	
	@Autowired
	private TaskService taskService;
	
	@ModelAttribute
	public XmuAcademicEvent get(@RequestParam(required=false) String id) {
		XmuAcademicEvent entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuAcademicEventService.get(id);
		}
		if (entity == null){
			entity = new XmuAcademicEvent();
		}
		return entity;
	}
	
	/**
	 * 学术活动列表页面
	 */
	@RequiresPermissions("xmu:res:xmuAcademicEvent:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuAcademicEvent xmuAcademicEvent, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuAcademicEvent> page = xmuAcademicEventService.findPage(new Page<XmuAcademicEvent>(request, response), xmuAcademicEvent); 
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
		model.addAttribute("page", page);
		return "modules/xmu/res/xmuAcademicEventList";
	}

	/**
	 * 查看，增加，编辑学术活动表单页面
	 */
	@RequiresPermissions(value={"xmu:res:xmuAcademicEvent:view","xmu:res:xmuAcademicEvent:add","xmu:res:xmuAcademicEvent:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuAcademicEvent xmuAcademicEvent, Model model) {
		
		String view = "xmuAcademicEventForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(xmuAcademicEvent.getId())){
			
			// 环节编号
			String taskDefKey = xmuAcademicEvent.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(xmuAcademicEvent.getProcInsId())){
				view="xmuAcademicEventForm";
			}else {
				if("view".equals(xmuAcademicEvent.getUrlType())){
					view = "xmuAcademicEventFormView";
				}else if("audit".equals(xmuAcademicEvent.getUrlType())){
					view = "xmuAcademicEventFormAudit";
				}else if("form".equals(xmuAcademicEvent.getUrlType())){
					view="xmuAcademicEventForm";
				}
			
//				if("1".equals(xmuAcademicEvent.getXaeStatus())){
//					view="xmuAcademicEventForm";
//					
//				}else if(xmuAcademicEvent.getAct().isFinishTask()){
//					// 查看工单
//					view = "xmuAcademicEventFormView";
//				}
//				// 修改环节
//				else if ("modify_audit".equals(taskDefKey)){
//					view = "xmuAcademicEventForm";
//				}// 院系管理员审核环节
//				else if ("mana_audit".equals(taskDefKey)){
//					view = "xmuAcademicEventFormAudit";
//				}
//				// 系统管理员审核环节
//				else if ("sys_audit".equals(taskDefKey)){
//					view = "xmuAcademicEventFormAudit";
//				}
			}
		}

		
		if(view.equals("xmuAcademicEventFormAudit")){
			Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuAcademicEvent.getProcInsId()).singleResult();
			Act e = new Act();
			e.setTask(xaeTask);
			e.setVars(xaeTask.getProcessVariables());
			e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
			xmuAcademicEvent.setAct(e);
		}
		List<Role> roles=UserUtils.getUser().getRoleList();
		StringBuffer roleB=new StringBuffer();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleB.append(role.getEnname());
			if("Student".equals(role.getEnname())){
				if(StringUtils.isBlank(xmuAcademicEvent.getId())){
					User user=UserUtils.getUser();
					xmuAcademicEvent.setXaeUserId(user.getId());
					xmuAcademicEvent.setXaeUserName(user.getName());
					xmuAcademicEvent.setXaeUserStuno(user.getNo());
					xmuAcademicEvent.setXaeOfficeId(user.getOffice().getId());
					xmuAcademicEvent.setXaeOfficeName(user.getOffice().getName());
					
					XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
					xmuProjectStudent.setXpuUserStuno(user.getNo());
					List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
					if(list!=null&&list.size()>0){
						XmuProjectStudent re=list.get(0);
						xmuAcademicEvent.setXaeUserGrade(re.getXpuUserGrade());
						xmuAcademicEvent.setXaeUserProfession(re.getXpuUserProfession());
					}
				}
			}
			if(i<roles.size()-1){
				roleB.append(",");
			}
		}
		model.addAttribute("role",roleB.toString());
		model.addAttribute("xmuAcademicEvent", xmuAcademicEvent);
		return "modules/xmu/res/"+view;
	}

	/**
	 * 保存学术活动
	 */
	@RequiresPermissions(value={"xmu:res:xmuAcademicEvent:add","xmu:res:xmuAcademicEvent:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuAcademicEvent xmuAcademicEvent, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuAcademicEvent)){
			return form(xmuAcademicEvent, model);
		}
		User user=UserUtils.get(xmuAcademicEvent.getXaeUserId());
		xmuAcademicEvent.setXaeUserName(user.getName());
		xmuAcademicEvent.setXaeUserStuno(user.getNo());
		xmuAcademicEvent.setXaeOfficeId(user.getOffice().getId());
		xmuAcademicEvent.setXaeOfficeName(user.getOffice().getName());
		XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
		xmuProjectStudent.setXpuUserStuno(user.getNo());
		List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
		if(list!=null&&list.size()>0){
			XmuProjectStudent re=list.get(0);
			xmuAcademicEvent.setXaeUserGrade(re.getXpuUserGrade());
			xmuAcademicEvent.setXaeUserProfession(re.getXpuUserProfession());
		}
		
		String flag=xmuAcademicEvent.getAct().getFlag();
//		if(!xmuAcademicEvent.getIsNewRecord()){//编辑表单保存
//			XmuAcademicEvent t = xmuAcademicEventService.get(xmuAcademicEvent.getId());//从数据库取出记录的值
//			MyBeanUtils.copyBeanNotNull2Bean(xmuAcademicEvent, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
//			xmuAcademicEventService.save(t);//保存
//		}else{//新增表单保存
			xmuAcademicEventService.save(xmuAcademicEvent);//保存
//		}
		if(StringUtils.isBlank(flag)) {
			addMessage(redirectAttributes, "保存学术活动成功");
		}else{
			addMessage(redirectAttributes, "提交学术活动成功");
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
	}
	
	/**
	 * 保存学术活动
	 */
	@RequiresPermissions(value={"xmu:res:xmuAcademicEvent:add","xmu:res:xmuAcademicEvent:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveAudit")
	public String saveAduit(XmuAcademicEvent xmuAcademicEvent, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (StringUtils.isBlank(xmuAcademicEvent.getAct().getFlag())
				|| StringUtils.isBlank(xmuAcademicEvent.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(xmuAcademicEvent, model);
		}

		xmuAcademicEventService.saveAduit(xmuAcademicEvent);//审核
		if("yes".equals(xmuAcademicEvent.getAct().getFlag())){
			addMessage(redirectAttributes, "学术活动审核通过");
		}else if("reject".equals(xmuAcademicEvent.getAct().getFlag())){
			addMessage(redirectAttributes, "学术活动审核不通过");
		}else if("no".equals(xmuAcademicEvent.getAct().getFlag())){
			addMessage(redirectAttributes, "学术活动退回");
		}	
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
	}
	
	/**
	 * 撤回学术活动
	 */
	@RequiresPermissions(value={"xmu:res:xmuAcademicEvent:add","xmu:res:xmuAcademicEvent:edit"},logical=Logical.OR)
	@RequestMapping(value = "backToEnd")
	public String backToEnd(XmuAcademicEvent xmuAcademicEvent, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuAcademicEvent)){
			return form(xmuAcademicEvent, model);
		}
		xmuAcademicEventService.backToEnd(xmuAcademicEvent);//保存
		addMessage(redirectAttributes, "撤回学术活动成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
	}
	
	/**
	 * 撤回学术活动
	 */
	@RequiresPermissions(value={"xmu:res:xmuAcademicEvent:add","xmu:res:xmuAcademicEvent:edit"},logical=Logical.OR)
	@RequestMapping(value = "back")
	public String back(XmuAcademicEvent xmuAcademicEvent, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuAcademicEvent)){
			return form(xmuAcademicEvent, model);
		}
		if(xmuAcademicEvent.getXaeStatus().equals("2")){
			xmuAcademicEventService.backToEnd(xmuAcademicEvent);
		}else{
			xmuAcademicEventService.back(xmuAcademicEvent);//保存
		}
		addMessage(redirectAttributes, "撤回学术活动成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
	}
	
	/**
	 * 删除学术活动
	 */
	@RequiresPermissions("xmu:res:xmuAcademicEvent:del")
	@RequestMapping(value = "delete")
	public String delete(XmuAcademicEvent xmuAcademicEvent, RedirectAttributes redirectAttributes) {
		if(!xmuAcademicEvent.getXaeStatus().equals("1")){
			addMessage(redirectAttributes, "只能选择待创建的数据进行删除!");
		}else{
			xmuAcademicEventService.delete(xmuAcademicEvent);
			addMessage(redirectAttributes, "删除学术活动成功");
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
	}
	
	/**
	 * 批量删除学术活动
	 */
	@RequiresPermissions("xmu:res:xmuAcademicEvent:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuAcademicEventService.delete(xmuAcademicEventService.get(id));
		}
		addMessage(redirectAttributes, "删除学术活动成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:res:xmuAcademicEvent:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuAcademicEvent xmuAcademicEvent, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "学术活动"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuAcademicEvent> page = xmuAcademicEventService.findPage(new Page<XmuAcademicEvent>(request, response, -1), xmuAcademicEvent);
    		new ExportExcel("学术活动", XmuAcademicEvent.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出学术活动记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:res:xmuAcademicEvent:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuAcademicEvent> list = ei.getDataList(XmuAcademicEvent.class);
			for (XmuAcademicEvent xmuAcademicEvent : list){
				try{
					xmuAcademicEventService.save(xmuAcademicEvent);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条学术活动记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条学术活动记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入学术活动失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
    }
	
	/**
	 * 下载导入学术活动数据模板
	 */
	@RequiresPermissions("xmu:res:xmuAcademicEvent:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "学术活动数据导入模板.xlsx";
    		List<XmuAcademicEvent> list = Lists.newArrayList(); 
    		new ExportExcel("学术活动数据", XmuAcademicEvent.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuAcademicEvent/?repage";
    }
	

	/**
	 * 学生选择页面
	 */
	@RequestMapping(value = {"listStu"})
	public String listStu(XmuProjectStudent xmuProjectStudent, HttpServletRequest request, HttpServletResponse response, Model model) {
		xmuProjectStudent.setXpsOfficeId(UserUtils.getUser().getOffice().getId());
		Page<XmuProjectStudent> page = xmuProjectStudentService.findUserPage(new Page<XmuProjectStudent>(request, response), xmuProjectStudent); 
		model.addAttribute("page", page);
		return "modules/xmu/res/xmuAcademicEventStudentSelect";
	}


}