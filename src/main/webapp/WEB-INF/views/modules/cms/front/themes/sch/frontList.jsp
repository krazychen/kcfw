<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${category.name}</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${category.description}" />
	<meta name="keywords" content="${category.keywords}" />
	<style type="text/css">
	.pagination {margin:8px 0;} 
	.pagination .controls a{border:0;}
	.pagination ul {
	    display: inline-block;
	    margin-bottom: 0;
	    margin-left: 0;
	    -webkit-border-radius: 4px;
	    -moz-border-radius: 4px;
	    border-radius: 4px;
	    -webkit-box-shadow: 0 1px 2px rgba(0,0,0,0.05);
	    -moz-box-shadow: 0 1px 2px rgba(0,0,0,0.05);
	    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
	}
	.pagination ul>li {
	    display: inline;
	}
	.pagination .controls input{border:0;color:#999;width:30px;padding:0;margin:-3px 0 0 0;text-align:center;}
	</style>
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
					href="${ctx}/index-${site.id}${urlSuffix}" style="color: #2F2F2F;">首页</a>
				<c:forEach items="${fnc:getCategoryListByIds(category.parentIds)}"
					var="tpl">
					<c:if test="${tpl.id ne '1'}"> >> <a
							href="${ctx}/list-${tpl.id}${urlSuffix}">${tpl.name}</a>
					</c:if>
				</c:forEach>
				>> <a href="${ctx}/list-${category.id}${urlSuffix}">${category.name}</a>
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
			   			<c:otherwise><c:set var="url" value="${ctx}/list-${tpl.id}${urlSuffix}"/></c:otherwise>
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
					<c:if test="${category.module eq 'article'}">
						<ul class="mypagetitle">
							<c:forEach items="${page.list}" var="article">
								<li><div class="li_page_time"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></div>
									<div class="pre_img1"><img src="${ctxStaticTheme}/images/jiantou.jpg"/></div>
									<div class="mypagelink">
									<a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}">${fns:abbr(article.title,90)}</a>
									</div>
								</li>
							</c:forEach>
						</ul>
						<div class="pagination">${page}</div>
						<script type="text/javascript">
							function page(n,s){
								location="${ctx}/list-${category.id}${urlSuffix}?pageNo="+n+"&pageSize="+s;
							}
						</script>
					</c:if>
					<c:if test="${category.module eq 'link'}">
						<ul class="mypagetitle">
							<c:forEach items="${page.list}" var="link">
							<li><div class="li_page_time"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></div>
							<div class="mypagelink">
							<a href="${ctx}${link.href}"  target="_blank" ><c:out value="${link.title}" /></a>
							</div>
							</c:forEach>
						</ul>
				  	</c:if>
				</div>
			</div>
		</div>
		<!--end gover-->
		<div class="clear"></div>
	</div>
	</div>
</body>
</html>