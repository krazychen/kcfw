<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成方案管理</title>
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
				<h5>方案列表 </h5>
				<div class="ibox-tools">
					<a class="collapse-link">
						<i class="fa fa-chevron-up"></i>
					</a>
					<a class="dropdown-toggle" data-toggle="dropdown" href="form_basic.html#">
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
				<!-- 查询条件 -->
				<div class="row">
					<div class="col-sm-12">
						<form:form id="searchForm" modelAttribute="genScheme" action="${ctx}/gen/genScheme/" method="post" class="form-inline">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
							<div class="form-group">
								<span>方案名称 ：</span>
								<form:input path="name" htmlEscape="false" maxlength="50" class="form-control"/>
			 				</div>	
						</form:form>
						<br/>
					</div>
				</div>

				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							<shiro:hasPermission name="gen:genScheme:edit">
								<table:cusRow url="${ctx}/gen/genScheme/form" title="添加方案" label="添加"></table:cusRow><!-- 增加按钮 -->
							</shiro:hasPermission>
							<shiro:hasPermission name="gen:genScheme:edit">
			    				<table:editRow url="${ctx}/gen/genScheme/form" id="contentTable"  title="方案"></table:editRow><!-- 编辑按钮 -->
							</shiro:hasPermission>
							<shiro:hasPermission name="gen:genScheme:edit">
								<table:delRow url="${ctx}/gen/genScheme/delete" id="contentTable"></table:delRow><!-- 删除按钮 -->
							</shiro:hasPermission>
	       					<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
						</div>
						<div class="pull-right">
							<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
							<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
						</div>
					</div>
				</div>

				<table id="contentTable" class="table table-striped table-bordered  table-hover table-condensed  dataTables-example dataTable no-footer">
					<thead>
						<tr>
							<th> <input type="checkbox" class="i-checks"></th>
							<th class="sort-column name">方案名称</th>
							<th class="sort-column package_name">生成模块</th>
							<th class="sort-column module_name">模块名</th>
							<th class="sort-column function_name">功能名</th>
							<th class="sort-column function_author">功能作者</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.list}" var="genScheme">
							<tr>
								<td> <input type="checkbox" id="${genScheme.id}" class="i-checks"></td>
								<td><a href="#" onclick="openDialogView('查看方案','${ctx}/gen/genScheme/form?id=${genScheme.id}','800px', '500px')">${genScheme.name}</a></td>
								<td>${genScheme.packageName}</td>
								<td>${genScheme.moduleName}${not empty genScheme.subModuleName?'.':''}${genScheme.subModuleName}</td>
								<td>${genScheme.functionName}</td>
								<td>${genScheme.functionAuthor}</td>
								<td>
									<shiro:hasPermission name="gen:genScheme:edit">
										<a href="#" onclick="openDialogView('查看方案', '${ctx}/gen/genScheme/form?id=${genScheme.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
									</shiro:hasPermission>
									<shiro:hasPermission name="gen:genScheme:edit">
				    					<a href="#" onclick="openDialogCus('修改方案', '${ctx}/gen/genScheme/form?id=${genScheme.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
				    				</shiro:hasPermission>
				    				<shiro:hasPermission name="gen:genScheme:edit">
										<a href="${ctx}/gen/genScheme/delete?id=${genScheme.id}" onclick="return confirmx('确认要删除该方案吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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
