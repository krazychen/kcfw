<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${article.title} - ${category.name}</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
	<script type="text/javascript">
		$(document).ready(function() {
		});
	</script>
</head>
<body>
<div style="width:1000px; margin:0 auto; background:#FFF;">
<div style="width:998px; height:30px; margin:0 auto;border:solid 1px #DADADA;background-repeat:repeat-x; background:url(${ctxStaticTheme}/images/tylm_1.jpg);">
	<div style="float:left; width:20px; height:30px;"></div>
	<div style="width:20px; text-align:center; float:left; height:30px;">
		<img src="${ctxStaticTheme}/images/tylm_7.gif" style="margin-top:5px;">
	</div>
	<div style="float:left;line-height:30px;padding-left:10px;">
		<span style="color:#2F2F2F; font-weight:bold;">您当前的位置：</span>
		<a href="${ctx}/index-${site.id}${urlSuffix}" style="color:#2F2F2F;">首页</a> 
		<c:forEach items="${fnc:getCategoryListByIds(category.parentIds)}" var="tpl">
			<c:if test="${tpl.id ne '1'}"> >> <a href="${ctx}/list-${tpl.id}${urlSuffix}">${tpl.name}</a></c:if>
		</c:forEach> >> <a href="${ctx}/list-${category.id}${urlSuffix}">${category.name}</a> >> 信息详情
</div>
</div>
</div>
<div style="width:1000px; height:5px; margin:0 auto;background:#FFF;"></div>
<div style="width:998px; margin:0 auto;background:#FFF;">
<div id="contentall" style="width:998px; float:left;background:#FFF;border: 1px solid #CCC;">
	<div id="titleid" style="color: #d9442e;font-size: 24px;font-weight: bold;line-height: 1.2; padding: 12px 0 12px;text-align: center;">${article.title}                                                                                                                                                                                                                                                        </div>
    
	<div style="height:24px; line-height:24px;width:920px;margin:0 auto;">
		<div style="font-size:12px; color:#666;text-align: center; ">&nbsp;&nbsp;发布时间：<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;作者：${article.user.name} &nbsp;&nbsp; 文章来源：${article.articleData.copyfrom} &nbsp;&nbsp;  <!--点击率：105   &nbsp;&nbsp;--> 
        </div>
    </div>
    <div id="zoom" style="width:940px;margin:0px auto;min-height:300px;color: #666;font-family: '微软雅黑';font-size: 14px;line-height: 28px;padding: 0 30px; padding-top:36px;text-indent: 28px;">${article.articleData.content}</div>
 	<div class="clear" style="background:#FFF; width:1000px; margin:0 auto;"></div>
	<div class="btn_z" style="height: 28px; margin: 10px;">
    	<a class="newbtn_z" href="javascript:window.close()">关闭窗口</a>
 <!--    <a class="newbtn_z" href="javascript:window.print()">打印本页</a> -->
    	<a class="newbtn_z" href="#">回到顶端</a>
	</div>
</div>
</div>
</div>
<script type="text/javascript">
	function init(){
	  $("#zoom img").css("width","600px");
	  $("#zoom img").css("height","400px");
	
	}
	init();
	$( document ).ready(function() {
		  $("#footer").hide();
		  
	});
</script>
</body>
</html>