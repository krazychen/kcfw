<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>项目列表 </h5>
		<div class="ibox-tools">
			<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-wrench"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#">选项1</a>
				</li>
				<li><a href="#">选项2</a>
				</li>
			</ul>
			<a class="close-link">
				<i class="fa fa-times"></i>
			</a>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="xmuProject" action="${ctx}/xmu/proj/xmuProject/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>项目名称：</span>
				<form:input path="xmpName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="xmu:proj:xmuProject:add">
				<table:addRow url="${ctx}/xmu/proj/xmuProject/form" title="项目" height="600px"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProject:edit">
			    <table:editRow url="${ctx}/xmu/proj/xmuProject/form" title="项目" id="contentTable" height="600px"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProject:del">
				<table:delRow url="${ctx}/xmu/proj/xmuProject/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProject:import">
				<table:importExcel url="${ctx}/xmu/proj/xmuProject/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProject:export">
	       		<table:exportExcel url="${ctx}/xmu/proj/xmuProject/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
			</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column xmp_name">项目名称</th>
				<th  class="sort-column xmp_level">项目级别</th>
				<th  class="sort-column XMP_MAINT_DATE">项目开始时间</th>
				<th  class="sort-column XMP_END_DATE">项目结束时间</th>
				<th  class="sort-column xmp_status">项目状态</th>
				<th  class="sort-column a.CREATE_DATE">创建时间</th>
				<th  class="sort-column a.create_by">创建者</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuProject">
			<tr>
				<td> <input type="checkbox" id="${xmuProject.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看项目', '${ctx}/xmu/proj/xmuProject/form?id=${xmuProject.id}','800px', '600px')">
					${xmuProject.xmpName}
				</a></td>
				<td>
					${fns:getDictLabel(xmuProject.xmpLevel, 'XMU_PROJECT_LEVEL', '')}
				</td>
				<td>
					<fmt:formatDate value="${xmuProject.xmpMaintDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${xmuProject.xmpEndDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(xmuProject.xmpStatus, 'XMU_PROJECT_STATUS', '')}
				</td>
				<td>
					<fmt:formatDate value="${xmuProject.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${xmuProject.createBy.name}
				</td>
				<td>
					<shiro:hasPermission name="xmu:proj:xmuProject:view">
						<a href="#" onclick="openDialogView('查看项目', '${ctx}/xmu/proj/xmuProject/form?id=${xmuProject.id}','800px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xmu:proj:xmuProject:edit">
    					<a href="#" onclick="openDialog('修改项目', '${ctx}/xmu/proj/xmuProject/form?id=${xmuProject.id}','800px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xmu:proj:xmuProject:del">
						<a href="${ctx}/xmu/proj/xmuProject/delete?id=${xmuProject.id}" onclick="return confirmx('确认要删除该项目吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>