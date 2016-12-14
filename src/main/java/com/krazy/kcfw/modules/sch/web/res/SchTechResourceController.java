/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.web.res;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.MimeType;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.web.BaseController;
import com.krazy.kcfw.common.utils.FileUtils;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.utils.excel.ImportExcel;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResource;
import com.krazy.kcfw.modules.sch.service.res.SchTechResourceService;
import com.krazy.kcfw.modules.sys.entity.Office;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.utils.DictUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;

import eu.bitwalker.useragentutils.UserAgent;

/**
 * 科研资源Controller
 * @author Krazy
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/sch/res/schTechResource")
public class SchTechResourceController extends BaseController {

	@Autowired
	private SchTechResourceService schTechResourceService;
	
	@ModelAttribute
	public SchTechResource get(@RequestParam(required=false) String id) {
		SchTechResource entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schTechResourceService.get(id);
		}
		if (entity == null){
			entity = new SchTechResource();
		}
		return entity;
	}
	
	@RequiresPermissions("sch:res:schTechResource:view")
	@RequestMapping(value = {"list", ""})
	public String list(SchTechResource schTechResource, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SchTechResource> page = schTechResourceService.findPage(new Page<SchTechResource>(request, response), schTechResource); 
		model.addAttribute("page", page);
		return "modules/sch/res/schTechResourceList";
	}

	@RequiresPermissions("sch:res:schTechResource:view")
	@RequestMapping(value = "form")
	public String form(SchTechResource schTechResource, Model model) {
		model.addAttribute("schTechResource", schTechResource);
		return "modules/sch/res/schTechResourceForm";
	}

	@RequiresPermissions("sch:res:schTechResource:edit")
	@RequestMapping(value = "save")
	public String save(SchTechResource schTechResource, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schTechResource)){
			return form(schTechResource, model);
		}
		schTechResourceService.save(schTechResource);
		addMessage(redirectAttributes, "保存科研资源成功");
		return "redirect:"+Global.getAdminPath()+"/sch/res/schTechResource/?repage";
	}
	
	@RequiresPermissions("sch:res:schTechResource:edit")
	@RequestMapping(value = "delete")
	public String delete(SchTechResource schTechResource, RedirectAttributes redirectAttributes) {
		schTechResourceService.delete(schTechResource);
		addMessage(redirectAttributes, "删除科研资源成功");
		return "redirect:"+Global.getAdminPath()+"/sch/res/schTechResource/?repage";
	}
	
	@RequiresPermissions("sch:res:schTechResource:view")
	@RequestMapping(value="downloadTemplate")
    public void downloadTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException{
        File file = new File(request.getSession().getServletContext().getRealPath("/")  +"WEB-INF/template/科研资源导入模板.xls");
        //判断文件是否存在
        if(!file.exists()) {
            return;
        }
        FileUtils.downFile(file, request, response);
//        //判断文件类型
//        String mimeType = URLConnection.guessContentTypeFromName(file.getName());
//        if(mimeType == null) {
//            mimeType = "application/octet-stream";
//        }
//        response.setContentType(mimeType);
//         
//        //设置文件响应大小
//        response.setContentLength((int) file.length());
//         
//        //文件名编码，解决乱码问题
//        String fileName = file.getName();
//        String encodedFileName = null;
//        String userAgentString = request.getHeader("User-Agent");
//        String browser = UserAgent.parseUserAgentString(userAgentString).getBrowser().getGroup().getName();
//        if(browser.equals("Chrome") || browser.equals("Internet Exploer") || browser.equals("Safari")) {
//            encodedFileName = URLEncoder.encode(fileName,"utf-8").replaceAll("\\+", "%20");
//        } else {
//            encodedFileName = MimeUtility.encodeWord(fileName);
//        }
//         
//        //设置Content-Disposition响应头，一方面可以指定下载的文件名，另一方面可以引导浏览器弹出文件下载窗口
//        response.setHeader("Content-Disposition", "attachment;fileName=\"" + encodedFileName + "\"");
//         
//        //文件下载
//        InputStream in = new BufferedInputStream(new FileInputStream(file));
//        FileCopyUtils.copy(in, response.getOutputStream());
    }
	
	@RequiresPermissions("sch:res:schTechResource:view")
	@RequestMapping(value="importRes")
    public String importRes(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes) throws Exception{
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;    
          
        InputStream in =null;  
        MultipartFile file = multipartRequest.getFile("upfile");  
        if(file.isEmpty()){  
			throw new Exception("文件不存在！");
        }  
        
		ImportExcel ie=new ImportExcel(file,0,0);
		List<SchTechResource> lists=ie.getDataList(SchTechResource.class);
		//校验数据
		StringBuffer sb=new StringBuffer();
		List<SchTechResource> saveLists=new ArrayList<SchTechResource>();
		for(int i=0;i<lists.size();i++){
			SchTechResource str=lists.get(i);
			SchTechResource saveStr=new SchTechResource();
			BeanUtils.copyProperties(saveStr, str);
			saveStr.setIsNewRecord(false);
			String strName=DictUtils.getDictLabel(str.getStrTypeCode(), "TECH_RESOURCE_TYPE", "");
			if(StringUtils.isBlank(strName)){
				sb.append("导入Excel失败，第"+(i+1)+"行资产分类代码"+str.getStrTypeCode()+"不存在\n\r");
			}
			if(StringUtils.isBlank(str.getStrName())){
				sb.append("导入Excel失败，第"+(i+1)+"行资产名称"+str.getStrUserName()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(str.getStrCode())){
				sb.append("导入Excel失败，第"+(i+1)+"行资产编号"+str.getStrUserName()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(str.getStrUnit())){
				sb.append("导入Excel失败，第"+(i+1)+"行计量单位"+str.getStrUserName()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(str.getStrPices())){
				sb.append("导入Excel失败，第"+(i+1)+"行数量/面积"+str.getStrUserName()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(str.getStrBrand())){
				sb.append("导入Excel失败，第"+(i+1)+"行品牌/规格型号"+str.getStrUserName()+"不能为空\n\r");
			}
			if(StringUtils.isBlank(str.getStrPrice())){
				sb.append("导入Excel失败，第"+(i+1)+"行单价/均价"+str.getStrUserName()+"不能为空\n\r");
			}
			if(str.getStrCreateDate()==null){
				sb.append("导入Excel失败，第"+(i+1)+"行取得日期"+str.getStrUserName()+"不能为空\n\r");
			}
			User user=UserUtils.getByLoginName(str.getStrUserName());
			if(user==null){
				sb.append("导入Excel失败，第"+(i+1)+"行使用人"+str.getStrUserName()+"不存在\n\r");
			}else{
				saveStr.setStrUserId(user.getId());
			}
			if(StringUtils.isBlank(str.getStrOfficeName())){
				sb.append("导入Excel失败，第"+(i+1)+"行使用部门"+str.getStrUserName()+"不能为空\n\r");
			}
			if(user!=null&&!str.getStrOfficeName().equals(user.getOffice().getName())){
				sb.append("导入Excel失败，第"+(i+1)+"行使用部门"+str.getStrUserName()+"不存在\n\r\n\r");
			}else{
				saveStr.setStrOfficeId(user.getOffice().getId());
			}
			saveLists.add(saveStr);
		}
		if(StringUtils.isBlank(sb.toString())){
			schTechResourceService.saveList(saveLists);
			addMessage(redirectAttributes, "导入Excel成功");
		}else{
			addMessage(redirectAttributes, sb.toString());
		}

        return "redirect:"+Global.getAdminPath()+"/sch/res/schTechResource/?repage";
    }
}