<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学年教学管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#contentTable thead tr th input.i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
		    	  $('#contentTable tbody tr td input.i-checks').iCheck('check');
		    	});

		    $('#contentTable thead tr th input.i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
		    	  $('#contentTable tbody tr td input.i-checks').iCheck('uncheck');
		    	});
		});
		
		function addRelatedProject(){
			var size = $("#contentTable tbody tr td input.i-checks:checked").size();
			if(size == 0 ){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return "-1";
			}
			var ids =[] ;
		    $("#contentTable tbody tr td input.i-checks:checkbox:checked").each(function () {
                ids.push(this.id);
            });
		    $("#teachingIdList").val(ids);
			top.layer.open({
			    type: 2,  
			    area: ['800px', '500px'],
			    title:"选择项目",
			    name:'friend',
			    content: "${ctx}/xmu/proj/xmuProjectCource/selectProject?fieldLabels=项目名称|项目开始时间|项目结束时间|项目简介&fieldKeys=xmpName|xmpMaintDate|xmpEndDate|xmpDescp&url=${ctx}/xmu/proj/xmuProjectCource/selectProject&searchLabel=项目名称&searchKey=xmpName" ,
			    btn: ['确定', '关闭'],
			    yes: function(index, layero){
			    	 var iframeWin = layero.find('iframe')[0].contentWindow; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			    	 var item = iframeWin.getSelectedItem();

			    	 if(item == "-1"){
				    	 return;
			    	 }
			    	 $("#xptProjId").val(item.split('_item_')[0]);
			    	 $("#xptProjName").val(item.split('_item_')[1]);
			    	 $("#saveForm").submit();
			    	 top.layer.close(index);//关闭对话框。
				  },
				  cancel: function(index){ 
			       }
			}); 
		}

	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="saveForm" modelAttribute="xmuProjectTeaching" action="${ctx}/xmu/proj/xmuProjectTeaching/saveTeaching" method="post">
		<input id="teachingIdList" name="teachingIdList" type="hidden" />
		<input id="xptProjId" name="xptProjId" type="hidden" />
		<input id="xptProjName" name="xptProjName" type="hidden" />
	</form:form>
	<form:form id="searchForm" modelAttribute="xmuProjectTeaching" action="${ctx}/xmu/proj/xmuProjectTeaching/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>课程名称：</span>
					<form:input style="width:210px" path="xptTeachingName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
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
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="addRelatedProject()" title="选择课程所属项目"><i class="fa fa-plus"></i>选择所属项目</button>	
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
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuProjectTeaching">
			<tr>
				<td> <input type="checkbox" id="${xmuProjectTeaching.id}" class="i-checks"></td>
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