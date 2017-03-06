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
import com.krazy.kcfw.modules.xmu.entity.res.XmuPatentInfo;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectStudentService;
import com.krazy.kcfw.modules.xmu.service.res.XmuPatentInfoService;

/**
 * 专利信息Controller
 * @author Krazy
 * @version 2017-03-06
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/res/xmuPatentInfo")
public class XmuPatentInfoController extends BaseController {

	@Autowired
	private XmuPatentInfoService xmuPatentInfoService;
	
	@Autowired
	private XmuProjectStudentService xmuProjectStudentService;
	
	@Autowired
	private TaskService taskService;
	
	@ModelAttribute
	public XmuPatentInfo get(@RequestParam(required=false) String id) {
		XmuPatentInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuPatentInfoService.get(id);
		}
		if (entity == null){
			entity = new XmuPatentInfo();
		}
		return entity;
	}
	
	/**
	 * 专利信息列表页面
	 */
	@RequiresPermissions("xmu:res:xmuPatentInfo:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuPatentInfo xmuPatentInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuPatentInfo> page = xmuPatentInfoService.findPage(new Page<XmuPatentInfo>(request, response), xmuPatentInfo); 
		
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
		return "modules/xmu/res/xmuPatentInfoList";
	}

	/**
	 * 查看，增加，编辑专利信息表单页面
	 */
	@RequiresPermissions(value={"xmu:res:xmuPatentInfo:view","xmu:res:xmuPatentInfo:add","xmu:res:xmuPatentInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuPatentInfo xmuPatentInfo, Model model) {
		
		String view = "xmuPatentInfoForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(xmuPatentInfo.getId())){
			
			// 环节编号
			String taskDefKey = xmuPatentInfo.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(xmuPatentInfo.getProcInsId())){
				view="xmuPatentInfoForm";
			}else {
				if("view".equals(xmuPatentInfo.getUrlType())){
					view = "xmuPatentInfoFormView";
				}else if("audit".equals(xmuPatentInfo.getUrlType())){
					view = "xmuPatentInfoFormAudit";
				}else if("form".equals(xmuPatentInfo.getUrlType())){
					view="xmuPatentInfoForm";
				}
			}
		}
		
		if(view.equals("xmuPatentInfoFormAudit")){
			Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuPatentInfo.getProcInsId()).singleResult();
			Act e = new Act();
			e.setTask(xaeTask);
			e.setVars(xaeTask.getProcessVariables());
			e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
			xmuPatentInfo.setAct(e);
		}
		List<Role> roles=UserUtils.getUser().getRoleList();
		StringBuffer roleB=new StringBuffer();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleB.append(role.getEnname());
			if("Student".equals(role.getEnname())){
				if(StringUtils.isBlank(xmuPatentInfo.getId())){
					User user=UserUtils.getUser();
					xmuPatentInfo.setXpiUserId(user.getId());
					xmuPatentInfo.setXpiUserName(user.getName());
					xmuPatentInfo.setXpiUserStuno(user.getNo());
					xmuPatentInfo.setXpiOfficeId(user.getOffice().getId());
					xmuPatentInfo.setXpiOfficeName(user.getOffice().getName());
					
					XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
					xmuProjectStudent.setXpuUserStuno(user.getNo());
					List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
					if(list!=null&&list.size()>0){
						XmuProjectStudent re=list.get(0);
						xmuPatentInfo.setXpiUserGrade(re.getXpuUserGrade());
						xmuPatentInfo.setXpiUserProfession(re.getXpuUserProfession());
					}
				}
			}
			if(i<roles.size()-1){
				roleB.append(",");
			}
		}
		model.addAttribute("role",roleB.toString());	
		model.addAttribute("xmuPatentInfo", xmuPatentInfo);
		return "modules/xmu/res/"+view;
	}

	/**
	 * 保存专利信息
	 */
	@RequiresPermissions(value={"xmu:res:xmuPatentInfo:add","xmu:res:xmuPatentInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuPatentInfo xmuPatentInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuPatentInfo)){
			return form(xmuPatentInfo, model);
		}
		User user=UserUtils.get(xmuPatentInfo.getXpiUserId());
		xmuPatentInfo.setXpiUserName(user.getName());
		xmuPatentInfo.setXpiUserStuno(user.getNo());
		xmuPatentInfo.setXpiOfficeId(user.getOffice().getId());
		xmuPatentInfo.setXpiOfficeName(user.getOffice().getName());
		XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
		xmuProjectStudent.setXpuUserStuno(user.getNo());
		List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
		if(list!=null&&list.size()>0){
			XmuProjectStudent re=list.get(0);
			xmuPatentInfo.setXpiUserGrade(re.getXpuUserGrade());
			xmuPatentInfo.setXpiUserProfession(re.getXpuUserProfession());
		}
		
		String flag=xmuPatentInfo.getAct().getFlag();
		xmuPatentInfoService.save(xmuPatentInfo);//保存
		if(StringUtils.isBlank(flag)) {
			addMessage(redirectAttributes, "保存专利信息成功");
		}else{
			addMessage(redirectAttributes, "提交专利信息成功");
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPatentInfo/?repage";
	}
	
	/**
	 * 审核专利信息
	 */
	@RequiresPermissions(value={"xmu:res:xmuPatentInfo:add","xmu:res:xmuPatentInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveAudit")
	public String saveAduit(XmuPatentInfo xmuPatentInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (StringUtils.isBlank(xmuPatentInfo.getAct().getFlag())
				|| StringUtils.isBlank(xmuPatentInfo.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(xmuPatentInfo, model);
		}

		xmuPatentInfoService.saveAduit(xmuPatentInfo);//审核
		addMessage(redirectAttributes, "审核论文发表成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
	}
	
	/**
	 * 撤回论文发表
	 */
	@RequiresPermissions(value={"xmu:res:xmuPatentInfo:add","xmu:res:xmuPatentInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "back")
	public String back(XmuPatentInfo xmuPatentInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuPatentInfo)){
			return form(xmuPatentInfo, model);
		}
		if(xmuPatentInfo.getXpiStatus().equals("2")){
			xmuPatentInfoService.backToEnd(xmuPatentInfo);
		}else{
			xmuPatentInfoService.back(xmuPatentInfo);//保存
		}
		addMessage(redirectAttributes, "撤回论文发表成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPagePub/?repage";
	}
	
	/**
	 * 删除专利信息
	 */
	@RequiresPermissions("xmu:res:xmuPatentInfo:del")
	@RequestMapping(value = "delete")
	public String delete(XmuPatentInfo xmuPatentInfo, RedirectAttributes redirectAttributes) {
		if(!xmuPatentInfo.getXpiStatus().equals("1")){
			addMessage(redirectAttributes, "只能选择待创建的数据进行删除!");
		}else{
			xmuPatentInfoService.delete(xmuPatentInfo);
			addMessage(redirectAttributes, "删除专利信息成功");
		}				
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPatentInfo/?repage";
	}
	
	/**
	 * 批量删除专利信息
	 */
	@RequiresPermissions("xmu:res:xmuPatentInfo:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuPatentInfoService.delete(xmuPatentInfoService.get(id));
		}
		addMessage(redirectAttributes, "删除专利信息成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPatentInfo/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:res:xmuPatentInfo:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuPatentInfo xmuPatentInfo, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "专利信息"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuPatentInfo> page = xmuPatentInfoService.findPage(new Page<XmuPatentInfo>(request, response, -1), xmuPatentInfo);
    		new ExportExcel("专利信息", XmuPatentInfo.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出专利信息记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPatentInfo/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:res:xmuPatentInfo:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuPatentInfo> list = ei.getDataList(XmuPatentInfo.class);
			for (XmuPatentInfo xmuPatentInfo : list){
				try{
					xmuPatentInfoService.save(xmuPatentInfo);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条专利信息记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条专利信息记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入专利信息失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPatentInfo/?repage";
    }
	
	/**
	 * 下载导入专利信息数据模板
	 */
	@RequiresPermissions("xmu:res:xmuPatentInfo:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "专利信息数据导入模板.xlsx";
    		List<XmuPatentInfo> list = Lists.newArrayList(); 
    		new ExportExcel("专利信息数据", XmuPatentInfo.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuPatentInfo/?repage";
    }
	

}