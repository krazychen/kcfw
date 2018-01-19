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
import com.krazy.kcfw.modules.xmu.entity.res.XmuExpertLecture;
import com.krazy.kcfw.modules.xmu.entity.res.XmuExpertTeaching;
import com.krazy.kcfw.modules.xmu.service.res.XmuExpertTeachingService;

/**
 * 专家授课Controller
 * @author Krazy
 * @version 2017-02-14
 */
@Controller
@RequestMapping(value = "${adminPath}/xmu/res/xmuExpertTeaching")
public class XmuExpertTeachingController extends BaseController {

	@Autowired
	private XmuExpertTeachingService xmuExpertTeachingService;
	
	@ModelAttribute
	public XmuExpertTeaching get(@RequestParam(required=false) String id) {
		XmuExpertTeaching entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xmuExpertTeachingService.get(id);
		}
		if (entity == null){
			entity = new XmuExpertTeaching();
		}
		return entity;
	}
	
	/**
	 * 专家授课列表页面
	 */
	@RequiresPermissions("xmu:res:xmuExpertTeaching:list")
	@RequestMapping(value = {"list", ""})
	public String list(XmuExpertTeaching xmuExpertTeaching, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XmuExpertTeaching> page = xmuExpertTeachingService.findPage(new Page<XmuExpertTeaching>(request, response), xmuExpertTeaching); 
		for(int i=0;i<page.getList().size();i++){
			StringBuffer sb=new StringBuffer();
			XmuExpertTeaching xpt=page.getList().get(i);
			String titles=xpt.getXetExpertTitle();
			if(StringUtils.isNoneBlank(titles)){
				String[] titless=titles.split(",");
				for(int j=0;j<titless.length;j++){
					sb.append(DictUtils.getDictLabel(titless[j], "XMU_PROJECT_STU_TEA_TITLE", ""));
					if(j!=titless.length-1){
						sb.append(",");
					}
				}
			}
			xpt.setXetExpertTitleStr(sb.toString());
			page.getList().set(i,xpt);
		}
		model.addAttribute("page", page);
		return "modules/xmu/res/xmuExpertTeachingList";
	}

	/**
	 * 查看，增加，编辑专家授课表单页面
	 */
	@RequiresPermissions(value={"xmu:res:xmuExpertTeaching:view","xmu:res:xmuExpertTeaching:add","xmu:res:xmuExpertTeaching:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XmuExpertTeaching xmuExpertTeaching, Model model) {
		model.addAttribute("xmuExpertTeaching", xmuExpertTeaching);
		return "modules/xmu/res/xmuExpertTeachingForm";
	}

	/**
	 * 保存专家授课
	 */
	@RequiresPermissions(value={"xmu:res:xmuExpertTeaching:add","xmu:res:xmuExpertTeaching:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XmuExpertTeaching xmuExpertTeaching, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xmuExpertTeaching)){
			return form(xmuExpertTeaching, model);
		}
		if(!xmuExpertTeaching.getIsNewRecord()){//编辑表单保存
			XmuExpertTeaching t = xmuExpertTeachingService.get(xmuExpertTeaching.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(xmuExpertTeaching, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			xmuExpertTeachingService.save(t);//保存
		}else{//新增表单保存
			xmuExpertTeachingService.save(xmuExpertTeaching);//保存
		}
		addMessage(redirectAttributes, "保存专家授课成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertTeaching/?repage";
	}
	
	/**
	 * 删除专家授课
	 */
	@RequiresPermissions("xmu:res:xmuExpertTeaching:del")
	@RequestMapping(value = "delete")
	public String delete(XmuExpertTeaching xmuExpertTeaching, RedirectAttributes redirectAttributes) {
		xmuExpertTeachingService.delete(xmuExpertTeaching);
		addMessage(redirectAttributes, "删除专家授课成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertTeaching/?repage";
	}
	
	/**
	 * 批量删除专家授课
	 */
	@RequiresPermissions("xmu:res:xmuExpertTeaching:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xmuExpertTeachingService.delete(xmuExpertTeachingService.get(id));
		}
		addMessage(redirectAttributes, "删除专家授课成功");
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertTeaching/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xmu:res:xmuExpertTeaching:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XmuExpertTeaching xmuExpertTeaching, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "专家授课"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XmuExpertTeaching> page = xmuExpertTeachingService.findPage(new Page<XmuExpertTeaching>(request, response, -1), xmuExpertTeaching);
    		new ExportExcel("专家授课", XmuExpertTeaching.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出专家授课记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertTeaching/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xmu:res:xmuExpertTeaching:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XmuExpertTeaching> list = ei.getDataList(XmuExpertTeaching.class);
			for (XmuExpertTeaching xmuExpertTeaching : list){
				try{
					xmuExpertTeachingService.save(xmuExpertTeaching);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条专家授课记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条专家授课记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入专家授课失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertTeaching/?repage";
    }
	
	/**
	 * 下载导入专家授课数据模板
	 */
	@RequiresPermissions("xmu:res:xmuExpertTeaching:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "专家授课数据导入模板.xlsx";
    		List<XmuExpertTeaching> list = Lists.newArrayList(); 
    		new ExportExcel("专家授课数据", XmuExpertTeaching.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xmu/res/xmuExpertTeaching/?repage";
    }
	

}