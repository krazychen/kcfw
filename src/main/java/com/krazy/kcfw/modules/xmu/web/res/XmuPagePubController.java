/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.web.res;

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
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.entity.res.XmuPagePub;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectStudentService;
import com.krazy.kcfw.modules.xmu.service.res.XmuPagePubService;

/**
 * 论文发表Controller
 * @author Krazy
 * @version 2017-03-06
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/res/xmuPagePub")
public class XmuPagePubController extends BaseController {

	@Autowired
	private XmuPagePubService xmuPagePubService;
	
	@Autowired
	private XmuProjectStudentService xmuProjectStudentService;
	
	@Autowired
	private TaskService taskService;
	
	@ModelAttribute
	public XmuPagePub get(@RequestParam(required=false) String id) {
		XmuPagePub entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuPagePubService.get(id);
		}
		if (entity == null){
			entity = new XmuPagePub();
		}
		return entity;
	}
	
	/**
	 * 论文发表列表页面
	 */
	@RequiresPermissions("xmu:res:xmuPagePub:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuPagePub xmuPagePub, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuPagePub> page = xmuPagePubService.findPage(new Page<XmuPagePub>(request, response), xmuPagePub); 
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
		return "modules/xmu/res/xmuPagePubList";
	}

	/**
	 * 查看，增加，编辑论文发表表单页面
	 */
	@RequiresPermissions(value={"xmu:res:xmuPagePub:view","xmu:res:xmuPagePub:add","xmu:res:xmuPagePub:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuPagePub xmuPagePub, Model model) {
		
		String view = "xmuPagePubForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(xmuPagePub.getId())){
			
			// 环节编号
			String taskDefKey = xmuPagePub.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(xmuPagePub.getProcInsId())){
				view="xmuPagePubForm";
			}else {
				if("view".equals(xmuPagePub.getUrlType())){
					view = "xmuPagePubFormView";
				}else if("audit".equals(xmuPagePub.getUrlType())){
					view = "xmuPagePubFormAudit";
				}else if("form".equals(xmuPagePub.getUrlType())){
					view="xmuPagePubFormForm";
				}
			}
		}
		
		if(view.equals("xmuPagePubFormAudit")){
			Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuPagePub.getProcInsId()).singleResult();
			Act e = new Act();
			e.setTask(xaeTask);
			e.setVars(xaeTask.getProcessVariables());
			e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
			xmuPagePub.setAct(e);
		}
		List<Role> roles=UserUtils.getUser().getRoleList();
		StringBuffer roleB=new StringBuffer();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleB.append(role.getEnname());
			if("Student".equals(role.getEnname())){
				if(StringUtils.isBlank(xmuPagePub.getId())){
					User user=UserUtils.getUser();
					xmuPagePub.setXppUserId(user.getId());
					xmuPagePub.setXppUserName(user.getName());
					xmuPagePub.setXppUserStuno(user.getNo());
					xmuPagePub.setXppOfficeId(user.getOffice().getId());
					xmuPagePub.setXppOfficeName(user.getOffice().getName());
					
					XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
					xmuProjectStudent.setXpuUserStuno(user.getNo());
					List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
					if(list!=null&&list.size()>0){
						XmuProjectStudent re=list.get(0);
						xmuPagePub.setXppUserGrade(re.getXpuUserGrade());
						xmuPagePub.setXppUserProfession(re.getXpuUserProfession());
					}
				}
			}
			if(i<roles.size()-1){
				roleB.append(",");
			}
		}
		model.addAttribute("role",roleB.toString());		
		model.addAttribute("xmuPagePub", xmuPagePub);
		return "modules/xmu/res/"+view;
	}

	/**
	 * 保存论文发表
	 */
	@RequiresPermissions(value={"xmu:res:xmuPagePub:add","xmu:res:xmuPagePub:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuPagePub xmuPagePub, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuPagePub)){
			return form(xmuPagePub, model);
		}
		User user=UserUtils.get(xmuPagePub.getXppUserId());
		xmuPagePub.setXppUserName(user.getName());
		xmuPagePub.setXppUserStuno(user.getNo());
		xmuPagePub.setXppOfficeId(user.getOffice().getId());
		xmuPagePub.setXppOfficeName(user.getOffice().getName());
		XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
		xmuProjectStudent.setXpuUserStuno(user.getNo());
		List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
		if(list!=null&&list.size()>0){
			XmuProjectStudent re=list.get(0);
			xmuPagePub.setXppUserGrade(re.getXpuUserGrade());
			xmuPagePub.setXppUserProfession(re.getXpuUserProfession());
		}
		
		String flag=xmuPagePub.getAct().getFlag();
		xmuPagePubService.save(xmuPagePub);//保存
		if(StringUtils.isBlank(flag)) {
			addMessage(redirectAttributes, "保存论文发表成功");
		}else{
			addMessage(redirectAttributes, "提交论文发表成功");
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
	}
	
	/**
	 * 审核论文发表
	 */
	@RequiresPermissions(value={"xmu:res:xmuPagePub:add","xmu:res:xmuPagePub:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveAudit")
	public String saveAduit(XmuPagePub xmuPagePub, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (StringUtils.isBlank(xmuPagePub.getAct().getFlag())
				|| StringUtils.isBlank(xmuPagePub.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(xmuPagePub, model);
		}

		xmuPagePubService.saveAduit(xmuPagePub);//审核
		addMessage(redirectAttributes, "审核论文发表成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
	}
	
	/**
	 * 撤回论文发表
	 */
	@RequiresPermissions(value={"xmu:res:xmuPagePub:add","xmu:res:xmuPagePub:edit"},logical=Logical.OR)
	@RequestMapping(value = "back")
	public String back(XmuPagePub xmuPagePub, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuPagePub)){
			return form(xmuPagePub, model);
		}
		if(xmuPagePub.getXppStatus().equals("2")){
			xmuPagePubService.backToEnd(xmuPagePub);
		}else{
			xmuPagePubService.back(xmuPagePub);//保存
		}
		addMessage(redirectAttributes, "撤回论文发表成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
	}
	
	/**
	 * 删除论文发表
	 */
	@RequiresPermissions("xmu:res:xmuPagePub:del")
	@RequestMapping(value = "delete")
	public String delete(XmuPagePub xmuPagePub, RedirectAttributes redirectAttributes) {
		if(!xmuPagePub.getXppStatus().equals("1")){
			addMessage(redirectAttributes, "只能选择待创建的数据进行删除!");
		}else{
			xmuPagePubService.delete(xmuPagePub);
			addMessage(redirectAttributes, "删除论文发表成功");
		}		
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
	}
	
	/**
	 * 批量删除论文发表
	 */
	@RequiresPermissions("xmu:res:xmuPagePub:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuPagePubService.delete(xmuPagePubService.get(id));
		}
		addMessage(redirectAttributes, "删除论文发表成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:res:xmuPagePub:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuPagePub xmuPagePub, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "论文发表"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuPagePub> page = xmuPagePubService.findPage(new Page<XmuPagePub>(request, response, -1), xmuPagePub);
    		new ExportExcel("论文发表", XmuPagePub.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出论文发表记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:res:xmuPagePub:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuPagePub> list = ei.getDataList(XmuPagePub.class);
			for (XmuPagePub xmuPagePub : list){
				try{
					xmuPagePubService.save(xmuPagePub);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条论文发表记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条论文发表记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入论文发表失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
    }
	
	/**
	 * 下载导入论文发表数据模板
	 */
	@RequiresPermissions("xmu:res:xmuPagePub:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "论文发表数据导入模板.xlsx";
    		List<XmuPagePub> list = Lists.newArrayList(); 
    		new ExportExcel("论文发表数据", XmuPagePub.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
    }
	

}