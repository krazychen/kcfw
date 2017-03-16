<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专家讲座管理</title>
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
		<h5>专家讲座列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuExpertLecture" action="${ctx}/xmu/res/xmuExpertLecture/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>项目名称：</span>
					<form:input style="width:210px" path="xelProjName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>学院：</span>
					<sys:treeselect id="xelExpretOfficeId" name="xelExpretOfficeId" value="${xmuExpertLecture.xelExpretOfficeId}" labelName="xelExpretOffice" labelValue="${xmuExpertLecture.xelExpretOffice}"
						title="部门" url="/sys/office/treeData?type=2" isAll="true"  cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="false"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">	
					<span>专业：</span>
					<form:select style="width:210px" path="xelExpertProfession"  class="form-control m-b">
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
					<form:input style="width:210px" path="xelExpertName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">	
					<span>头衔：</span>
					<form:select style="width:210px" path="xelExpertTitle"  class="form-control m-b">
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
			<shiro:hasPermission name="xmu:res:xmuExpertLecture:add">
				<table:addRow url="${ctx}/xmu/res/xmuExpertLecture/form" title="专家讲座"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:res:xmuExpertLecture:edit">
			    <table:editRow url="${ctx}/xmu/res/xmuExpertLecture/form" title="专家讲座" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:res:xmuExpertLecture:del">
				<table:delRow url="${ctx}/xmu/res/xmuExpertLecture/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:res:xmuExpertLecture:import">
				<table:importExcel url="${ctx}/xmu/res/xmuExpertLecture/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:res:xmuExpertLecture:export">
	       		<table:exportExcel url="${ctx}/xmu/res/xmuExpertLecture/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column xel_proj_name">项目名称</th>
				<th  class="sort-column xel_expret_office">学院</th>
				<th  class="sort-column xel_expert_profession">专业</th>
				<th  class="sort-column xel_expert_grade">学年学期</th>
				<th  class="sort-column xel_expert_name">姓名</th>
				<th  class="sort-column xel_expert_lecture_name">讲座名称</th>
				<th  class="sort-column xel_expert_area">地区</th>
				<th  class="sort-column xel_expert_job_title">职称</th>
				<th  class="sort-column xel_expert_title">头衔</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuExpertLecture">
			<tr>
				<td> <input type="checkbox" id="${xmuExpertLecture.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看专家讲座', '${ctx}/xmu/res/xmuExpertLecture/form?id=${xmuExpertLecture.id}','800px', '500px')">
					${xmuExpertLecture.xelProjName}
				</a></td>
				<td>
					${xmuExpertLecture.xelExpretOffice}
				</td>
				<td>
					${fns:getDictLabel(xmuExpertLecture.xelExpertProfession, 'XMU_PROJECT_COR_PROFESSION', '')}
				</td>
				<td>
					${fns:getDictLabel(xmuExpertLecture.xelExpertGrade, 'XMU_PROJECT_COR_GRADE', '')}
				</td>
				<td>
					${xmuExpertLecture.xelExpertName}
				</td>
				<td>
					${xmuExpertLecture.xelExpertLectureName}
				</td>
				<td>
					${xmuExpertLecture.xelExpertArea}
				</td>
				<td>
					${fns:getDictLabel(xmuExpertLecture.xelExpertJobTitle, 'XMU_PROJECT_STU_TEA_JOBTITLE', '')}
				</td>
				<td>
					${fns:getDictLabel(xmuExpertLecture.xelExpertTitle, 'XMU_PROJECT_STU_TEA_TITLE', '')}
				</td>
				<td>
					<shiro:hasPermission name="xmu:res:xmuExpertLecture:view">
						<a href="#" onclick="openDialogView('查看专家讲座', '${ctx}/xmu/res/xmuExpertLecture/form?id=${xmuExpertLecture.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xmu:res:xmuExpertLecture:edit">
    					<a href="#" onclick="openDialog('修改专家讲座', '${ctx}/xmu/res/xmuExpertLecture/form?id=${xmuExpertLecture.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xmu:res:xmuExpertLecture:del">
						<a href="${ctx}/xmu/res/xmuExpertLecture/delete?id=${xmuExpertLecture.id}" onclick="return confirmx('确认要删除该专家讲座吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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