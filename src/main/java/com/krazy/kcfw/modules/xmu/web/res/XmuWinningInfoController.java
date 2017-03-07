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
import com.krazy.kcfw.modules.xmu.entity.res.XmuWinningInfo;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectStudentService;
import com.krazy.kcfw.modules.xmu.service.res.XmuWinningInfoService;

/**
 * 获奖信息Controller
 * @author Krazy
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/res/xmuWinningInfo")
public class XmuWinningInfoController extends BaseController {

	@Autowired
	private XmuWinningInfoService xmuWinningInfoService;
	
	@Autowired
	private XmuProjectStudentService xmuProjectStudentService;
	
	@Autowired
	private TaskService taskService;
	
	@ModelAttribute
	public XmuWinningInfo get(@RequestParam(required=false) String id) {
		XmuWinningInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuWinningInfoService.get(id);
		}
		if (entity == null){
			entity = new XmuWinningInfo();
		}
		return entity;
	}
	
	/**
	 * 获奖信息列表页面
	 */
	@RequiresPermissions("xmu:res:xmuWinningInfo:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuWinningInfo xmuWinningInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuWinningInfo> page = xmuWinningInfoService.findPage(new Page<XmuWinningInfo>(request, response), xmuWinningInfo); 
		
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
		return "modules/xmu/res/xmuWinningInfoList";
	}

	/**
	 * 查看，增加，编辑获奖信息表单页面
	 */
	@RequiresPermissions(value={"xmu:res:xmuWinningInfo:view","xmu:res:xmuWinningInfo:add","xmu:res:xmuWinningInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuWinningInfo xmuWinningInfo, Model model) {
		String view = "xmuWinningInfoForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(xmuWinningInfo.getId())){
			
			// 环节编号
			String taskDefKey = xmuWinningInfo.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(xmuWinningInfo.getProcInsId())){
				view="xmuWinningInfoForm";
			}else {
				if("view".equals(xmuWinningInfo.getUrlType())){
					view = "xmuWinningInfoFormView";
				}else if("audit".equals(xmuWinningInfo.getUrlType())){
					view = "xmuWinningInfoFormAudit";
				}else if("form".equals(xmuWinningInfo.getUrlType())){
					view="xmuWinningInfoForm";
				}
			}
		}
		
		if(view.equals("xmuWinningInfoFormAudit")){
			Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuWinningInfo.getProcInsId()).singleResult();
			Act e = new Act();
			e.setTask(xaeTask);
			e.setVars(xaeTask.getProcessVariables());
			e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
			xmuWinningInfo.setAct(e);
		}
		List<Role> roles=UserUtils.getUser().getRoleList();
		StringBuffer roleB=new StringBuffer();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleB.append(role.getEnname());
			if("Student".equals(role.getEnname())){
				if(StringUtils.isBlank(xmuWinningInfo.getId())){
					User user=UserUtils.getUser();
					xmuWinningInfo.setXwiUserId(user.getId());
					xmuWinningInfo.setXwiUserName(user.getName());
					xmuWinningInfo.setXwiUserStuno(user.getNo());
					xmuWinningInfo.setXwiOfficeId(user.getOffice().getId());
					xmuWinningInfo.setXwiOfficeName(user.getOffice().getName());
					
					XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
					xmuProjectStudent.setXpuUserStuno(user.getNo());
					List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
					if(list!=null&&list.size()>0){
						XmuProjectStudent re=list.get(0);
						xmuWinningInfo.setXwiUserGrade(re.getXpuUserGrade());
						xmuWinningInfo.setXwiUserProfession(re.getXpuUserProfession());
					}
				}
			}
			if(i<roles.size()-1){
				roleB.append(",");
			}
		}
		model.addAttribute("role",roleB.toString());		
		model.addAttribute("xmuWinningInfo", xmuWinningInfo);
		return "modules/xmu/res/"+view;
	}

	/**
	 * 保存获奖信息
	 */
	@RequiresPermissions(value={"xmu:res:xmuWinningInfo:add","xmu:res:xmuWinningInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuWinningInfo xmuWinningInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuWinningInfo)){
			return form(xmuWinningInfo, model);
		}
		User user=UserUtils.get(xmuWinningInfo.getXwiUserId());
		xmuWinningInfo.setXwiUserName(user.getName());
		xmuWinningInfo.setXwiUserStuno(user.getNo());
		xmuWinningInfo.setXwiOfficeId(user.getOffice().getId());
		xmuWinningInfo.setXwiOfficeName(user.getOffice().getName());
		XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
		xmuProjectStudent.setXpuUserStuno(user.getNo());
		List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
		if(list!=null&&list.size()>0){
			XmuProjectStudent re=list.get(0);
			xmuWinningInfo.setXwiUserGrade(re.getXpuUserGrade());
			xmuWinningInfo.setXwiUserProfession(re.getXpuUserProfession());
		}
		
		String flag=xmuWinningInfo.getAct().getFlag();
		xmuWinningInfoService.save(xmuWinningInfo);//保存
		if(StringUtils.isBlank(flag)) {
			addMessage(redirectAttributes, "保存获奖信息成功");
		}else{
			addMessage(redirectAttributes, "提交获奖信息成功");
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuWinningInfo/?repage";
	}
	
	/**
	 * 审核获奖信息
	 */
	@RequiresPermissions(value={"xmu:res:xmuWinningInfo:add","xmu:res:xmuWinningInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveAudit")
	public String saveAduit(XmuWinningInfo xmuWinningInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (StringUtils.isBlank(xmuWinningInfo.getAct().getFlag())
				|| StringUtils.isBlank(xmuWinningInfo.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(xmuWinningInfo, model);
		}

		xmuWinningInfoService.saveAduit(xmuWinningInfo);//审核
		addMessage(redirectAttributes, "审核获奖信息成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuWinningInfo/?repage";
	}
	
	/**
	 * 撤回获奖信息
	 */
	@RequiresPermissions(value={"xmu:res:xmuWinningInfo:add","xmu:res:xmuWinningInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "back")
	public String back(XmuWinningInfo xmuWinningInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuWinningInfo)){
			return form(xmuWinningInfo, model);
		}
		if(xmuWinningInfo.getXwiStatus().equals("2")){
			xmuWinningInfoService.backToEnd(xmuWinningInfo);
		}else{
			xmuWinningInfoService.back(xmuWinningInfo);//保存
		}
		addMessage(redirectAttributes, "撤回获奖信息成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuWinningInfo/?repage";
	}
	
	/**
	 * 删除获奖信息
	 */
	@RequiresPermissions("xmu:res:xmuWinningInfo:del")
	@RequestMapping(value = "delete")
	public String delete(XmuWinningInfo xmuWinningInfo, RedirectAttributes redirectAttributes) {
		if(!xmuWinningInfo.getXwiStatus().equals("1")){
			addMessage(redirectAttributes, "只能选择待创建的数据进行删除!");
		}else{
			xmuWinningInfoService.delete(xmuWinningInfo);
			addMessage(redirectAttributes, "删除获奖信息成功");
		}	
		
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuWinningInfo/?repage";
	}
	
	/**
	 * 批量删除获奖信息
	 */
	@RequiresPermissions("xmu:res:xmuWinningInfo:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuWinningInfoService.delete(xmuWinningInfoService.get(id));
		}
		addMessage(redirectAttributes, "删除获奖信息成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuWinningInfo/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:res:xmuWinningInfo:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuWinningInfo xmuWinningInfo, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "获奖信息"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuWinningInfo> page = xmuWinningInfoService.findPage(new Page<XmuWinningInfo>(request, response, -1), xmuWinningInfo);
    		new ExportExcel("获奖信息", XmuWinningInfo.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出获奖信息记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuWinningInfo/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:res:xmuWinningInfo:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuWinningInfo> list = ei.getDataList(XmuWinningInfo.class);
			for (XmuWinningInfo xmuWinningInfo : list){
				try{
					xmuWinningInfoService.save(xmuWinningInfo);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条获奖信息记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条获奖信息记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入获奖信息失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuWinningInfo/?repage";
    }
	
	/**
	 * 下载导入获奖信息数据模板
	 */
	@RequiresPermissions("xmu:res:xmuWinningInfo:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "获奖信息数据导入模板.xlsx";
    		List<XmuWinningInfo> list = Lists.newArrayList(); 
    		new ExportExcel("获奖信息数据", XmuWinningInfo.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuWinningInfo/?repage";
    }
	

}