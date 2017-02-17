<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学年教学管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
		
		function addTeaching(){
			top.layer.open({
			    type: 2,  
			    area: ['1000px', '550px'],
			    title:"教学课程信息",
			    name:'friend',
			    content: "${ctx}/xmu/proj/xmuProjectTeaching/listTeaching" ,
			    btn: ['关闭'],
				  btn1: function(index){ 
					  top.layer.close(index);
					  sortOrRefresh();
			      },
			      end:function(index){ 
					  top.layer.close(index);
					  sortOrRefresh();
			      }
			});
		}
		
		function editTeaching(){
			var size = $("#contentTable tbody tr td input.i-checks:checked").size();
			if(size == 0 ){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return "-1";
			}
			var ids =[] ;
		    $("#contentTable tbody tr td input.i-checks:checkbox:checked").each(function () {
                ids.push(this.id);
            });
			openDialog('修改教学课程', '${ctx}/xmu/proj/xmuProjectTeaching/formList?xptTeachingIds='+ids,'1050px', '500px');
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>学年教学列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuProjectTeaching" action="${ctx}/xmu/proj/xmuProjectTeaching/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>项目名称：</span>
					<form:input style="width:210px" path="xptProjName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>项目级别：</span>
					<form:select style="width:210px" path="xptProjLevel"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>课程名称：</span>
					<form:input style="width:210px" path="xptTeachingName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
		</div>
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>授课语言：</span>
					<form:select style="width:210px" path="xptTeachingLang"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_COR_LANG')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学院：</span>
					<form:input style="width:210px" path="xptTeachingOffice" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">	
					<span>学年学期：</span>
					<form:input style="width:210px" path="xptTeachingGrade" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
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
			<shiro:hasPermission name="xmu:proj:xmuProjectTeaching:add">
				<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="addTeaching()" title="学年教学维护添加"><i class="fa fa-plus"></i> 新增</button><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectTeaching:edit">
			    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="editTeaching()" title="学年教学维护修改"><i class="fa fa-file-text-o"></i> 修改</button><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectTeaching:del">
				<table:delRow url="${ctx}/xmu/proj/xmuProjectTeaching/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectTeaching:import">
				<table:importExcel url="${ctx}/xmu/proj/xmuProjectTeaching/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectTeaching:export">
	       		<table:exportExcel url="${ctx}/xmu/proj/xmuProjectTeaching/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column xpt_proj_name">项目名称</th>
				<th  class="sort-column xpt_teaching_name">课程名称</th>
				<th  class="sort-column xpt_teaching_lang">授课语言</th>
				<th  class="sort-column xpt_teaching_office">学院</th>
				<th  class="sort-column xpt_teaching_grade">学年学期</th>
				<th  class="sort-column xpt_teaching_profeesion">专业</th>
				<th  class="sort-column xpt_teaching_hours">总学时</th>
				<th  class="sort-column xpt_teaching_stu">上课人数</th>
				<th  class="sort-column xpt_teaching_teacher">主讲老师</th>
				<th  class="sort-column xpt_teaching_jobtitle">职称</th>
				<th  class="sort-column xpt_teaching_title">头衔</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuProjectTeaching">
			<tr>
				<td> <input type="checkbox" id="${xmuProjectTeaching.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看学年教学', '${ctx}/xmu/proj/xmuProjectTeaching/form?id=${xmuProjectTeaching.id}','800px', '500px')">
					${xmuProjectTeaching.xptProjName}
				</a></td>
				<td>
					${xmuProjectTeaching.xptTeachingName}
				</td>
				<td>
					${fns:getDictLabel(xmuProjectTeaching.xptTeachingLang, 'XMU_PROJECT_COR_LANG', '')}
				</td>
				<td>
					${xmuProjectTeaching.xptTeachingOffice}
				</td>
				<td>
					${xmuProjectTeaching.xptTeachingGrade}
				</td>
				<td>
					${xmuProjectTeaching.xptTeachingProfeesion}
				</td>
				<td>
					${xmuProjectTeaching.xptTeachingHours}
				</td>
				<td>
					${xmuProjectTeaching.xptTeachingStu}
				</td>
				<td>
					${xmuProjectTeaching.xptTeachingTeacher}
				</td>
				<td>
					${fns:getDictLabel(xmuProjectTeaching.xptTeachingJobtitle, 'XMU_PROJECT_STU_TEA_JOBTITLE', '')}
				</td>
				<td>
					${fns:getDictLabel(xmuProjectTeaching.xptTeachingTitle, 'XMU_PROJECT_STU_TEA_TITLE', '')}
				</td>
				<td>
					<shiro:hasPermission name="xmu:proj:xmuProjectTeaching:edit">
    					<a href="#" onclick="openDialog('修改学年教学', '${ctx}/xmu/proj/xmuProjectTeaching/formList?xptTeachingIds=${xmuProjectTeaching.id}','1050px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xmu:proj:xmuProjectTeaching:del">
						<a href="${ctx}/xmu/proj/xmuProjectTeaching/delete?id=${xmuProjectTeaching.id}" onclick="return confirmx('确认要删除该学年教学吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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