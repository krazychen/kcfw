<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default="欢迎光临"/> - ${site.title} - Powered By kcfw</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<link href="${ctxStaticTheme}/index.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctxStaticTheme}/jquery.SuperSlide.2.1.1.js"></script>
	<script type="text/javascript" src="${ctxStaticTheme}/height.js"></script>
	<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.js" type="text/javascript"></script>
	<sitemesh:head/>
</head>
<!-- 
<body style="background:url(${ctxStaticTheme}/images/bg.png) repeat-x"> -->
<body> 
<!-- top -->
<div class="top">
	<div class="top_box">
    	<!-- <img class="logo" src="${ctxStaticTheme}/images/logo.png" /> -->
    </div>
</div>
<!--end top-->
<div class="main">
<!--nav-->
	<div class="main_top">
       <ul class="nav">
       		<li><a href="${ctx}/index-1${fns:getUrlSuffix()}"><span>${site.id eq '1'?'首　 页':'返回主站'}</span></a></li>
       		<c:forEach items="${fnc:getMainNavList(site.id)}" var="category" varStatus="status">
       			<c:if test="${status.index lt 9}">
	    		   <li><a href="${category.url}" target="${category.target}" data-toggle="dropdown"><span>${category.name}</span></a>
    		   		 <ul>
    		   		 <c:forEach items="${fnc:getCategoryList(site.id,category.id,10,'')}" var="subCat" varStatus="catStatus">
	    		   		 <li><a href="${subCat.url}" target="${subCat.target}">${subCat.name}</a></li>
					 </c:forEach>
					</ul>
	    		   </li>
	    		</c:if>
	    	</c:forEach>
       </ul>
    </div>
    </div>
	<div class="container">
		<div class="content">
			<div class="main">
				<sitemesh:body/>
			</div>
		</div>
		<!--footer-->
		
		<!--end footer-->
		<footer>
			<div class="footer">
				<div class="footer_box">
					<div class="copyright">${site.copyright}</div>
			    </div>
			</div>
	 	</footer>
    </div> <!-- /container -->
</body>
</html>