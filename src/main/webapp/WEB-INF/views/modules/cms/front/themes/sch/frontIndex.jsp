<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>产学融合发展处</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="kcfw ${site.description}" />
<meta name="keywords" content="kcfw ${site.keywords}" />
<script type="text/javascript">
		$(document).ready(function() {
			//var container1 = document.getElementById("vCode1");
            //var code1 = new vCode(container1);
			$("#loginForm").validate({
				//rules: {
				//	validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				//},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."}
					//,validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					//alert(error);
					error.appendTo($("#loginError").parent());
				} 
			});
		})
</script>
</head>


<!--end nav-->
<!--att-->
<div class="att">
	<p>特别关注：</p>
	<div class="att_box">
		<div class="search fr">
	   	  <form id="searchform" action="${ctx}/search" method="get">
	           <input class="input_box fl" type="text" id="q" name="q" maxlength="20"  placeholder="全站搜索..." value="${q}">
	           <input type="button" class="input_btn fl" value="" onclick="to_submit();"/>
	      </form>
       </div>
		<ul>
			<c:forEach items="${fnc:getArticleList(site.id, '31f68f68e8cc4e2bb569b2f86917c738', 1, 'posid:2')}" var="article">
				<li><a href="${article.url}"
				title="${fns:abbr(article.title,28)}" target="_blank">${fns:abbr(article.title,200)}</a></li>
			</c:forEach>
			
		</ul>
	</div>
	<script type="text/javascript">
		jQuery(".att").slide({
			mainCell : ".att_box ul",
			autoPlay : true,
			effect : "leftMarquee",
			vis : 3,
			interTime : 40
		});
	</script>
</div>
<!--end att-->
<div class="clear"></div>
<!--news-->
<div class="news fl">
	<div
		style="float: right; position: relative; top: 100px; padding-right: 5px; border-bottom: 1px solid #CCC; width: 340px; margin-right: 15px; text-align: right;">
		<a style="color: #9d0c2a" href="${ctx}/list-31f68f68e8cc4e2bb569b2f86917c738.html">&gt;更多</a>
	</div>
	<div style="height: 95px;">
		<c:forEach items="${fnc:getArticleList(site.id, '31f68f68e8cc4e2bb569b2f86917c738', 1, 'posid:2')}" var="article">
			<h2>
				<a style="color: #9d0c2a"
				href="${article.url}"
				title="${fns:abbr(article.title,28)}" target="_blank">${fns:abbr(article.title,60)}</a>
			</h2>
			<p class="news_p">
				<a style="color: #666;" href="${article.url}"
				title="${fns:abbr(article.title,28)}" target="_blank">${fns:abbr(article.description,150)}<span
				style="color: red;">[详细]</span></a>
			</p>
		</c:forEach>
		
	</div>
	<!-- 焦点图 S -->
	<div class="focusBox fl">
		<script type="text/javascript">
			var focus_width = 320;
			var focus_height = 222;
			var text_height = 18;
			var pic_bgcolor = 'null';
			var swf_height = focus_height + text_height;
			var pics = '';
			var links = '';			
			var texts = '';
			<c:forEach items="${fnc:getArticleList(site.id, '31f68f68e8cc4e2bb569b2f86917c738', 5, 'posid:1')}" var="article" varStatus="stat">
				pics+='${article.image}';
				<c:if test="${!stat.last}">
				pics+="|";
				</c:if>  
				links+='${article.url}';
				<c:if test="${!stat.last}">
				links+="|";
				</c:if>  
				texts+='${fns:abbr(article.title,50)}';
				<c:if test="${!stat.last}">
				texts+="|";
				</c:if>  
			</c:forEach>
			
			document
					.write('<object ID="focus_flash" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ focus_width +'" height="'+ swf_height +'">');
			document
					.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="${ctxStaticTheme}/images/focus1.swf"><param name="quality" value="high"><param name="bgcolor" value="'+pic_bgcolor+'">');
			document
					.write('<param name="menu" value="false"><param name=wmode value="opaque">');
			document
					.write('<param name="FlashVars" value="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'">');
			document
					.write('<embed ID="focus_flash" src="${ctxStaticTheme}/images/focus1.swf" wmode="opaque" FlashVars="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'" menu="false" bgcolor="'+pic_bgcolor+'" quality="high" width="'+ focus_width +'" height="'+ swf_height +'" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
			document.write('</object>');
		</script>
	</div>
	<!-- 焦点图 E -->
	<ul class="news_rt1">
		<c:forEach items="${fnc:getArticleList(site.id, '31f68f68e8cc4e2bb569b2f86917c738', 9, '')}" var="article">
			<li><div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
			<a href="${article.url}"
			title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,50)}</a></li>
		</c:forEach>
	</ul>
</div>
<div class="notice">
	<div class="notice_top">
		<h3>事务通知</h3>
		<a href="${ctx}/list-f7eec0ea994246a7be3e8a72f2797b4f.html">&gt;更多</a>
	</div>
	<ul class="news_rt notice_ul">
		<c:forEach items="${fnc:getArticleList(site.id, 'f7eec0ea994246a7be3e8a72f2797b4f', 12, '')}" var="article">
			<li><div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
			<a href="${article.url}" style="width:210px"
			title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,40)}</a></li>
		</c:forEach>
	</ul>
</div>
<!--end news-->
<div class="clear"></div>
<!-- Tab切换 S -->
<div class="product"
	style="float: left; width: 360px; margin-top: 10px; margin-right: 5px;">
	<div style="float: left;">
		<ul style="background: #e4e4e4; font-size: 14px; height: 32px; line-height: 32px; width: 355px;">
			<li style="background: #9d0c2a; font-weight: bold; width: 90px;"><a
				href="${ctx}/list-05e12bc3a60e430cb3d75132471f17f2.html"
				style="display: block; padding: 0 15px; color: #FFF;">横向事务</a></li>
		</ul>
	</div>
	<div>
		<ul class="news_rt1 product_ul" style="width: 357px;">
			<div style="width: 357px; float: left">
				<c:forEach items="${fnc:getArticleList(site.id, '05e12bc3a60e430cb3d75132471f17f2', 9, '')}" var="article">
					<li><div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
					<a href="${article.url}"
					title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,50)}</a></li>
				</c:forEach>
			</div>
		</ul>
	</div>
</div>
<!-- Tab切换 E -->
<!-- Tab切换 S -->
<div class="slideTxtBox product" style="float: left; width: 355px;">
	<div class="hd">
		<ul>
			<li><a href="${ctx}/list-b05a6067661848db8f00c4ed2569cac3.html">成果对接与应用</a></li>
		</ul>
	</div>
	<div class="bd">
		<ul class="news_rt1 product_ul">
			<div style="width: 357px; float: left">
				<c:forEach items="${fnc:getArticleList(site.id, 'b05a6067661848db8f00c4ed2569cac3', 9, '')}" var="article">
					<li><div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
					<a href="${article.url}"
					title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,50)}</a></li>
				</c:forEach>
			</div>
		</ul>
	</div>
</div>
<script type="text/javascript">
	jQuery(".slideTxtBox").slide({
		easing : "easeOutElastic"
	});
</script>
<!-- Tab切换 E -->
<!--vip-->
<div class="vip">
	<form id="loginForm" action="${ctxA}/login" method="post">
		<div class="vip_top">
			<h3>产学融合信息管理系统</h3>
		</div>
		<div id="messageBox">
			<label id="loginError" >${message}</label>
		</div>
		<div class="vip_box">
			<p>用户名：</p>
			<input class="in_name required" type="text" name="username" id="username" />
		</div>
		<div class="vip_box">
			<p>密&nbsp;&nbsp;&nbsp;&nbsp;码：</p>
			<input style="margin-left: 0px;" type="password" name="password" class="required"
				id="password" />
		</div>
		<!-- 
		<div class="vip_box">
			<p>验证码：</p>
			<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		</div> -->
		<input class="vip_btn" type="submit" value="登&nbsp;&nbsp;&nbsp;录" />
	</form>
</div>
<!--end vip-->
<div class="clear"></div>

<script type="text/javascript">
	jQuery(".picScroll").slide({
		mainCell : "ul",
		autoPlay : true,
		effect : "left",
		vis : 5,
		scroll : 1,
		autoPage : true,
		pnLoop : true
	});
</script>
<!-- 图片滚动 E -->
<div class="clear"></div>

<div class="product"
	style="float: left; width: 360px; margin-top: 10px; margin-right: 5px;">
	<div style="float: left;">
		<ul
			style="background: #e4e4e4; font-size: 14px; height: 32px; line-height: 32px; width: 355px;">
			<li style="background: #9d0c2a; font-weight: bold; width: 90px;"><a
				href="${ctx}/list-e5fa3e4c6b2f4d66a3d70a6f35502820.html"
				style="display: block; padding: 0 15px; color: #FFF;">科研成果</a></li>
		</ul>
	</div>
	<div>
		<ul class="news_rt1 product_ul" style="width: 357px;">
			<div style="width: 357px; float: left">
				<c:forEach items="${fnc:getArticleList(site.id, 'e5fa3e4c6b2f4d66a3d70a6f35502820', 9, '')}" var="article">
					<li><div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
					<a href="${article.url}"
					title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,50)}</a></li>
				</c:forEach>
			</div>
		</ul>
	</div>
</div>
<div class="slideTxtBox product" style="float: left; width: 355px;">
	<div class="hd">
		<ul>
			<li><a href="${ctx}/list-3f884ab530834375b211f4df7e8d2664.html">外驻机构</a></li>
		</ul>
	</div>
	<div class="bd">
		<ul class="news_rt1 product_ul">
			<div style="width: 357px; float: left">
				<c:forEach items="${fnc:getArticleList(site.id, '3f884ab530834375b211f4df7e8d2664', 9, '')}" var="article">
					<li><div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
					<a href="${article.url}"
					title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,50)}</a></li>
				</c:forEach>
			</div>
		</ul>
	</div>
</div>
<script type="text/javascript">
	jQuery(".slideTxtBox").slide({
		easing : "easeOutElastic"
	});
</script>

<div class="hot" style="height: 420px;">
	<div style="float: left;">
		<ul
			style="background: #e4e4e4; font-size: 14px; height: 32px; line-height: 32px; width: 268px;">
			<li style="background: #9d0c2a; font-weight: bold; width: 90px;"><a
				href="${ctx}/list-e5fa3e4c6b2f4d66a3d70a6f35502820.html"
				style="display: block; padding: 0 15px; color: #FFF;">组织信息</a></li>
		</ul>
	</div>
	<div id="priceid10"
		style="float: left; margin: 0px auto; width: 268px; height: 430px; margin-left: 2px;line-height:2;">
		<span style="font-size:15px;color:#9d0c2a">--------厦门理工科研账户信息--------</span><br/>
		开户名称：厦门理工学院<br /> 开户银行：建行厦门学府支行<br /> 帐号：35101547001059000888<br />
		<span style="font-size:15px;color:#9d0c2a">--------厦门理工组织机构代码--------</span><br/>
		42660260-7<br /> 
		<span style="font-size:15px;color:#9d0c2a">---------事业单位法人证书号---------</span><br/>
		事证第135020000060号<br />
		<span style="font-size:15px;color:#9d0c2a">-------------联系方式-----------------</span><br/>
		副处长岗  严老师：6291078<br /> 科长岗  &nbsp;&nbsp;&nbsp;马老师：6291353<br /> 科员岗  &nbsp;&nbsp;&nbsp;周老师：6291358<br />
		科员岗  &nbsp;&nbsp;&nbsp;杜老师：6291886<br /> 科员岗  &nbsp;&nbsp;&nbsp;柳老师：6291886<br />
		科员岗  &nbsp;&nbsp;&nbsp;邱老师：6291356<br />  <br />	
		
	</div>
</div>
<div class="product"
	style="float: left; width: 360px; margin-top: 10px; margin-right: 5px;">
	<div style="float: left;">
		
	</div>
	<div>
		<img height="120" width="160" style="float:left;margin-left:5px;padding-top:15px;"src="${ctxStaticTheme}/images/ios.jpg" />
		<img height="150" width="150" style="float:right;margin-right:18px;" src="${ctxStaticTheme}/images/ioscode.png" />
	</div>
</div>
<div class="product"
	style="float: left; width: 360px; margin-top: 10px; margin-right: 5px;">
	<div style="float: left;">

	</div>
	<div>
		<img height="120" width="120"  style="float:left;margin-left:5px;padding-top:15px;" src="${ctxStaticTheme}/images/android.png" />
		<img height="150" width="150" style="float:right;margin-right:18px;" src="${ctxStaticTheme}/images/ioscode.png" />
	</div>
</div>
<div class="clear"></div>
<!--link-->
<div class="link">
	<img class="link_lt" src="${ctxStaticTheme}/images/link.png" />
	<p class="link_rt">
	<c:forEach items="${fnc:getLinkList(site.id, 'cb6c8ea2a7c2467d98613b536f17e8eb', 9, '')}" var="link">
		<ul>
			<li
				style="float: left; display: block; width: 140px; height: 25px; line-height: 25px;"><a
				href="${link.href}" title="${link.title}" target="_blank">${link.title}</a></li>
		</ul>
	</c:forEach>
	</p>
</div>
<!--end link-->

<script type="text/javascript">
	function to_submit() {
		var keyword = document.getElementById("q").value;
		if (keyword == "") {
			alert("请输入你想要搜索的内容");
			return false;
		} else {
			document.getElementById("searchform").submit();
		}
	}
	function showprice(id) {
		var i = 1;
		for (i == 1; i < 5; i++) {
			if (id == i) {
				document.getElementById("priceid" + id).style.display = "";
			} else {
				document.getElementById("priceid" + i).style.display = "none";
			}
		}
	}
	function showprice2(id) {
		var i = 1;
		for (i == 1; i < 5; i++) {
			if (id == i) {
				document.getElementById("price2id" + id).style.display = "";
			} else {
				document.getElementById("price2id" + i).style.display = "none";
			}
		}
	}
</script>
</body>
</html>