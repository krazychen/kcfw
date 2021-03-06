<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>发明专利管理</title>
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
		<li class="active"><a href="${ctx}/sch/patent/schPatentUnder/">发明专利列表</a></li>
		<shiro:hasPermission name="sch:patent:schPatentUnder:edit"><li><a href="${ctx}/sch/patent/schPatentUnder/form">发明专利添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="schPatentUnder" action="${ctx}/sch/patent/schPatentUnder/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>专利名称：</label>
				<form:input path="spuName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>专利类型：</label>
				<form:select path="spuTypeName" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('PATENT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>专利申请人：</label>
				<form:input path="spuApplySchoolName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>指导老师：</label>
				<sys:treeselect id="schAdvisTeacherId" name="schAdvisTeacherId" value="${schPatentUnder.schAdvisTeacherId}" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${schPatentUnder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>专利名称</th>
				<th>专利类型</th>
				<th>专利申请人</th>
				<th>联络人</th>
				<th>所属院系</th>
				<th>指导老师</th>
				<th>所属院系</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<shiro:hasPermission name="sch:patent:schPatentUnder:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schPatentUnder">
			<tr>
				<td><a href="${ctx}/sch/patent/schPatentUnder/form?id=${schPatentUnder.id}">
					${schPatentUnder.spuName}
				</a></td>
				<td>
					${fns:getDictLabel(schPatentUnder.spuTypeName, 'PATENT_TYPE', '')}
				</td>
				<td>
					${schPatentUnder.spuApplySchoolName}
				</td>
				<td>
					${schPatentUnder.}
				</td>
				<td>
					${schPatentUnder.}
				</td>
				<td>
					${schPatentUnder.}
				</td>
				<td>
					${schPatentUnder.}
				</td>
				<td>
					<fmt:formatDate value="${schPatentUnder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${schPatentUnder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="sch:patent:schPatentUnder:edit"><td>
    				<a href="${ctx}/sch/patent/schPatentUnder/form?id=${schPatentUnder.id}">修改</a>
					<a href="${ctx}/sch/patent/schPatentUnder/delete?id=${schPatentUnder.id}" onclick="return confirmx('确认要删除该发明专利吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>