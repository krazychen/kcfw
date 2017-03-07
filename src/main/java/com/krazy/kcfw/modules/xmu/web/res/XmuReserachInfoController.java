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
import com.krazy.kcfw.modules.xmu.entity.res.XmuPatentInfo;
import com.krazy.kcfw.modules.xmu.entity.res.XmuReserachInfo;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectStudentService;
import com.krazy.kcfw.modules.xmu.service.res.XmuReserachInfoService;

/**
 * 科研信息Controller
 * @author Krazy
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/res/xmuReserachInfo")
public class XmuReserachInfoController extends BaseController {

	@Autowired
	private XmuReserachInfoService xmuReserachInfoService;
	
	@Autowired
	private XmuProjectStudentService xmuProjectStudentService;
	
	@Autowired
	private TaskService taskService;
	
	@ModelAttribute
	public XmuReserachInfo get(@RequestParam(required=false) String id) {
		XmuReserachInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuReserachInfoService.get(id);
		}
		if (entity == null){
			entity = new XmuReserachInfo();
		}
		return entity;
	}
	
	/**
	 * 科研信息列表页面
	 */
	@RequiresPermissions("xmu:res:xmuReserachInfo:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuReserachInfo xmuReserachInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuReserachInfo> page = xmuReserachInfoService.findPage(new Page<XmuReserachInfo>(request, response), xmuReserachInfo); 
		
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
		return "modules/xmu/res/xmuReserachInfoList";
	}

	/**
	 * 查看，增加，编辑科研信息表单页面
	 */
	@RequiresPermissions(value={"xmu:res:xmuReserachInfo:view","xmu:res:xmuReserachInfo:add","xmu:res:xmuReserachInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuReserachInfo xmuReserachInfo, Model model) {
		String view = "xmuReserachInfoForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(xmuReserachInfo.getId())){
			
			// 环节编号
			String taskDefKey = xmuReserachInfo.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(xmuReserachInfo.getProcInsId())){
				view="xmuReserachInfoForm";
			}else {
				if("view".equals(xmuReserachInfo.getUrlType())){
					view = "xmuReserachInfoFormView";
				}else if("audit".equals(xmuReserachInfo.getUrlType())){
					view = "xmuReserachInfoFormAudit";
				}else if("form".equals(xmuReserachInfo.getUrlType())){
					view="xmuReserachInfoForm";
				}
			}
		}
		
		if(view.equals("xmuReserachInfoFormAudit")){
			Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuReserachInfo.getProcInsId()).singleResult();
			Act e = new Act();
			e.setTask(xaeTask);
			e.setVars(xaeTask.getProcessVariables());
			e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
			xmuReserachInfo.setAct(e);
		}
		List<Role> roles=UserUtils.getUser().getRoleList();
		StringBuffer roleB=new StringBuffer();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleB.append(role.getEnname());
			if("Student".equals(role.getEnname())){
				if(StringUtils.isBlank(xmuReserachInfo.getId())){
					User user=UserUtils.getUser();
					xmuReserachInfo.setXpiUserId(user.getId());
					xmuReserachInfo.setXpiUserName(user.getName());
					xmuReserachInfo.setXpiUserStuno(user.getNo());
					xmuReserachInfo.setXpiOfficeId(user.getOffice().getId());
					xmuReserachInfo.setXpiOfficeName(user.getOffice().getName());
					
					XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
					xmuProjectStudent.setXpuUserStuno(user.getNo());
					List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
					if(list!=null&&list.size()>0){
						XmuProjectStudent re=list.get(0);
						xmuReserachInfo.setXpiUserGrade(re.getXpuUserGrade());
						xmuReserachInfo.setXpiUserProfession(re.getXpuUserProfession());
					}
				}
			}
			if(i<roles.size()-1){
				roleB.append(",");
			}
		}
		model.addAttribute("role",roleB.toString());	
		model.addAttribute("xmuReserachInfo", xmuReserachInfo);
		return "modules/xmu/res/"+view;
	}

	/**
	 * 保存科研信息
	 */
	@RequiresPermissions(value={"xmu:res:xmuReserachInfo:add","xmu:res:xmuReserachInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuReserachInfo xmuReserachInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuReserachInfo)){
			return form(xmuReserachInfo, model);
		}
		User user=UserUtils.get(xmuReserachInfo.getXpiUserId());
		xmuReserachInfo.setXpiUserName(user.getName());
		xmuReserachInfo.setXpiUserStuno(user.getNo());
		xmuReserachInfo.setXpiOfficeId(user.getOffice().getId());
		xmuReserachInfo.setXpiOfficeName(user.getOffice().getName());
		XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
		xmuProjectStudent.setXpuUserStuno(user.getNo());
		List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
		if(list!=null&&list.size()>0){
			XmuProjectStudent re=list.get(0);
			xmuReserachInfo.setXpiUserGrade(re.getXpuUserGrade());
			xmuReserachInfo.setXpiUserProfession(re.getXpuUserProfession());
		}
		
		String flag=xmuReserachInfo.getAct().getFlag();
		xmuReserachInfoService.save(xmuReserachInfo);//保存
		if(StringUtils.isBlank(flag)) {
			addMessage(redirectAttributes, "保存科研信息成功");
		}else{
			addMessage(redirectAttributes, "提交科研信息成功");
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuReserachInfo/?repage";
	}
	
	/**
	 * 审核科研信息
	 */
	@RequiresPermissions(value={"xmu:res:xmuReserachInfo:add","xmu:res:xmuReserachInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveAudit")
	public String saveAduit(XmuReserachInfo xmuReserachInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (StringUtils.isBlank(xmuReserachInfo.getAct().getFlag())
				|| StringUtils.isBlank(xmuReserachInfo.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(xmuReserachInfo, model);
		}

		xmuReserachInfoService.saveAduit(xmuReserachInfo);//审核
		addMessage(redirectAttributes, "审核科研信息成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuReserachInfo/?repage";
	}
	
	/**
	 * 撤回科研信息
	 */
	@RequiresPermissions(value={"xmu:res:xmuReserachInfo:add","xmu:res:xmuReserachInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "back")
	public String back(XmuReserachInfo xmuReserachInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuReserachInfo)){
			return form(xmuReserachInfo, model);
		}
		if(xmuReserachInfo.getXpiStatus().equals("2")){
			xmuReserachInfoService.backToEnd(xmuReserachInfo);
		}else{
			xmuReserachInfoService.back(xmuReserachInfo);//保存
		}
		addMessage(redirectAttributes, "撤回科研信息成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuReserachInfo/?repage";
	}
	
	/**
	 * 删除科研信息
	 */
	@RequiresPermissions("xmu:res:xmuReserachInfo:del")
	@RequestMapping(value = "delete")
	public String delete(XmuReserachInfo xmuReserachInfo, RedirectAttributes redirectAttributes) {
		if(!xmuReserachInfo.getXpiStatus().equals("1")){
			addMessage(redirectAttributes, "只能选择待创建的数据进行删除!");
		}else{
			xmuReserachInfoService.delete(xmuReserachInfo);
			addMessage(redirectAttributes, "删除科研信息成功");
		}	
		
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuReserachInfo/?repage";
	}
	
	/**
	 * 批量删除科研信息
	 */
	@RequiresPermissions("xmu:res:xmuReserachInfo:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuReserachInfoService.delete(xmuReserachInfoService.get(id));
		}
		addMessage(redirectAttributes, "删除科研信息成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuReserachInfo/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:res:xmuReserachInfo:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuReserachInfo xmuReserachInfo, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "科研信息"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuReserachInfo> page = xmuReserachInfoService.findPage(new Page<XmuReserachInfo>(request, response, -1), xmuReserachInfo);
    		new ExportExcel("科研信息", XmuReserachInfo.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出科研信息记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuReserachInfo/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:res:xmuReserachInfo:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuReserachInfo> list = ei.getDataList(XmuReserachInfo.class);
			for (XmuReserachInfo xmuReserachInfo : list){
				try{
					xmuReserachInfoService.save(xmuReserachInfo);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条科研信息记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条科研信息记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入科研信息失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuReserachInfo/?repage";
    }
	
	/**
	 * 下载导入科研信息数据模板
	 */
	@RequiresPermissions("xmu:res:xmuReserachInfo:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "科研信息数据导入模板.xlsx";
    		List<XmuReserachInfo> list = Lists.newArrayList(); 
    		new ExportExcel("科研信息数据", XmuReserachInfo.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuReserachInfo/?repage";
    }
	

}