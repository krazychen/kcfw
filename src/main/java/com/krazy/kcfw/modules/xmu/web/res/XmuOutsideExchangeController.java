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
import com.krazy.kcfw.modules.xmu.entity.res.XmuOutsideExchange;
import com.krazy.kcfw.modules.xmu.entity.res.XmuPatentInfo;
import com.krazy.kcfw.modules.xmu.service.proj.XmuProjectStudentService;
import com.krazy.kcfw.modules.xmu.service.res.XmuOutsideExchangeService;

/**
 * 校外交流Controller
 * @author Krazy
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/res/xmuOutsideExchange")
public class XmuOutsideExchangeController extends BaseController {

	@Autowired
	private XmuOutsideExchangeService xmuOutsideExchangeService;
	
	@Autowired
	private XmuProjectStudentService xmuProjectStudentService;
	
	@Autowired
	private TaskService taskService;
	
	@ModelAttribute
	public XmuOutsideExchange get(@RequestParam(required=false) String id) {
		XmuOutsideExchange entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuOutsideExchangeService.get(id);
		}
		if (entity == null){
			entity = new XmuOutsideExchange();
		}
		return entity;
	}
	
	/**
	 * 校外交流列表页面
	 */
	@RequiresPermissions("xmu:res:xmuOutsideExchange:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuOutsideExchange xmuOutsideExchange, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuOutsideExchange> page = xmuOutsideExchangeService.findPage(new Page<XmuOutsideExchange>(request, response), xmuOutsideExchange); 
		
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
		return "modules/xmu/res/xmuOutsideExchangeList";
	}

	/**
	 * 查看，增加，编辑校外交流表单页面
	 */
	@RequiresPermissions(value={"xmu:res:xmuOutsideExchange:view","xmu:res:xmuOutsideExchange:add","xmu:res:xmuOutsideExchange:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuOutsideExchange xmuOutsideExchange, Model model) {
		String view = "xmuOutsideExchangeForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(xmuOutsideExchange.getId())){
			
			// 环节编号
			String taskDefKey = xmuOutsideExchange.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(xmuOutsideExchange.getProcInsId())){
				view="xmuOutsideExchangeForm";
			}else {
				if("view".equals(xmuOutsideExchange.getUrlType())){
					view = "xmuOutsideExchangeFormView";
				}else if("audit".equals(xmuOutsideExchange.getUrlType())){
					view = "xmuOutsideExchangeFormAudit";
				}else if("form".equals(xmuOutsideExchange.getUrlType())){
					view="xmuOutsideExchangeForm";
				}
			}
		}
		
		if(view.equals("xmuOutsideExchangeFormAudit")){
			Task xaeTask = taskService.createTaskQuery().processInstanceId(xmuOutsideExchange.getProcInsId()).singleResult();
			Act e = new Act();
			e.setTask(xaeTask);
			e.setVars(xaeTask.getProcessVariables());
			e.setProcDef(ProcessDefCache.get(xaeTask.getProcessDefinitionId()));
			xmuOutsideExchange.setAct(e);
		}
		List<Role> roles=UserUtils.getUser().getRoleList();
		StringBuffer roleB=new StringBuffer();
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleB.append(role.getEnname());
			if("Student".equals(role.getEnname())){
				if(StringUtils.isBlank(xmuOutsideExchange.getId())){
					User user=UserUtils.getUser();
					xmuOutsideExchange.setXoeUserId(user.getId());
					xmuOutsideExchange.setXoeUserName(user.getName());
					xmuOutsideExchange.setXoeUserStuno(user.getNo());
					xmuOutsideExchange.setXoeOfficeId(user.getOffice().getId());
					xmuOutsideExchange.setXoeOfficeName(user.getOffice().getName());
					
					XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
					xmuProjectStudent.setXpuUserStuno(user.getNo());
					List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
					if(list!=null&&list.size()>0){
						XmuProjectStudent re=list.get(0);
						xmuOutsideExchange.setXoeUserGrade(re.getXpuUserGrade());
						xmuOutsideExchange.setXoeUserProfession(re.getXpuUserProfession());
					}
				}
			}
			if(i<roles.size()-1){
				roleB.append(",");
			}
		}
		model.addAttribute("role",roleB.toString());	
		model.addAttribute("xmuOutsideExchange", xmuOutsideExchange);
		return "modules/xmu/res/"+view;
	}

	/**
	 * 保存校外交流
	 */
	@RequiresPermissions(value={"xmu:res:xmuOutsideExchange:add","xmu:res:xmuOutsideExchange:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuOutsideExchange xmuOutsideExchange, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuOutsideExchange)){
			return form(xmuOutsideExchange, model);
		}
		
		User user=UserUtils.get(xmuOutsideExchange.getXoeUserId());
		xmuOutsideExchange.setXoeUserName(user.getName());
		xmuOutsideExchange.setXoeUserStuno(user.getNo());
		xmuOutsideExchange.setXoeOfficeId(user.getOffice().getId());
		xmuOutsideExchange.setXoeOfficeName(user.getOffice().getName());
		XmuProjectStudent xmuProjectStudent=new XmuProjectStudent();	
		xmuProjectStudent.setXpuUserStuno(user.getNo());
		List<XmuProjectStudent> list=xmuProjectStudentService.findUserList(xmuProjectStudent);
		if(list!=null&&list.size()>0){
			XmuProjectStudent re=list.get(0);
			xmuOutsideExchange.setXoeUserGrade(re.getXpuUserGrade());
			xmuOutsideExchange.setXoeUserProfession(re.getXpuUserProfession());
		}
		
		String flag=xmuOutsideExchange.getAct().getFlag();
		xmuOutsideExchangeService.save(xmuOutsideExchange);//保存
		if(StringUtils.isBlank(flag)) {
			addMessage(redirectAttributes, "保存校外交流成功");
		}else{
			addMessage(redirectAttributes, "提交校外交流成功");
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuOutsideExchange/?repage";
	}
	
	/**
	 * 审核校外交流
	 */
	@RequiresPermissions(value={"xmu:res:xmuOutsideExchange:add","xmu:res:xmuOutsideExchange:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveAudit")
	public String saveAduit(XmuOutsideExchange xmuOutsideExchange, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (StringUtils.isBlank(xmuOutsideExchange.getAct().getFlag())
				|| StringUtils.isBlank(xmuOutsideExchange.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(xmuOutsideExchange, model);
		}

		xmuOutsideExchangeService.saveAduit(xmuOutsideExchange);//审核
		if("yes".equals(xmuOutsideExchange.getAct().getFlag())){
			addMessage(redirectAttributes, "校外交流审核通过");
		}else if("reject".equals(xmuOutsideExchange.getAct().getFlag())){
			addMessage(redirectAttributes, "校外交流审核不通过");
		}else if("no".equals(xmuOutsideExchange.getAct().getFlag())){
			addMessage(redirectAttributes, "校外交流退回");
		}	
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuOutsideExchange/?repage";
	}
	
	/**
	 * 撤回校外交流
	 */
	@RequiresPermissions(value={"xmu:res:xmuOutsideExchange:add","xmu:res:xmuOutsideExchange:edit"},logical=Logical.OR)
	@RequestMapping(value = "back")
	public String back(XmuOutsideExchange xmuOutsideExchange, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuOutsideExchange)){
			return form(xmuOutsideExchange, model);
		}
		if(xmuOutsideExchange.getXoeStatus().equals("2")){
			xmuOutsideExchangeService.backToEnd(xmuOutsideExchange);
		}else{
			xmuOutsideExchangeService.back(xmuOutsideExchange);//保存
		}
		addMessage(redirectAttributes, "撤回校外交流成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuOutsideExchange/?repage";
	}
	
	/**
	 * 删除校外交流
	 */
	@RequiresPermissions("xmu:res:xmuOutsideExchange:del")
	@RequestMapping(value = "delete")
	public String delete(XmuOutsideExchange xmuOutsideExchange, RedirectAttributes redirectAttributes) {
		if(!xmuOutsideExchange.getXoeStatus().equals("1")){
			addMessage(redirectAttributes, "只能选择待创建的数据进行删除!");
		}else{
			xmuOutsideExchangeService.delete(xmuOutsideExchange);
			addMessage(redirectAttributes, "删除校外交流成功");
		}	
		
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuOutsideExchange/?repage";
	}
	
	/**
	 * 批量删除校外交流
	 */
	@RequiresPermissions("xmu:res:xmuOutsideExchange:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuOutsideExchangeService.delete(xmuOutsideExchangeService.get(id));
		}
		addMessage(redirectAttributes, "删除校外交流成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuOutsideExchange/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:res:xmuOutsideExchange:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuOutsideExchange xmuOutsideExchange, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "校外交流"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuOutsideExchange> page = xmuOutsideExchangeService.findPage(new Page<XmuOutsideExchange>(request, response, -1), xmuOutsideExchange);
    		new ExportExcel("校外交流", XmuOutsideExchange.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出校外交流记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuOutsideExchange/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:res:xmuOutsideExchange:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuOutsideExchange> list = ei.getDataList(XmuOutsideExchange.class);
			for (XmuOutsideExchange xmuOutsideExchange : list){
				try{
					xmuOutsideExchangeService.save(xmuOutsideExchange);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条校外交流记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条校外交流记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入校外交流失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuOutsideExchange/?repage";
    }
	
	/**
	 * 下载导入校外交流数据模板
	 */
	@RequiresPermissions("xmu:res:xmuOutsideExchange:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "校外交流数据导入模板.xlsx";
    		List<XmuOutsideExchange> list = Lists.newArrayList(); 
    		new ExportExcel("校外交流数据", XmuOutsideExchange.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuOutsideExchange/?repage";
    }
	

}