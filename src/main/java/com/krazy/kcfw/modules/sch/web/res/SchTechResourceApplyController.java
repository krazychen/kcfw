/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.res;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.mapper.JsonMapper;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResource;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResourceApply;
import com.krazy.kcfw.modules.sch.service.res.SchTechResourceApplyService;
import com.krazy.kcfw.modules.sch.service.res.SchTechResourceService;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

/**
 * 科研资源申请Controller
 * @author Krazy
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/res/schTechResourceApply")
public class SchTechResourceApplyController extends BaseController {

	@Autowired
	private SchTechResourceService schTechResourceService;
	
	@Autowired
	private SchTechResourceApplyService schTechResourceApplyService;
	
	@ModelAttribute
	public SchTechResourceApply get(@RequestParam(required=false) String id) {
		SchTechResourceApply entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schTechResourceApplyService.get(id);
		}
		if (entity == null){
			entity = new SchTechResourceApply();
		}
		return entity;
	}
	
	@RequiresPermissions("sch:res:schTechResourceApply:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchTechResource schTechResource, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchTechResource> page = schTechResourceService.findPageWithoutPer(new Page<SchTechResource>(request, response), schTechResource); 
		model.addAttribute("page", page);
		return "modules/sch/res/schTechResourceApplyList";
	}
	
	@RequiresPermissions("sch:res:schTechResourceApply:view")
	@RequestMapping(value = {"applyList"})
	public String applyList(SchTechResourceApply schTechResourceApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchTechResourceApply> page = schTechResourceApplyService.findPage(new Page<SchTechResourceApply>(request, response), schTechResourceApply); 
		model.addAttribute("page", page);
		return "modules/sch/res/schTechResourceApplyMyList";
	}
	
	@RequiresPermissions("sch:res:schTechResourceApply:view")
	@RequestMapping(value = "form")
	public String form(SchTechResourceApply schTechResourceApply, Model model) {
		
		String view = "schTechResourceApplyForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(schTechResourceApply.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = schTechResourceApply.getAct().getTaskDefKey();
			
			if(StringUtils.isBlank(schTechResourceApply.getProcInsId())){
				view="schTechResourceApplyForm";
			}else {
			
				//if("1".equals(schTechResourceApply.getScaApplyStatus())){
				//	view="schTechResourceApplyForm";
					
				//}else if(schTechResourceApply.getAct().isFinishTask()){
				if(schTechResourceApply.getAct().isFinishTask()){
					// 查看工单
					view = "schTechResourceApplyFormView";
				}
				// 修改环节
				else if ("modify_audit".equals(taskDefKey)){
					view = "schTechResourceApplyForm";
				}
				// 老师接受环节
				else if ("receive".equals(taskDefKey)){
					view = "schTechResourceApplyFormAudit";
				}else if("apply_end".equals(taskDefKey)){
					view="schComConcractFormView";
				}
			}
		}
		SchTechResource str=schTechResourceService.get(schTechResourceApply.getScaSchId());
		model.addAttribute("schTechResourceApply", schTechResourceApply);
		model.addAttribute("schTechResource", str);
		return "modules/sch/res/"+view;
	}
	
	/**
	 * 工单执行（完成任务）
	 * @param testAudit
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sch:res:schTechResourceApply:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(SchTechResourceApply schTechResourceApply, Model model) {
		if (StringUtils.isBlank(schTechResourceApply.getAct().getFlag())
				|| StringUtils.isBlank(schTechResourceApply.getAct().getComment())){
			addMessage(model, "请填写解决意见。");
			return form(schTechResourceApply, model);
		}
		schTechResourceApplyService.auditSave(schTechResourceApply);
		return "redirect:"+Global.getAdminPath()+"/act/task/todo/";
	}
	

	 @RequestMapping(value="saveApply")
	 public @ResponseBody String saveApply(SchTechResourceApply schTechResourceApply){
		 String applyTimes=schTechResourceApply.getScaApplyDates();
		 String[] applyA=applyTimes.split(",");
		 for(int i=0;i<applyA.length;i++){
			 SchTechResourceApply saveApply=new SchTechResourceApply();
			 saveApply.setScaApplyUserId(UserUtils.getUser().getId());
			 saveApply.setScaApplyDate(schTechResourceApply.getScaApplyDate());
			 saveApply.setScaApplyTimeRange(applyA[i]);
			 saveApply.setScaSchId(schTechResourceApply.getScaSchId());
			 schTechResourceApplyService.save(saveApply);
		 }
		 return "{\"result\": \"success\", \"message\": \"预约申请成功\"}";
	 }
	 
	 @RequestMapping(value="getApply")
	 public @ResponseBody String getApply(SchTechResourceApply schTechResourceApply,HttpServletResponse response) {
		 
		 //初始化没有选择资源时
		 if(StringUtils.isBlank(schTechResourceApply.getScaSchId())){
			 return "";
		 }
		 
		 List<Map<String, Object>> eventList = Lists.newArrayList();
		 schTechResourceApply.setFilterStatus("3");
		 List<SchTechResourceApply> list=schTechResourceApplyService.findListWithoutPer(schTechResourceApply);
		 for(int i=0;i<list.size();i++){
			SchTechResourceApply stra=list.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
	        map.put("id",stra.getId() );
	        map.put("title", stra.getScaApplyTimeRange());
	        map.put("start", stra.getScaApplyDate());
	        if(stra.getScaApplyStatus().equals("1")&&stra.getScaApplyUserId().equals(UserUtils.getUser().getId())){
	        	map.put("backgroundColor", "#64be0f");
	        }else if(stra.getScaApplyStatus().equals("2")&&stra.getScaApplyUserId().equals(UserUtils.getUser().getId())){
	        	map.put("backgroundColor", "#3a87ad");
	        }else if(stra.getScaApplyStatus().equals("3")){
	        	//对于驳回的预约不进行处理
	        }else{
	        	map.put("backgroundColor", "#7f7f7f");
	        }
	        eventList.add(map);
		 }
		 // Convert to JSON string.
		 String json = JsonMapper.getInstance().toJson(eventList);

		 // Write JSON string.
		 response.setContentType("application/json");
		 response.setCharacterEncoding("UTF-8");

        return json;		 
	        
	        /**
		 	List<Map<String, Object>> list = Lists.newArrayList();
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("id", "111");
	        map.put("title", "event1");
	        map.put("start", "2016-12-15");
	        map.put("backgroundColor", "#64be0f");
	        list.add(map);
	        // Convert to JSON string.
	        String json = JsonMapper.getInstance().toJson(list);

	        // Write JSON string.
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");

	        return json;**/
	    }
}