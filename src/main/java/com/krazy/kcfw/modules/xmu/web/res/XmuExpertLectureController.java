/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.web.res;

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
import com.krazy.kcfw.modules.sys.utils.DictUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectTeaching;
import com.krazy.kcfw.modules.xmu.entity.res.XmuExpertLecture;
import com.krazy.kcfw.modules.xmu.service.res.XmuExpertLectureService;

/**
 * 专家讲座Controller
 * @author Krazy
 * @version 2017-02-14
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/res/xmuExpertLecture")
public class XmuExpertLectureController extends BaseController {

	@Autowired
	private XmuExpertLectureService xmuExpertLectureService;
	
	@ModelAttribute
	public XmuExpertLecture get(@RequestParam(required=false) String id) {
		XmuExpertLecture entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuExpertLectureService.get(id);
		}
		if (entity == null){
			entity = new XmuExpertLecture();
		}
		return entity;
	}
	
	/**
	 * 专家讲座列表页面
	 */
	@RequiresPermissions("xmu:res:xmuExpertLecture:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuExpertLecture xmuExpertLecture, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuExpertLecture> page = xmuExpertLectureService.findPage(new Page<XmuExpertLecture>(request, response), xmuExpertLecture); 
		for(int i=0;i<page.getList().size();i++){
			StringBuffer sb=new StringBuffer();
			XmuExpertLecture xpt=page.getList().get(i);
			String titles=xpt.getXelExpertTitle();
			if(StringUtils.isNoneBlank(titles)){
				String[] titless=titles.split(",");
				for(int j=0;j<titless.length;j++){
					sb.append(DictUtils.getDictLabel(titless[j], "XMU_PROJECT_STU_TEA_TITLE", ""));
					if(j!=titless.length-1){
						sb.append(",");
					}
				}
			}
			xpt.setXelExpertTitleStr(sb.toString());
			page.getList().set(i,xpt);
		}
		model.addAttribute("page", page);
		return "modules/xmu/res/xmuExpertLectureList";
	}

	/**
	 * 查看，增加，编辑专家讲座表单页面
	 */
	@RequiresPermissions(value={"xmu:res:xmuExpertLecture:view","xmu:res:xmuExpertLecture:add","xmu:res:xmuExpertLecture:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuExpertLecture xmuExpertLecture, Model model) {
		model.addAttribute("xmuExpertLecture", xmuExpertLecture);
		return "modules/xmu/res/xmuExpertLectureForm";
	}

	/**
	 * 保存专家讲座
	 */
	@RequiresPermissions(value={"xmu:res:xmuExpertLecture:add","xmu:res:xmuExpertLecture:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuExpertLecture xmuExpertLecture, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuExpertLecture)){
			return form(xmuExpertLecture, model);
		}
		if(!xmuExpertLecture.getIsNewRecord()){//编辑表单保存
			XmuExpertLecture t = xmuExpertLectureService.get(xmuExpertLecture.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(xmuExpertLecture, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			xmuExpertLectureService.save(t);//保存
		}else{//新增表单保存
			xmuExpertLectureService.save(xmuExpertLecture);//保存
		}
		addMessage(redirectAttributes, "保存专家讲座成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertLecture/?repage";
	}
	
	/**
	 * 删除专家讲座
	 */
	@RequiresPermissions("xmu:res:xmuExpertLecture:del")
	@RequestMapping(value = "delete")
	public String delete(XmuExpertLecture xmuExpertLecture, RedirectAttributes redirectAttributes) {
		xmuExpertLectureService.delete(xmuExpertLecture);
		addMessage(redirectAttributes, "删除专家讲座成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertLecture/?repage";
	}
	
	/**
	 * 批量删除专家讲座
	 */
	@RequiresPermissions("xmu:res:xmuExpertLecture:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuExpertLectureService.delete(xmuExpertLectureService.get(id));
		}
		addMessage(redirectAttributes, "删除专家讲座成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertLecture/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:res:xmuExpertLecture:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuExpertLecture xmuExpertLecture, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "专家讲座"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuExpertLecture> page = xmuExpertLectureService.findPage(new Page<XmuExpertLecture>(request, response, -1), xmuExpertLecture);
    		new ExportExcel("专家讲座", XmuExpertLecture.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出专家讲座记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertLecture/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:res:xmuExpertLecture:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuExpertLecture> list = ei.getDataList(XmuExpertLecture.class);
			for (XmuExpertLecture xmuExpertLecture : list){
				try{
					xmuExpertLectureService.save(xmuExpertLecture);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条专家讲座记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条专家讲座记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入专家讲座失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertLecture/?repage";
    }
	
	/**
	 * 下载导入专家讲座数据模板
	 */
	@RequiresPermissions("xmu:res:xmuExpertLecture:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "专家讲座数据导入模板.xlsx";
    		List<XmuExpertLecture> list = Lists.newArrayList(); 
    		new ExportExcel("专家讲座数据", XmuExpertLecture.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertLecture/?repage";
    }
	

}