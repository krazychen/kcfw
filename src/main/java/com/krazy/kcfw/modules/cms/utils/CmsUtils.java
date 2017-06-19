/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.cms.utils;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.google.common.collect.Lists;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.common.mapper.JsonMapper;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.utils.CacheUtils;
import com.krazy.kcfw.common.utils.SpringContextHolder;
import com.krazy.kcfw.modules.cms.entity.Article;
import com.krazy.kcfw.modules.cms.entity.Category;
import com.krazy.kcfw.modules.cms.entity.Link;
import com.krazy.kcfw.modules.cms.entity.Site;
import com.krazy.kcfw.modules.cms.service.ArticleDataService;
import com.krazy.kcfw.modules.cms.service.ArticleService;
import com.krazy.kcfw.modules.cms.service.CategoryService;
import com.krazy.kcfw.modules.cms.service.LinkService;
import com.krazy.kcfw.modules.cms.service.SiteService;
import com.krazy.kcfw.modules.sch.entity.req.SchCompReq;
import com.krazy.kcfw.modules.sch.service.req.SchCompReqService;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

/**
 * 内容管理工具类
 * @author krazy
 * @version 2013-5-29
 */
public class CmsUtils {
	
	private static SiteService siteService = SpringContextHolder.getBean(SiteService.class);
	private static CategoryService categoryService = SpringContextHolder.getBean(CategoryService.class);
	private static ArticleService articleService = SpringContextHolder.getBean(ArticleService.class);
	private static LinkService linkService = SpringContextHolder.getBean(LinkService.class);
    private static ServletContext context = SpringContextHolder.getBean(ServletContext.class);
    private static ArticleDataService articleDataService = SpringContextHolder.getBean(ArticleDataService.class);


	private static final String CMS_CACHE = "cmsCache";
	
	/**
	 * 获得站点列表
	 */
	public static List<Site> getSiteList(){
		@SuppressWarnings("unchecked")
		List<Site> siteList = (List<Site>)CacheUtils.get(CMS_CACHE, "siteList");
		if (siteList == null){
			Page<Site> page = new Page<Site>(1, -1);
			page = siteService.findPage(page, new Site());
			siteList = page.getList();
			CacheUtils.put(CMS_CACHE, "siteList", siteList);
		}
		return siteList;
	}
	
	/**
	 * 获得站点信息
	 * @param siteId 站点编号
	 */
	public static Site getSite(String siteId){
		String id = "1";
		if (StringUtils.isNotBlank(siteId)){
			id = siteId;
		}
		for (Site site : getSiteList()){
			if (site.getId().equals(id)){
				return site;
			}
		}
		return new Site(id);
	}
	
	/**
	 * 获得主导航列表
	 * @param siteId 站点编号
	 */
	public static List<Category> getMainNavList(String siteId){
		@SuppressWarnings("unchecked")
		List<Category> mainNavList = (List<Category>)CacheUtils.get(CMS_CACHE, "mainNavList_"+siteId);
		if (mainNavList == null){
			Category category = new Category();
			category.setSite(new Site(siteId));
			category.setParent(new Category("1"));
			category.setInMenu(Global.SHOW);
			Page<Category> page = new Page<Category>(1, -1);
			page = categoryService.find(page, category);
			mainNavList = page.getList();
			CacheUtils.put(CMS_CACHE, "mainNavList_"+siteId, mainNavList);
		}
		return mainNavList;
	}
	
	/**
	 * 获取栏目
	 * @param categoryId 栏目编号
	 * @return
	 */
	public static Category getCategory(String categoryId){
		return categoryService.get(categoryId);
	}
	
	/**
	 * 获得栏目列表
	 * @param siteId 站点编号
	 * @param parentId 分类父编号
	 * @param number 获取数目
	 * @param param  预留参数，例： key1:'value1', key2:'value2' ...
	 */
	public static List<Category> getCategoryList(String siteId, String parentId, int number, String param){
		Page<Category> page = new Page<Category>(1, number, -1);
		Category category = new Category();
		category.setSite(new Site(siteId));
		category.setParent(new Category(parentId));
		if (StringUtils.isNotBlank(param)){
			@SuppressWarnings({ "unused", "rawtypes" })
			Map map = JsonMapper.getInstance().fromJson("{"+param+"}", Map.class);
		}
		page = categoryService.find(page, category);
		return page.getList();
	}

	/**
	 * 获取栏目
	 * @param categoryIds 栏目编号
	 * @return
	 */
	public static List<Category> getCategoryListByIds(String categoryIds){
		return categoryService.findByIds(categoryIds);
	}
	
	/**
	 * 获取文章
	 * @param articleId 文章编号
	 * @return
	 */
	public static Article getArticle(String articleId){
		Article article = articleService.get(articleId);
		article.setArticleData(articleDataService.get(article.getId()));
		return article;
	}
	
	/**
	 * 获取文章列表
	 * @param siteId 站点编号
	 * @param categoryId 分类编号
	 * @param number 获取数目
	 * @param param  预留参数，例： key1:'value1', key2:'value2' ...
	 * 			posid	推荐位（1：首页焦点图；2：栏目页文章推荐；）
	 * 			image	文章图片（1：有图片的文章）
	 *          orderBy 排序字符串
	 * @return
	 * ${fnc:getArticleList(category.site.id, category.id, not empty pageSize?pageSize:8, 'posid:2, orderBy: \"hits desc\"')}"
	 */
	public static List<Article> getArticleList(String siteId, String categoryId, int number, String param){
		Page<Article> page = new Page<Article>(1, number, -1);
		Category category = new Category(categoryId, new Site(siteId));
		category.setParentIds(categoryId);
		Article article = new Article(category);
		if (StringUtils.isNotBlank(param)){
			@SuppressWarnings({ "rawtypes" })
			Map map = JsonMapper.getInstance().fromJson("{"+param+"}", Map.class);
			if (new Integer(1).equals(map.get("posid")) || new Integer(2).equals(map.get("posid"))){
				article.setPosid(String.valueOf(map.get("posid")));
			}
			if (new Integer(1).equals(map.get("image"))){
				article.setImage(Global.YES);
			}
			if (StringUtils.isNotBlank((String)map.get("orderBy"))){
				page.setOrderBy((String)map.get("orderBy"));
			}
		}
		article.setDelFlag(Article.DEL_FLAG_NORMAL);
		page = articleService.findPage(page, article, false);
		return page.getList();
	}
	
	/**
	 * 获取链接
	 * @param linkId 文章编号
	 * @return
	 */
	public static Link getLink(String linkId){
		return linkService.get(linkId);
	}
	
	/**
	 * 获取链接列表
	 * @param siteId 站点编号
	 * @param categoryId 分类编号
	 * @param number 获取数目
	 * @param param  预留参数，例： key1:'value1', key2:'value2' ...
	 * @return
	 */
	public static List<Link> getLinkList(String siteId, String categoryId, int number, String param){
		Page<Link> page = new Page<Link>(1, number, -1);
		Link link = new Link(new Category(categoryId, new Site(siteId)));
		if (StringUtils.isNotBlank(param)){
			@SuppressWarnings({ "unused", "rawtypes" })
			Map map = JsonMapper.getInstance().fromJson("{"+param+"}", Map.class);
		}
		link.setDelFlag(Link.DEL_FLAG_NORMAL);
		page = linkService.findPage(page, link, false);
		return page.getList();
	}
	
	// ============== Cms Cache ==============
	
	public static Object getCache(String key) {
		return CacheUtils.get(CMS_CACHE, key);
	}

	public static void putCache(String key, Object value) {
		CacheUtils.put(CMS_CACHE, key, value);
	}

	public static void removeCache(String key) {
		CacheUtils.remove(CMS_CACHE, key);
	}

    /**
     * 获得文章动态URL地址
   	 * @param article
   	 * @return url
   	 */
    public static String getUrlDynamic(Article article) {
        if(StringUtils.isNotBlank(article.getLink())){
            return article.getLink();
        }
        StringBuilder str = new StringBuilder();
        str.append(context.getContextPath()).append(Global.getFrontPath());
        str.append("/view-").append(article.getCategory().getId()).append("-").append(article.getId()).append(Global.getUrlSuffix());
        return str.toString();
    }

    /**
     * 获得栏目动态URL地址
   	 * @param category
   	 * @return url
   	 */
    public static String getUrlDynamic(Category category) {
        if(StringUtils.isNotBlank(category.getHref())){
            if(!category.getHref().contains("://")){
                return context.getContextPath()+Global.getFrontPath()+category.getHref();
            }else{
                return category.getHref();
            }
        }
        StringBuilder str = new StringBuilder();
        str.append(context.getContextPath()).append(Global.getFrontPath());
        str.append("/list-").append(category.getId()).append(Global.getUrlSuffix());
        return str.toString();
    }

    /**
     * 从图片地址中去除ContextPath地址
   	 * @param src
   	 * @return src
   	 */
    public static String formatImageSrcToDb(String src) {
        if(StringUtils.isBlank(src)) return src;
        if(src.startsWith(context.getContextPath() + "/userfiles")){
            return src.substring(context.getContextPath().length());
        }else{
            return src;
        }
    }

    /**
     * 从图片地址中加入ContextPath地址
   	 * @param src
   	 * @return src
   	 */
    public static String formatImageSrcToWeb(String src) {
        if(StringUtils.isBlank(src)) return src;
        if(src.startsWith(context.getContextPath() + "/userfiles")){
            return src;
        }else{
            return context.getContextPath()+src;
        }
    }
    
    public static void addViewConfigAttribute(Model model, String param){
        if(StringUtils.isNotBlank(param)){
            @SuppressWarnings("rawtypes")
			Map map = JsonMapper.getInstance().fromJson(param, Map.class);
            if(map != null){
                for(Object o : map.keySet()){
                    model.addAttribute("viewConfig_"+o.toString(), map.get(o));
                }
            }
        }
    }

    public static void addViewConfigAttribute(Model model, Category category){
        List<Category> categoryList = Lists.newArrayList();
        Category c = category;
        boolean goon = true;
        do{
            if(c.getParent() == null || c.getParent().isRoot()){
                goon = false;
            }
            categoryList.add(c);
            c = c.getParent();
        }while(goon);
        Collections.reverse(categoryList);
        for(Category ca : categoryList){
        	addViewConfigAttribute(model, ca.getViewConfig());
        }
    }
    
    
    //获取企业需求
	private static SchCompReqService schCompReqService=SpringContextHolder.getBean(SchCompReqService.class);
	
	public static List<Article> getCompReqList(int number, String param){
		Page<Article> page = new Page<Article>(1, number, -1);
		
		List<Article> articles=Lists.newArrayList();
		SchCompReq qq=new SchCompReq();
		
		//krazy 更新为获取审核状态的企业需求
		qq.setScrStatus("3");
		List<SchCompReq> reqPage = schCompReqService.findPageList(qq);
		if(reqPage.size()>0){
			if(reqPage.size()<=number){
				number=reqPage.size();
			}
			for(int i=0;i<number;i++){
				SchCompReq scr=reqPage.get(i);
				Article ar=new Article();
				ar.setId(scr.getId());
				ar.setTitle(scr.getScrName());
				ar.setUpdateDate(scr.getUpdateDate());
				articles.add(ar);
			}
		}
		
		return articles;
	}
	
	public static Article getCompReq(String id){

		SchCompReq req = schCompReqService.get(id);
		Article ar=new Article();
		ar.setId(req.getId());
		ar.setTitle(req.getScrName());
		ar.setUpdateDate(req.getUpdateDate());

		return ar;
	}
	
	public static Boolean compareCurDate(String date){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy", Locale.US);
		try
		{
			Date d1 = df.parse(df.format(new Date()));
			Date d2 = sdf.parse(date);
			long diff = d1.getTime() - d2.getTime();
			long days = diff / (1000 * 60 * 60 * 24);
			if(days<=7){
				return true;
			}else{
				return false;
			}
		}
		catch (Exception e)
		{
			return false;
		}
	}
}