<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
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

		function getSelectedItem(){

			var size = $("#contentTable tbody tr td input.i-checks:checked").size();
			if(size == 0 ){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return "-1";
			}
		    var ids =[] ;
		    $("#contentTable tbody tr td input.i-checks:checkbox:checked").each(function () {
                alert(this.id);
            });
		    alert(ids);
			//var labels = $("#contentTable tbody tr td input.i-checks:checkbox:checked").parent().parent().parent().find(".codelabel").html();
			return ids;
		}
	</script>
</head>
<body class="gray-bg">
	<div class="">
    <div class="ibox-content">
		<!-- 查询条件 -->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="xmuProjectStudent" action="${ctx}/xmu/proj/xmuProjectStudent/listStu" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
				<div class="form-group">
					<span>姓名：</span>
					<form:input path="xpsUserName" htmlEscape="false" maxlength="2000"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
				<div class="form-group">
					<span>年级：</span>
					<form:input path="xpuUserGrade" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
				<div class="form-group">
					<span>专业：</span>
					<form:input path="xpuUserProfession" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
				<div class="form-group">
					<span>学号：</span>
					<form:input path="xpuUserStuno" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
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
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th><input type="checkbox" class="i-checks"></th>
				<th  class="sort-column ">学院</th>
				<th  class="sort-column u.name">姓名</th>
				<th  class="sort-column x.xsi_user_grade">年级</th>
				<th  class="sort-column x.xsi_user_profession">专业</th>
				<th  class="sort-column x.xsi_user_stuno">学号</th>
				<th  class="sort-column x.xsi_user_lincno">证件号</th>
				<th  class="sort-column x.xsi_user_midsch">毕业中学</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuProjectStudent">
			<tr>
				<td> <input type="checkbox" id="${xmuProjectStudent.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看项目人员', '${ctx}/xmu/proj/xmuProjectStudent/form?id=${xmuProjectStudent.id}','800px', '500px')">
					${xmuProjectStudent.xpsOfficeName}
				</a></td>
				<td>
					${xmuProjectStudent.xpsUserName}
				</td>
				<td>
					${xmuProjectStudent.xpuUserGrade}
				</td>
				<td>
					${xmuProjectStudent.xpuUserProfession}
				</td>
				<td>
					${xmuProjectStudent.xpuUserStuno}
				</td>
				<td>
					${xmuProjectStudent.xpuUserLincno}
				</td>
				<td>
					${xmuProjectStudent.xpuUserMidsch}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
</div>
</body>
</html>