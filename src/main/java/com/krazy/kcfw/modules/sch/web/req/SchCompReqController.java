/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.req;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.FileUtils;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.utils.excel.ImportExcel;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnder;
import com.krazy.kcfw.modules.sch.entity.req.SchCompReq;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResource;
import com.krazy.kcfw.modules.sch.service.req.SchCompReqService;
import com.krazy.kcfw.modules.sys.entity.Dict;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.DictUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 需求Controller
 * @author Krazy
 * @version 2016-11-30
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/req/schCompReq")
public class SchCompReqController extends BaseController {

	@Autowired
	private SchCompReqService schCompReqService;
	
	@ModelAttribute
	public SchCompReq get(@RequestParam(required=false) String id) {
		SchCompReq entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schCompReqService.get(id);
		}
		if (entity == null){
			entity = new SchCompReq();
		}
		return entity;
	}
	
	@RequiresPermissions("sch:req:schCompReq:view")
	@RequestMapping(value = {"listSuper"})
	public String listSuper(SchCompReq schCompReq, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchCompReq> page = schCompReqService.findPage(new Page<SchCompReq>(request, response), schCompReq); 
		model.addAttribute("page", page);
		return "modules/sch/req/schCompReqListSuper";
	}

	@RequiresPermissions("sch:req:schCompReq:view")
	@RequestMapping(value = "formSuper")
	public String formSuper(SchCompReq schCompReq, Model model) {
		
		String view="schCompReqFormSuper";
		
		model.addAttribute("schCompReq", schCompReq);
		return "modules/sch/req/"+view;
	}
	
	@RequiresPermissions("sch:req:schCompReq:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchCompReq schCompReq, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchCompReq> page = schCompReqService.findPage(new Page<SchCompReq>(request, response), schCompReq); 
		model.addAttribute("page", page);
		return "modules/sch/req/schCompReqList";
	}

	@RequiresPermissions("sch:req:schCompReq:view")
	@RequestMapping(value = "form")
	public String form(SchCompReq schCompReq, Model model) {
		
		String view = "schCompReqForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(schCompReq.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = schCompReq.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(schCompReq.getProcInsId())){
				view="schCompReqForm";
			}else {
			
				if("1".equals(schCompReq.getScrStatus())){
					view="schCompReqForm";
					
				}else if(schCompReq.getAct().isFinishTask()){
					// 查看工单
					view = "schCompReqFormView";
				}
				// 合同管理员审核环节
				else if ("mana_audit".equals(taskDefKey)){
					view = "schCompReqFormAudit";
				}
				// 修改环节
				else if ("modify_audit".equals(taskDefKey)){
					view = "schCompReqForm";
				}
				// 老师接受环节
				else if ("teacher_receive".equals(taskDefKey)){
					view = "schCompReqFormAudit";
				}
				// 老师解决环节
				else if ("teacher_audit".equals(taskDefKey)){
					view = "schCompReqFormAudit";
				}else if("apply_end".equals(taskDefKey)){
					view="schCompReqFormView";
				}
			}
		}
		
		//判断如果是超级管理员账户，则进入任意修改模式
		User user=UserUtils.getUser();
		if(user.getRoleNames().indexOf("系统管理员")!=-1){
			view="schCompReqFormSuper";
		}
		
		model.addAttribute("schCompReq", schCompReq);
		return "modules/sch/req/"+view;
	}

	@RequiresPermissions("sch:req:schCompReq:edit")
	@RequestMapping(value = "save")
	public String save(SchCompReq schCompReq, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schCompReq)){
			return form(schCompReq, model);
		}
		String flag=schCompReq.getAct().getTaskId();
		schCompReqService.save(schCompReq);
		if("".equals(flag)){
			addMessage(redirectAttributes, "保存企业需求成功");
			return "redirect:"+Global.getAdminPath()+"/sch/req/schCompReq/?repage";
		}else{
			addMessage(redirectAttributes, "提交企业需求成功");
			return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
		}
	}
	
	@RequiresPermissions("sch:req:schCompReq:edit")
	@RequestMapping(value = "saveSuper")
	public String saveSuper(SchCompReq schCompReq, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schCompReq)){
			return form(schCompReq, model);
		}
		schCompReqService.saveSuper(schCompReq);
		addMessage(redirectAttributes, "保存企业需求成功");
		return "redirect:"+Global.getAdminPath()+"/sch/req/schCompReq/?repage";
	}
	
	/**
	 * 工单执行（完成任务）
	 * @param testAudit
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sch:req:schCompReq:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(SchCompReq schCompReq, Model model) {
		if (StringUtils.isBlank(schCompReq.getAct().getFlag())
				|| StringUtils.isBlank(schCompReq.getAct().getComment())){
			addMessage(model, "请填写解决意见。");
			return form(schCompReq, model);
		}
		schCompReqService.auditSave(schCompReq);
		return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
	}
	
	@RequiresPermissions("sch:req:schCompReq:edit")
	@RequestMapping(value = "delete")
	public String delete(SchCompReq schCompReq, RedirectAttributes redirectAttributes) {
		schCompReqService.delete(schCompReq);
		addMessage(redirectAttributes, "删除企业需求成功");
		return "redirect:"+Global.getAdminPath()+"/sch/req/schCompReq/?repage";
	}

	@RequiresPermissions("sch:req:schCompReq:view")
	@RequestMapping(value="downloadTemplate")
    public void downloadTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException{
        File file = new File(request.getSession().getServletContext().getRealPath("/")  +"WEB-INF/template/企业需求导入模板.xls");
        //判断文件是否存在
        if(!file.exists()) {
            return;
        }
        FileUtils.downFile(file, request, response);
    }
	
	@RequiresPermissions("sch:req:schCompReq:view")
	@RequestMapping(value="importRes")
    public String importRes(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes) throws Exception{
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;    
          
        InputStream in =null;  
        MultipartFile file = multipartRequest.getFile("upfile");  
        if(file.isEmpty()){  
			throw new Exception("文件不存在！");
        }  
        
		ImportExcel ie=new ImportExcel(file,0,0);
		List<SchCompReq> lists=ie.getDataList(SchCompReq.class);
		//校验数据
		StringBuffer sb=new StringBuffer();
		List<SchCompReq> saveLists=new ArrayList<SchCompReq>();
		for(int i=0;i<lists.size();i++){
			SchCompReq scr=lists.get(i);
			SchCompReq saveScr=new SchCompReq();
			BeanUtils.copyProperties(saveScr, scr);
			saveScr.setIsNewRecord(false);
			
			String industry=DictUtils.getDictLabel(scr.getScrIndustry(), "COMPANY_REQ_INDUSTRY", "");
			if(StringUtils.isBlank(industry)){
				sb.append("导入Excel失败，第"+(i+1)+"行所属行业"+scr.getScrIndustry()+"不存在\n\r");
			}
			String coopMethod=DictUtils.getDictLabel(scr.getScrCoopMethod(), "COMPANY_REQ_COOP_METHOD", "");
			if(StringUtils.isBlank(coopMethod)){
				sb.append("导入Excel失败，第"+(i+1)+"行合作方式"+scr.getScrIndustry()+"不存在\n\r");
			}
			if(StringUtils.isBlank(scr.getScrName())){
				sb.append("导入Excel失败，第"+(i+1)+"行难题名称"+scr.getScrName()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(scr.getScrContent())){
				sb.append("导入Excel失败，第"+(i+1)+"行内容和说明"+scr.getScrContent()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(scr.getScrCompanyName())){
				sb.append("导入Excel失败，第"+(i+1)+"行企业名称"+scr.getScrCompanyName()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(scr.getScrCompanyContact())){
				sb.append("导入Excel失败，第"+(i+1)+"行联系人"+scr.getScrCompanyContact()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(scr.getScrCompanyPhone())){
				sb.append("导入Excel失败，第"+(i+1)+"行联系电话"+scr.getScrCompanyPhone()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(scr.getScrCompanyEmail())){
				sb.append("导入Excel失败，第"+(i+1)+"行电子邮箱"+scr.getScrCompanyEmail()+"不能为空\n\r");
			}
			
			saveLists.add(saveScr);
		}
		if(StringUtils.isBlank(sb.toString())){
			schCompReqService.saveList(saveLists);
			addMessage(redirectAttributes, "导入Excel成功");
		}else{
			addMessage(redirectAttributes, sb.toString());
		}

        return "redirect:"+Global.getAdminPath()+"/sch/req/schCompReq/?repage";
    }
	
	@RequestMapping(value="getAcceptTimes")
	public @ResponseBody String getAcceptTimes(){
		String val=DictUtils.getDictValue("times","COMPANY_REQ_ACCEPT_TIMES","");
		int times=this.schCompReqService.getAcceptTimes();
		if(times>=Integer.parseInt(val)){
			return val;
		}
		else{
			return "false";
		}
	}
}