<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
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
				<li><a href="${ctx}${article.url}"
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
		<a style="color: #9d0c2a" href="${ctx}/listNew?categoryId=4ca4a6c7cd574fd985dfb154daee2bac">&gt;更多</a>
	</div>
	<div style="height: 95px;">
		<c:forEach items="${fnc:getArticleList(site.id, '4ca4a6c7cd574fd985dfb154daee2bac', 1, 'posid:2')}" var="article">
			<h2>
				<a style="color: #9d0c2a"
				href="${ctx}${article.url}"
				title="${fns:abbr(article.title,28)}" target="_blank">${fns:abbr(article.title,60)}</a>
			</h2>
			<p class="news_p">
				<a style="color: #666;" href="${ctx}${article.url}"
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
			<c:forEach items="${fnc:getArticleList(site.id, '4ca4a6c7cd574fd985dfb154daee2bac', 6, 'posid:1')}" var="article" varStatus="stat">
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
					.write('<object ID="focus_flash" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"  width="'+ focus_width +'" height="'+ swf_height +'">');
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
		<c:forEach items="${fnc:getArticleList(site.id, '4ca4a6c7cd574fd985dfb154daee2bac', 9, '')}" var="article">
			<li><div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
			<a href="${ctx}${article.url}"
			title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,50)}</a></li>
		</c:forEach>
	</ul>
</div>
<div class="notice">
	<div class="notice_top">
		<h3>信息公开</h3>
		<a href="${ctx}/listNew?categoryId=6ac1fc5f127d4ab790062b47f5870078">&gt;更多</a>
	</div>
	<ul class="news_rt notice_ul">
		<c:forEach items="${fnc:getArticleList(site.id, '6ac1fc5f127d4ab790062b47f5870078', 12, '')}" var="article">
			<li>
				<a href="${ctx}${article.url}" style="width:180px"
				title="${fns:abbr(article.title,50)}" target="_blank">${fns:abbr(article.title,40)}</a>
				<c:if test="${fnc:compareCurDate(article.updateDate) }">
					<div class="li_time">
					<img height="10" width="20" style="padding-top:7px;" src="${ctxStaticTheme}/images/new.jpg" />&nbsp;<fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				<c:if test="${!fnc:compareCurDate(article.updateDate) }">
					<div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
			</li>
		</c:forEach>
	</ul>
</div>
<div style=" float: left;width: 710px;">
	<!--end news-->
	<div class="clear"></div>
	<!-- Tab切换 S -->
	<div class="notice2" style="margin-left:0px;">
		<div class="notice2_top">
			<h3>事务通知</h3>
			<a href="${ctx}/listNew?categoryId=a84c9d420d834c62aa9f0cc41a58217d">&gt;更多</a>
		</div>
		<ul class="news_rt1 notice2_ul">
			<c:forEach items="${fnc:getArticleList(site.id, 'a84c9d420d834c62aa9f0cc41a58217d', 6, '')}" var="article">
				<li>
				<a href="${ctx}${article.url}" style="width:270px"
				title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,65)}</a>
				<c:if test="${fnc:compareCurDate(article.updateDate) }">
					<div class="li_time">
					<img height="10" width="20" style="padding-top:7px;" src="${ctxStaticTheme}/images/new.jpg" />&nbsp;<fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				<c:if test="${!fnc:compareCurDate(article.updateDate) }">
					<div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="notice2">
		<div class="notice2_top">
			<h3>成果展示</h3>
			<a href="${ctx}/listNew?categoryId=62d7056dc9b045c2b093234f5af44ea0">&gt;更多</a>
		</div>
		<ul class="news_rt1 notice2_ul">
			<c:forEach items="${fnc:getArticleList(site.id, '62d7056dc9b045c2b093234f5af44ea0', 6, '')}" var="article">
				<li>
				<a href="${ctx}${article.url}" style="width:300px"
				title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,40)}</a>
				<c:if test="${fnc:compareCurDate(article.updateDate) }">
					<div class="li_time">
					<img height="10" width="20" style="padding-top:7px;" src="${ctxStaticTheme}/images/new.jpg" />&nbsp;<fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				<c:if test="${!fnc:compareCurDate(article.updateDate) }">
					<div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<!-- 图片滚动 E -->
	<div class="clear"></div>
	<div class="notice2" style="margin-left:0px;">
		<div class="notice2_top">
			<h3>企业需求</h3>
			<!-- <a href="${ctx}/listNew?categoryId=e7660b429529446b85bb7bed854381c2.html">&gt;更多</a> -->
			 <a href="${ctx}/listReq.html">&gt;更多</a>
		</div>
		<ul class="news_rt1 notice2_ul">
		<!-- 
			<c:forEach items="${fnc:getArticleList(site.id, 'e7660b429529446b85bb7bed854381c2', 6, '')}" var="article">
				<li><div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				<a href="${article.url}" style="width:300px"
				title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,80)}</a></li>
			</c:forEach> -->
			<c:forEach items="${fnc:getCompReqList( 6, '')}" var="article">
				<li>
				<!-- 取消跳转
				<a href="${ctx}/viewReq-${article.id}" style="width:300px"
				title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,80)}</a> -->
				<a href="#" style="width:300px"
				title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,80)}</a>
				<c:if test="${fnc:compareCurDate(article.updateDate) }">
					<div class="li_time">
					<img height="10" width="20" style="padding-top:7px;" src="${ctxStaticTheme}/images/new.jpg" />&nbsp;<fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				<c:if test="${!fnc:compareCurDate(article.updateDate) }">
					<div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				</li>
			</c:forEach> 
		</ul>
	</div>
	<div class="notice2">
		<div class="notice2_top">
			<h3 style="padding-left:13px">服务闽西南</h3>
			<a href="${ctx}/listNew?categoryId=5d9f257f11a242188359cbff97357759">&gt;更多</a>
		</div>
		<ul class="news_rt1 notice2_ul">
			<c:forEach items="${fnc:getArticleList(site.id, '5d9f257f11a242188359cbff97357759', 6, '')}" var="article">
				<li>
				<a href="${ctx}${article.url}" style="width:300px"
				title="${fns:abbr(article.title,60)}" target="_blank">${fns:abbr(article.title,40)}</a>
				<c:if test="${fnc:compareCurDate(article.updateDate) }">
					<div class="li_time">
					<img height="10" width="20" style="padding-top:7px;" src="${ctxStaticTheme}/images/new.jpg" />&nbsp;<fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				<c:if test="${!fnc:compareCurDate(article.updateDate) }">
					<div class="li_time"><fmt:formatDate value="${article.updateDate}" pattern="MM-dd"/></div>
				</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="clear"></div>
	<div class="notice2" style="margin-left:0px;">
		<div class="notice2_top">
			<h3>友情连接</h3>
		</div>
		<div  style="margin-top:13px; line-height:2;">
			<select style="margin-left:8px;width:270px;height:25px;" onchange="openWindow()" id="links">
			 	<option value ="">请选择链接</option>
				<c:forEach items="${fnc:getLinkList(site.id, 'cb6c8ea2a7c2467d98613b536f17e8eb', 20, '')}" var="link">
					<option value ="${link.href}" >${link.title}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="notice2">
		<div class="notice2_top">
			<h3 style="padding-left:13px">产学融APP</h3>
		</div>
	<div>
			<img height="50" width="100" style="float:left;margin-left:25px;padding-top:15px;" src="${ctxStaticTheme}/images/ios.png" />
			<img height="50" width="100"  style="float:left;margin-left:80px;padding-top:15px;" src="${ctxStaticTheme}/images/and.png" />
		</div>
	</div>
</div>
<div style=" float: right;width: 270px;">
	<div class="notice" style="height:580px">
		<div class="notice_top">
			<h3>应用</h3>
		</div>		
		<a class="mess2" href="http://my.xmut.edu.cn/" target="_blank" style="margin-top:7px;">
		<img src="${ctxStaticTheme}/images/sch.png" />
		</a>
		<a class="mess2" href="http://cms.9117fly.com/cms/index.html" target="_blank" style="margin-top:5px;">
		<img src="${ctxStaticTheme}/images/project.png" />
		</a>
		<div  style="margin-top:90px; line-height:2;">
			<img src="${ctxStaticTheme}/images/con1.png" />
			<br/>
			<div style="margin-left:10px">
			<c:set var="article1" value="${fnc:getArticle('8c4295e681044af9bc074eac99f1499f')}"/>
			 <p>${article1.articleData.content}</p>
			</div>
		</div>
		<div  style="margin-top:7px; line-height:2;">
			<img src="${ctxStaticTheme}/images/con4.png" />
			<br/>
			<div style="margin-left:10px">
			<c:set var="article2" value="${fnc:getArticle('e2b69c4a1dad4b4191a908c20acf6127')}"/>
			 <p>${article2.articleData.content}</p>
			</div>
		</div>
		<div  style="margin-top:7px; line-height:2;">
			<img src="${ctxStaticTheme}/images/con3.png" />
			<br/>
			<div style="margin-left:10px">
			<c:set var="article3" value="${fnc:getArticle('da25ac01e190456794b5b83ef51bde5f')}"/>
			 <p>${article3.articleData.content}</p>
			</div>
		</div>
		<div  style="margin-top:7px; line-height:2;">
			<img src="${ctxStaticTheme}/images/con2.png" />
			<br/>
			<div style="margin-left:10px">
			<c:set var="article4" value="${fnc:getArticle('210d3a4d629347bf93344bc1e855e8a1')}"/>
			 <p>${article4.articleData.content}</p>
			</div>
		</div>
	</div>
</div>
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
	function openWindow(){
		var url=$("#links").val();
		if(url)
		window.open(url);
	}
</script>
</body>
</html>