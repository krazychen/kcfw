<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目人员管理</title>
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
		
		function addStu(){
			var size = $("#contentTable tbody tr td input.i-checks:checked").size();
				if(size == 0 ){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return "-1";
			}
			
			if(size > 1 ){
				top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
				return "-1";
			}
			var id =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
			top.layer.open({
			    type: 2,  
			    area: ['800px', '550px'],
			    title:"选择项目人员",
			    name:'friend',
			    content: "${ctx}/xmu/proj/xmuProjectStudent/listStu?xpsProjId="+id ,
			    btn: ['确定', '关闭'],
			    yes: function(index, layero){
			    	 var iframeWin = layero.find('iframe')[0].contentWindow; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			    	 var items = iframeWin.getSelectedItem();
					 if(items=="-1"){
						 return false;
					 }else{
						 top.layer.close(index);//关闭对话框。
						 top.layer.open({
							    type: 2,  
							    area: ['1050px', '550px'],
							    title:"项目人员维护",
							    name:'friend',
							    content: "${ctx}/xmu/proj/xmuProjectStudent/formList?xpsUserIds="+items+"&id="+id,
							    btn: ['确定', '关闭'],
							    yes: function(index, layero){
							    	 var body = top.layer.getChildFrame('body', index);
							         var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
						         	if(iframeWin.contentWindow.doSubmit() ){
						         		// top.layer.close(index);//关闭对话框。
						         		setTimeout(function(){top.layer.close(index)}, 100);//延时0.1秒，对应360 7.1版本bug
						         	} 
								  },
								  cancel: function(index){ 
							       }
							});
					 }
					 
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
	<div class="ibox-title">
		<h5>项目人员列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuProject" action="${ctx}/xmu/proj/xmuProjectStudent/listPro" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>项目名称：</span>
			<form:input style="width:210px" path="xmpName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
			<span>项目级别：</span>
			<form:select style="width:210px" path="xmpLevel" class="form-control m-b">
				<form:option value="" label=""/>
				<form:options items="${fns:getDictList('XMU_PROJECT_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="xmu:proj:xmuProjectStudent:add">
				<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="addStu()" title="人员添加"><i class="fa fa-plus"></i> 人员添加</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="xmu:proj:xmuProjectStudent:edit">
				<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="openDialog('修改项目人员', '${ctx}/xmu/proj/xmuProjectStudent/formList?id=${xmuProject.id}','1050px', '550px')" title="人员修改"><i class="fa fa-file-text-o"></i> 修改</button>
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
				<th  class="sort-column xmp_descp">项目简介</th>
				<th  class="sort-column create_date">项目成立时间</th>
				<th  class="sort-column xmp_maintDate">维护开放时间</th>
				<th  class="sort-column xmp_endDate">维护关闭时间</th>
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
					${xmuProject.xmpDescp}
				</td>
				<td>
					<fmt:formatDate value="${xmuProject.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${xmuProject.xmpMaintDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${xmuProject.xmpEndDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<shiro:hasPermission name="xmu:proj:xmuProjectStudent:view">
						<a href="#" onclick="openDialogView('查看项目人员', '${ctx}/xmu/proj/xmuProjectStudent/formList?id=${xmuProject.id}','1050px', '550px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xmu:proj:xmuProjectStudent:edit">
    					<a href="#" onclick="openDialog('修改项目人员', '${ctx}/xmu/proj/xmuProjectStudent/formList?id=${xmuProject.id}','1050px', '550px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i>人员维护</a>
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