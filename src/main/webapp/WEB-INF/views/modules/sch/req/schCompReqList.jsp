<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业需求管理</title>
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sch/req/schCompReq/">企业需求列表</a></li>
		<shiro:hasPermission name="sch:req:schCompReq:edit"><li><a href="${ctx}/sch/req/schCompReq/form">企业需求添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="schCompReq" action="${ctx}/sch/req/schCompReq/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>难题名称：</label>
				<form:input path="scrName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>需求状态：</label>
				<form:select path="scrStatus" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('COMPANY_REQ_STATUS')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>所属行业：</label>
				<form:select path="scrIndustry" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('COMPANY_REQ_INDUSTRY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>联系人：</label>
				<form:input path="scrCompanyContact" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>难题名称</th>
				<th>需求状态</th>
				<th>所属行业</th>
				<th>合作方式</th>
				<th>失效日期</th>
				<th>联系人</th>
				<th>联系电话</th>
				<th>电子邮箱</th>
				<shiro:hasPermission name="sch:req:schCompReq:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schCompReq">
			<tr>
				<td><a href="${ctx}/sch/req/schCompReq/form?id=${schCompReq.id}">
					${schCompReq.scrName}
				</a></td>
				<td>
					${fns:getDictLabel(schCompReq.scrStatus, 'COMPANY_REQ_STATUS', '')}
				</td>
				<td>
					${fns:getDictLabel(schCompReq.scrIndustry, 'COMPANY_REQ_INDUSTRY', '')}
				</td>
				<td>
					${fns:getDictLabel(schCompReq.scrCoopMethod, 'COMPANY_REQ_COOP_METHOD', '')}
				</td>
				<td>
					<fmt:formatDate value="${schCompReq.scrExpiryDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${schCompReq.scrCompanyContact}
				</td>
				<td>
					${schCompReq.scrCompanyPhone}
				</td>
				<td>
					${schCompReq.scrCompanyEmail}
				</td>
				<shiro:hasPermission name="sch:req:schCompReq:edit"><td>
    				<a href="${ctx}/sch/req/schCompReq/form?id=${schCompReq.id}">修改</a>
					<a href="${ctx}/sch/req/schCompReq/delete?id=${schCompReq.id}" onclick="return confirmx('确认要删除该企业需求吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>