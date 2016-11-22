<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专利机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function changePW(id){
			
			var html  ="<br/>"+
			"<form class='msg-div form-horizontal'>"+
				"<div class='row'> <div class='span6'>   "+
					"<div class='control-group'>"+
						"<label class='control-label'>请输入新的密码：</label>"+
						"<div class='controls' style='line-height:25px;'><input type='password' id='password' name='password' /></div>"+
					"</div>"+
				"</div></div>"+
				"<div class='row'><div class='span6'>"+
					"<div class='control-group'>"+
						"<label class='control-label'>请再次输入新的密码：</label>"+
						"<div class='controls' style='line-height:25px;'><input type='password' id='password2' name='password2' /></div>"+
					"</div>"+
				"</div></div>"+
			"</form>";
			var submit = function (v, h, f) {
				if(v==0){
					return true;
				}
				if(f.password!=f.password2){
					alert("密码不一致，请重新输入!");
					return false;
				}
				$.ajax({
					type: "POST",
					url: "${ctx}/sch/patent/schPatentAgency/changePW",
					data: { //发送给数据库的数据
						id:id,
						password:f.password
					},
					dataType: 'json',
					success: function(data) {
						if(data.result=='faild'){
							if(data.message!=''){
								alert(data.message);	
							}else{
								alert('修改密码失败！');	
							}
						
						}else{
							alert(data.message);	
						}
						
						
					}
				})
			    return true;
			};
			top.$.jBox.open(html,"修改密码",500,200,{
				buttons:{'确认修改':1,'取消': 0},
				submit: submit});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sch/patent/schPatentAgency/">专利机构列表</a></li>
		<shiro:hasPermission name="sch:patent:schPatentAgency:edit"><li><a href="${ctx}/sch/patent/schPatentAgency/form">专利机构添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="schPatentAgency" action="${ctx}/sch/patent/schPatentAgency/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>机构名称：</label>
				<form:input path="spaName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>联系人：</label>
				<form:input path="spaContacts" htmlEscape="false" maxlength="45" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>机构代码</th>
				<th>机构名称</th>
				<th>联系人</th>
				<th>联系方式</th>
				<th>联系地址</th>
				<shiro:hasPermission name="sch:patent:schPatentAgency:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schPatentAgency">
			<tr>
				<td><a href="${ctx}/sch/patent/schPatentAgency/form?id=${schPatentAgency.spaCode}">
					${schPatentAgency.spaCode}
				</a></td>
				<td>
					${schPatentAgency.spaName}
				</td>
				<td>
					${schPatentAgency.spaContacts}
				</td>
				<td>
					${schPatentAgency.spaPhone}
				</td>
				<td>
					${schPatentAgency.spaAddress}
				</td>
				<shiro:hasPermission name="sch:patent:schPatentAgency:edit"><td>
    				<a href="${ctx}/sch/patent/schPatentAgency/form?id=${schPatentAgency.spaCode}">修改</a>
    				<a href="#" onclick="changePW('${schPatentAgency.spaCode}')">修改密码</a>
					<a href="${ctx}/sch/patent/schPatentAgency/delete?id=${schPatentAgency.spaCode}" onclick="return confirmx('确认要删除该专利机构吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>