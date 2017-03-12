<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合同管理</title>
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
		<li class="active"><a href="${ctx}/sch/contract/schTechConcract/">合同列表</a></li>
		<shiro:hasPermission name="sch:contract:schTechConcract:edit"><li><a href="${ctx}/sch/contract/schTechConcract/form">合同添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="schTechConcract" action="${ctx}/sch/contract/schTechConcract/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>合同名称：</label>
				<form:input path="stcName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>合同编号：</label>
				<form:input path="stcNo" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>合同类别：</label>
				<form:select path="stcType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('CONTRACT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>负责人：</label>
				<sys:treeselect id="stcResponseUserId" name="stcResponseUserId" value="${schTechConcract.stcResponseUserId}" labelName="stcResponseUserName" labelValue="${schTechConcract.stcResponseUserName}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>合同状态：</label>
				<form:select path="stcStatus" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('CONTRACT_STATUS')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>合同名称</th>
				<th>合同编号</th>
				<th>合同类别</th>
				<th>学科分类</th>
				<th>所属行业</th>
				<th>负责人</th>
				<th>负责人所属院系</th>
				<th>合同状态</th>
				<th>合同签订日期</th>
				<shiro:hasPermission name="sch:contract:schTechConcract:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schTechConcract">
			<tr>
				<td><a href="${ctx}/sch/contract/schTechConcract/form?id=${schTechConcract.id}">
					${schTechConcract.stcName}
				</a></td>
				<td>
					${schTechConcract.stcNo}
				</td>
				<td>
					${fns:getDictLabel(schTechConcract.stcType, 'CONTRACT_TYPE', '')}
				</td>
				<td>
					${fns:getDictLabel(schTechConcract.stcResearchType, 'CONTRACT_RESEARCH_TYPE', '')}
				</td>
				<td>
					${fns:getDictLabel(schTechConcract.stcIndustry, 'CONTRACT_INDUSTRY', '')}
				</td>
				<td>
					${schTechConcract.stcResponseUserName}
				</td>
				<td>
					${schTechConcract.stcResponseOfficeName}
				</td>
				<td>
					${fns:getDictLabel(schTechConcract.stcStatus, 'CONTRACT_STATUS', '')}
				</td>
				<td>
					<fmt:formatDate value="${schTechConcract.stcSubmitDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="sch:contract:schTechConcract:edit"><td>
					<c:if test="${schTechConcract.stcStatus==1}">
    					<a href="${ctx}/sch/contract/schTechConcract/form?id=${schTechConcract.id}">修改</a>
						<a href="${ctx}/sch/contract/schTechConcract/delete?id=${schTechConcract.id}" onclick="return confirmx('确认要删除该合同吗？', this.href)">删除</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>