<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>科研资源管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#downloadTemplate").click(function(){
				$("#searchForm").attr("action","${ctx}/sch/res/schTechResource/downloadTemplate");
				$("#searchForm").submit();
				$("#searchForm").attr("action","${ctx}/sch/res/schTechResource/form");
			});
			$("#upfile").change(function(){
				$("#searchForm").attr("action","${ctx}/sch/res/schTechResource/importRes");
				$("#searchForm").attr("enctype","multipart/form-data");
				$("#searchForm").submit();
				$("#searchForm").attr("enctype","");
				$("#searchForm").attr("action","${ctx}/sch/res/schTechResource/form");
			});
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
		<li class="active"><a href="${ctx}/sch/res/schTechResource/">科研资源列表</a></li>
		<shiro:hasPermission name="sch:res:schTechResource:edit"><li><a href="${ctx}/sch/res/schTechResource/form">科研资源添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="schTechResource" action="${ctx}/sch/res/schTechResource/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="upfile" name="upfile" type="file" style="display:none"/>  
		<ul class="ul-form">
			<li><label>资产分类：</label>
				<form:select path="strTypeCode" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('TECH_RESOURCE_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>资产名称：</label>
				<form:input path="strName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>所属部门：</label>
				<sys:treeselect id="strOfficeId" name="strOfficeId" value="${schTechResource.strOfficeId}" labelName="strOfficeName" labelValue="${schTechResource.strOfficeName}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="import" onclick="document.getElementById('upfile').click();" class="btn btn-primary" type="button" value="导入"/></li>
			<li class="btns"><input id="downloadTemplate" class="btn btn-primary" type="button" value="下载模版"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>资产分类代码</th>
				<th>资产名称</th>
				<th>计量单位</th>
				<th>数量/面积</th>
				<th>品牌/规格型号</th>
				<th>单价/均价</th>
				<th>费用</th>
				<th>所属部门</th>
				<shiro:hasPermission name="sch:res:schTechResource:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schTechResource">
			<tr>
				<td><a href="${ctx}/sch/res/schTechResource/form?id=${schTechResource.id}">
					${fns:getDictLabel(schTechResource.strTypeCode, 'TECH_RESOURCE_TYPE', '')}
				</a></td>
				<td>
					${schTechResource.strName}
				</td>
				<td>
					${schTechResource.strUnit}
				</td>
				<td>
					${schTechResource.strPices}
				</td>
				<td>
					${schTechResource.strBrand}
				</td>
				<td>
					${schTechResource.strPrice}
				</td>
				<td>
					${schTechResource.strCosts}
				</td>
				<td>
					${schTechResource.strOfficeName}
				</td>
				<shiro:hasPermission name="sch:res:schTechResource:edit"><td>
    				<a href="${ctx}/sch/res/schTechResource/form?id=${schTechResource.id}">修改</a>
					<a href="${ctx}/sch/res/schTechResource/delete?id=${schTechResource.id}" onclick="return confirmx('确认要删除该科研资源吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>