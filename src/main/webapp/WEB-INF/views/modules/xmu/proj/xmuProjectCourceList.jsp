<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目课程管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
		
		function addCourse(){
			top.layer.open({
			    type: 2,  
			    area: ['1000px', '550px'],
			    title:"选择课程",
			    name:'friend',
			    content: "${ctx}/xmu/proj/xmuProjectCource/listCourse" ,
			    btn: ['关闭'],
			    /**yes: function(index, layero){
			    	 var iframeWin = layero.find('iframe')[0].contentWindow; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			    	 var items = iframeWin.getSelectedItem();
					 if(items=="-1"){
						 return false;
					 }else{
						 top.layer.close(index);//关闭对话框。
					 }
				  },**/
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
		
		function editCourse(){
			var size = $("#contentTable tbody tr td input.i-checks:checked").size();
			if(size == 0 ){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return "-1";
			}
			var ids =[] ;
		    $("#contentTable tbody tr td input.i-checks:checkbox:checked").each(function () {
                ids.push(this.id);
            });
			openDialog('修改项目课程', '${ctx}/xmu/proj/xmuProjectCource/formList?xciCourseIds='+ids,'1050px', '500px');
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>项目课程列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuProjectCource" action="${ctx}/xmu/proj/xmuProjectCource/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>学院名称：</span>
					<sys:treeselect id="xpcOfficeId" name="xpcOfficeId" value="${xmuProjectCource.xpcOfficeId}" labelName="xpcOfficeName" labelValue="${xmuProjectCource.xpcOfficeName}"
						title="部门" url="/sys/office/treeData?type=2" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>项目名称：</span>
					<form:input style="width:210px" path="xpcProjName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>课程类型：</span>
					<form:select path="xpcCourseType"  style="width:210px" class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_COR_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>开课年级：</span>
					<form:input style="width:210px" path="xciCourseGrade" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>开课学期：</span>
					<form:select style="width:210px" path="xciCourseSemester"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_COR_SEMESTER')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>授课语言：</span>
					<form:select style="width:210px" path="xpcCourseLang"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_COR_LANG')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
			<shiro:hasPermission name="xmu:proj:xmuProjectCource:add">
				<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="addCourse()" title="课程添加"><i class="fa fa-plus"></i>添加</button><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectCource:edit">
			    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="editCourse()" title="课程编辑"><i class="fa fa-plus"></i>编辑</button><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectCource:del">
				<table:delRow url="${ctx}/xmu/proj/xmuProjectCource/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectCource:import">
				<table:importExcel url="${ctx}/xmu/proj/xmuProjectCource/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectCource:export">
	       		<table:exportExcel url="${ctx}/xmu/proj/xmuProjectCource/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column ">学院名称</th>
				<th  class="sort-column xpc_proj_name">项目名称</th>
				<th  class="sort-column xpc_course_type">课程类型</th>
				<th  class="sort-column xci_course_grade">开课年级</th>
				<th  class="sort-column xci_course_semester">开课学期</th>
				<th  class="sort-column xpc_course_lang">授课语言</th>
				<th  class="sort-column update_date hide">更新时间</th>
				<th  class="sort-column xpc_proj_id hide">项目ID</th>
				<th  class="sort-column xpc_course_unit">开课单位</th>
				<th  class="sort-column xpc_course_name">课程名称</th>
				<th  class="sort-column xci_course_hours">学时</th>
				<th  class="sort-column xci_course_credit">学分</th>
				<th  class="sort-column xpc_office_id hide">学院ID</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuProjectCource">
			<tr>
				<td> <input type="checkbox" id="${xmuProjectCource.id}" class="i-checks"></td>
				<td>
					${xmuProjectCource.xpcOfficeName}
				</td>
				<td>
					${xmuProjectCource.xpcProjName}
				</td>
				<td>
					${fns:getDictLabel(xmuProjectCource.xpcCourseType, 'XMU_PROJECT_COR_TYPE', '')}
				</td>
				<td>
					${xmuProjectCource.xciCourseGrade}
				</td>
				<td>
					${fns:getDictLabel(xmuProjectCource.xciCourseSemester, 'XMU_PROJECT_COR_SEMESTER', '')}
				</td>
				<td>
					${fns:getDictLabel(xmuProjectCource.xpcCourseLang, 'XMU_PROJECT_COR_LANG', '')}
				</td>
				<td class="hide">
					<fmt:formatDate value="${xmuProjectCource.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td class="hide">
					${xmuProjectCource.xpcProjId}
				</td>
				<td>
					${xmuProjectCource.xpcCourseUnit}
				</td>
				<td>
					${xmuProjectCource.xpcCourseName}
				</td>
				<td>
					${xmuProjectCource.xciCourseHours}
				</td>
				<td>
					${xmuProjectCource.xciCourseCredit}
				</td>
				<td class="hide">
					${xmuProjectCource.xpcOfficeId}
				</td>
				<td>
					<shiro:hasPermission name="xmu:proj:xmuProjectCource:edit">
    					<a href="#" onclick="openDialog('修改项目课程', '${ctx}/xmu/proj/xmuProjectCource/formList?xciCourseIds=${xmuProjectCource.id}','1050px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xmu:proj:xmuProjectCource:del">
						<a href="${ctx}/xmu/proj/xmuProjectCource/delete?id=${xmuProjectCource.id}" onclick="return confirmx('确认要删除该项目课程吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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