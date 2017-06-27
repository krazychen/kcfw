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
       		<li><a href="${ctx}/indexNew?siteId=1}"><span>${site.id eq '1'?'首　 页':'返回主站'}</span></a></li>
       		<c:forEach items="${fnc:getMainNavList(site.id)}" var="category" varStatus="status">
       			<c:if test="${status.index lt 9}">
	    		   <li>
	    		   <c:if test="${category.module ne 'link' }">
	    		   		<a href="${ctx}${category.url}" target="${category.target}" data-toggle="dropdown"><span>${category.name}</span></a>
	    		   </c:if>
	    		   <c:if test="${category.module eq 'link' }">
	    		   		<a href="${category.url}" target="${category.target}" data-toggle="dropdown"><span>${category.name}</span></a>
	    		   </c:if>
    		   		 <ul>
    		   		 <c:forEach items="${fnc:getCategoryList(site.id,category.id,10,'')}" var="subCat" varStatus="catStatus">
	    		   		 <li><a href="${ctx}${subCat.url}" target="${subCat.target}">${subCat.name}</a></li>
					 </c:forEach>
					</ul>
	    		   </li>
	    		</c:if>
	    	</c:forEach>
       </ul>
    </div>

	<div class="container">
		<div class="content">
			<div class="main">
				<sitemesh:body/>
			</div>
		</div>
		<!--footer-->
		
    </div> <!-- /container -->
    </div>
    <div id="footer" class="footer">
    <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1261153447'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s11.cnzz.com/z_stat.php%3Fid%3D1261153447%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
    <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1261153447'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s11.cnzz.com/z_stat.php%3Fid%3D1261153447%26online%3D1%26show%3Dline' type='text/javascript'%3E%3C/script%3E"));</script>
	<div class="footer_box">
	<span>
	<br/>
	<br/>
	Copyright ©2016 ky.xmut.edu.cn 厦门理工学院产学融合发展处 版权所有<br/><br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;地址：厦门市集美区理工路600号 邮编:361024
	</span>
    </div>
</div>
</body>
</html>