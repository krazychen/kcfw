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
		<li class="active"><a href="${ctx}/sch/contract/schComConcract/">合同列表</a></li>
		<!--<shiro:hasPermission name="sch:contract:schComConcract:edit"><li><a href="${ctx}/sch/contract/schComConcract/form">合同添加</a></li></shiro:hasPermission>
	-->
	</ul>
	<form:form id="searchForm" modelAttribute="schComConcract" action="${ctx}/sch/contract/schComConcract/listSuper" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>合同名称：</label>
				<form:input path="sccName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>合同编号：</label>
				<form:input path="sccNo" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>合同类别：</label>
				<form:select path="sccType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('CONTRACT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>负责人：</label>
				<sys:treeselect id="sccResponseUserId" name="sccResponseUserId" value="${schComConcract.sccResponseUserId}" labelName="sccResponseUserName" labelValue="${schComConcract.sccResponseUserName}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>合同状态：</label>
				<form:select path="sccStatus" class="input-medium">
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
				<th>研究方向</th>
				<th>所属行业</th>
				<th>负责人</th>
				<th>负责人所属院系</th>
				<th>合同状态</th>
				<th>合同签订日期</th>
				<shiro:hasPermission name="sch:contract:schComConcract:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schComConcract">
			<tr>
				<td><a href="${ctx}/sch/contract/schComConcract/form?id=${schComConcract.id}">
					${schComConcract.sccName}
				</a></td>
				<td>
					${schComConcract.sccNo}
				</td>
				<td>
					${fns:getDictLabel(schComConcract.sccType, 'CONTRACT_TYPE', '')}
				</td>
				<td>
					${fns:getDictLabel(schComConcract.sccResearchType, 'CONTRACT_RESEARCH_TYPE', '')}
				</td>
				<td>
					${fns:getDictLabel(schComConcract.sccIndustry, 'CONTRACT_INDUSTRY', '')}
				</td>
				<td>
					${schComConcract.sccResponseUserName}
				</td>
				<td>
					${schComConcract.sccResponseOfficeName}
				</td>
				<td>
					${fns:getDictLabel(schComConcract.sccStatus, 'CONTRACT_STATUS', '')}
				</td>
				<td>
					<fmt:formatDate value="${schComConcract.sccSubmitDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="sch:contract:schComConcract:edit"><td>
					<c:if test="${schComConcract.sccStatus==1}">
    					<a href="${ctx}/sch/contract/schComConcract/formSuper?id=${schComConcract.id}">修改</a>
						<a href="${ctx}/sch/contract/schComConcract/delete?id=${schComConcract.id}" onclick="return confirmx('确认要删除该合同吗？', this.href)">删除</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>