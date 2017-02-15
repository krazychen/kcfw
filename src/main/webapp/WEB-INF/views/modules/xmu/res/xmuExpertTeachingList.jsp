<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专家授课管理</title>
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
		<h5>专家授课列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuExpertTeaching" action="${ctx}/xmu/res/xmuExpertTeaching/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>项目名称：</span>
					<form:input style="width:210px" path="xetProjName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>学院：</span>
					<sys:treeselect  id="xetExpretOfficeId" name="xetExpretOfficeId" value="${xmuExpertTeaching.xetExpretOfficeId}" labelName="xetExpretOffice" labelValue="${xmuExpertTeaching.xetExpretOffice}"
						title="部门" url="/sys/office/treeData?type=2" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>专业：</span>
					<form:select style="width:210px" path="xetExpertProfession"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_COR_PROFESSION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名：</span>
					<form:input style="width:210px" path="xetExpertName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">		
					<span>头衔：</span>
					<form:select style="width:210px" path="xetExpertTitle"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_STU_TEA_TITLE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="xmu:res:xmuExpertTeaching:add">
				<table:addRow url="${ctx}/xmu/res/xmuExpertTeaching/form" title="专家授课"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:res:xmuExpertTeaching:edit">
			    <table:editRow url="${ctx}/xmu/res/xmuExpertTeaching/form" title="专家授课" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:res:xmuExpertTeaching:del">
				<table:delRow url="${ctx}/xmu/res/xmuExpertTeaching/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:res:xmuExpertTeaching:import">
				<table:importExcel url="${ctx}/xmu/res/xmuExpertTeaching/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:res:xmuExpertTeaching:export">
	       		<table:exportExcel url="${ctx}/xmu/res/xmuExpertTeaching/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column xet_proj_name">项目名称</th>
				<th  class="sort-column xet_expret_office">学院</th>
				<th  class="sort-column xet_expert_profession">专业</th>
				<th  class="sort-column xet_expert_grade">学年学期</th>
				<th  class="sort-column xet_expert_name">姓名</th>
				<th  class="sort-column xet_expert_course_name">课程名称</th>
				<th  class="sort-column xet_expert_hours">学时</th>
				<th  class="sort-column xet_expert_area">地区</th>
				<th  class="sort-column xet_expert_unit">单位</th>
				<th  class="sort-column xet_expert_job_title">职称</th>
				<th  class="sort-column xet_expert_title">头衔</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuExpertTeaching">
			<tr>
				<td> <input type="checkbox" id="${xmuExpertTeaching.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看专家授课', '${ctx}/xmu/res/xmuExpertTeaching/form?id=${xmuExpertTeaching.id}','800px', '500px')">
					${xmuExpertTeaching.xetProjName}
				</a></td>
				<td>
					${xmuExpertTeaching.xetExpretOffice}
				</td>
				<td>
					${fns:getDictLabel(xmuExpertTeaching.xetExpertProfession, 'XMU_PROJECT_COR_PROFESSION', '')}
				</td>
				<td>
					${fns:getDictLabel(xmuExpertTeaching.xetExpertGrade, 'XMU_PROJECT_COR_GRADE', '')}
				</td>
				<td>
					${xmuExpertTeaching.xetExpertName}
				</td>
				<td>
					${xmuExpertTeaching.xetExpertCourseName}
				</td>
				<td>
					${xmuExpertTeaching.xetExpertHours}
				</td>
				<td>
					${xmuExpertTeaching.xetExpertArea}
				</td>
				<td>
					${xmuExpertTeaching.xetExpertUnit}
				</td>
				<td>
					${fns:getDictLabel(xmuExpertTeaching.xetExpertJobTitle, 'XMU_PROJECT_STU_TEA_JOBTITLE', '')}
				</td>
				<td>
					${fns:getDictLabel(xmuExpertTeaching.xetExpertTitle, 'XMU_PROJECT_STU_TEA_TITLE', '')}
				</td>
				<td>
					<shiro:hasPermission name="xmu:res:xmuExpertTeaching:view">
						<a href="#" onclick="openDialogView('查看专家授课', '${ctx}/xmu/res/xmuExpertTeaching/form?id=${xmuExpertTeaching.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xmu:res:xmuExpertTeaching:edit">
    					<a href="#" onclick="openDialog('修改专家授课', '${ctx}/xmu/res/xmuExpertTeaching/form?id=${xmuExpertTeaching.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xmu:res:xmuExpertTeaching:del">
						<a href="${ctx}/xmu/res/xmuExpertTeaching/delete?id=${xmuExpertTeaching.id}" onclick="return confirmx('确认要删除该专家授课吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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