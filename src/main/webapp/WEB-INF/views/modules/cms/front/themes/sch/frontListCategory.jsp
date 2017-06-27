<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>${category.name}</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="${category.description}" />
<meta name="keywords" content="${category.keywords}" />
</head>
<body>
	<div style="width: 1000px; margin: 0 auto; background: #FFF;">
		<div
			style="width:998px; height:30px; margin:0 auto;border:solid 1px #DADADA;background-repeat:repeat-x; background:url(${ctxStaticTheme}/images/tylm_1.jpg);">
			<div style="float: left; width: 20px; height: 30px;"></div>
			<div
				style="width: 20px; text-align: center; float: left; height: 30px;">
				<img src="${ctxStaticTheme}/images/tylm_7.gif"
					style="margin-top: 5px;">
			</div>
			<div style="float: left; line-height: 30px; padding-left: 10px;">
				<span style="color: #2F2F2F; font-weight: bold;">您当前的位置：</span> <a
					href="${ctx}/indexNew?siteId=${site.id}" style="color: #2F2F2F;">首页</a>
				<c:forEach items="${fnc:getCategoryListByIds(category.parentIds)}"
					var="tpl">
					<c:if test="${tpl.id ne '1'}"> >> <a
							href="${ctx}/listNew?categoryId=${tpl.id}">${tpl.name}</a>
					</c:if>
				</c:forEach>
				>> <a href="${ctx}/listNew?categoryId=${category.id}">${category.name}</a>
			</div>
		</div>
	</div>
	<div class="main" style="min-height: 300px;">
		<!--gover-->
		<div class="gover" style="margin-top: 10px;">
			<div class="gover_lt">
				<c:forEach items="${categoryList}" var="tpl">
					<c:choose>
			   			<c:when test="${not empty tpl.href}">
			    			<c:choose>
				    			<c:when test="${fn:indexOf(tpl.href, '://') eq -1 && fn:indexOf(tpl.href, 'mailto:') eq -1}">
				    				<c:set var="url" value="${ctx}${tpl.href}"/>
				    			</c:when>
				    			<c:otherwise>
				    				<c:set var="url" value="${tpl.href}"/>
				    			</c:otherwise>
				    		</c:choose>
			   			</c:when>
			   			<c:otherwise><c:set var="url" value="${ctx}/listNew?categoryId=${tpl.id}"/></c:otherwise>
			   		</c:choose>
					<h3><em></em><a href="${url}" target="${tpl.target}" >${fns:abbr(tpl.name,22)}</a></h3><ul><li></li></ul>
				</c:forEach>
			</div>
			<script type="text/javascript">
				jQuery(".gover_lt").slide({
					titCell : "h3",
					targetCell : "ul",
					defaultIndex : 1,
					delayTime : 0,
					trigger : "click",
					triggerTime : 0,
					defaultPlay : false
				});
			</script>
			<div class="gover_rt">
				<div class="gover_rt_top">
					<h3>${category.name}</h3>
				</div>
				<div class="cont-detail">
					<ul class="mypagetitle">
						<c:forEach items="${fnc:getArticleList(site.id, category.id, 12, '')}" var="article">
							<li><div class="li_page_time"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></div>
								<div class="pre_img1"><img src="${ctxStaticTheme}/images/jiantou.jpg"/></div>
								<div class="mypagelink">
								<a href="${ctx}/viewNew?categoryId=${article.category.id}&contentId=${article.id}">${fns:abbr(article.title,85)}</a>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<!--end gover-->
		<div class="clear"></div>
	</div>
	</div>
</body>
</html>