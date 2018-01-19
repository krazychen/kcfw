<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目汇报管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
		
		function openFileUpload(){
			top.layer.open({
			    type: 2,  
			    area: ['250', '350'],
			    title:"上传下载模版",
			    btn: ['确定', '关闭'],
			    content: "${ctx}/xmu/rep/xmuReportMnt/gotoUploadTemplate" ,
			    yes: function(index, layero){
			    	 var body = top.layer.getChildFrame('body', index);			    
			         var inputForm = body.find('#inputForm');
			    	 inputForm.submit();
			    	 
			    	 setTimeout(function(){alert("保存模版成功！");top.layer.close(index)}, 100);//延时0.1秒，对应360 7.1版本bug
				  },
				  cancel: function(index){ 
	    	       }
			}); 
		}
		
		function deleteAllList(){

			// var url = $(this).attr('data-url');
			  var str="";
			  var ids="";
			  var status="1";
			  $("#contentTable tbody tr td input.i-checks:checkbox").each(function(){
			    if(true == $(this).is(':checked')){
			      str+=$(this).attr("id")+",";
			      status = $(this).attr("status");
			      if(status!="1"){
			    	  return;
			      }
			    }
			  });
			  if(status!="1"){
		    	  top.layer.alert('只能选择待创建的数据进行删除!', {icon: 0, title:'警告'});
		    	  return;
		      }

			  if(str.substr(str.length-1)== ','){
			    ids = str.substr(0,str.length-1);
			  }
			  if(ids == ""){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return;
			  }
				top.layer.confirm('确认要彻底删除数据吗?', {icon: 3, title:'系统提示'}, function(index){
				window.location = "${ctx}/xmu/rep/xmuReportMnt/deleteAll?ids="+ids;
			    top.layer.close(index);
			});
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>项目汇报列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuReportMnt" action="${ctx}/xmu/rep/xmuReportMnt/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>年份：</span>
					<form:input path="xrmMonths" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>学院：</span>
					<sys:treeselect id="xrmOfficeId" name="xrmOfficeId" value="${xmuReportMnt.xrmOfficeId}" labelName="xrmOfficeName" labelValue="${xmuReportMnt.xrmOfficeName}"
						title="部门" url="/sys/office/treeData?type=2" isAll="true"  cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>项目名称：</span>
					<sys:gridselect url="${ctx}/xmu/rep/xmuReportMnt/selectProject" id="xrmProjId" name="xrmProjId"  value="${xmuReportMnt.xrmProjId}"  title="选择项目" labelName="xrmProjName" 
					labelValue="${xmuReportMnt.xrmProjName}" cssClass="form-control required" fieldLabels="项目名称|项目开始时间|项目结束时间|项目简介" fieldKeys="xmpName|xmpMaintDate|xmpEndDate|xmpDescp" searchLabel="项目名称" searchKey="xmpName" ></sys:gridselect>
					<!-- 
					<form:input path="xrmProjName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/> -->
				</div>
			</div>
		</div>
	</form:form>
	<c:if test="${fn:contains(role, 'dept')}" >
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<button class="btn btn-sm " data-toggle="tooltip" data-placement="left" onclick="openFileUpload()" title="上传下载模版">上传下载模版</button>
				</div>
			</div>
		 </div>	
	</c:if>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<c:if test="${fn:contains(role, 'Manager')}" >
				<shiro:hasPermission name="xmu:rep:xmuReportMnt:add">
					<table:addRow url="${ctx}/xmu/rep/xmuReportMnt/form" title="项目汇报"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:rep:xmuReportMnt:edit">
				    <table:editRow url="${ctx}/xmu/rep/xmuReportMnt/form" title="项目汇报" id="contentTable"></table:editRow><!-- 编辑按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:rep:xmuReportMnt:submit">
			   		<table:submitRow url="${ctx}/xmu/rep/xmuReportMnt/form" title="项目汇报" id="contentTable"></table:submitRow><!-- 提交按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:rep:xmuReportMnt:back">
				    <table:backRow url="${ctx}/xmu/rep/xmuReportMnt/form" status="2" targetAction="${ctx}/xmu/rep/xmuReportMnt/back" title="项目汇报" id="contentTable"></table:backRow><!-- 撤回按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:rep:xmuReportMnt:del">
					<button class="btn btn-white btn-sm" onclick="deleteAllList()" data-toggle="tooltip" data-placement="top"><i class="fa fa-trash-o"> ${label==null?'删除':label}</i>
	                        </button><!-- 删除按钮 -->
				</shiro:hasPermission>
			</c:if>
			<c:if test="${!fn:contains(role, 'Manager')}" >
				<shiro:hasPermission name="xmu:rep:xmuReportMnt:audit">
				    <table:auditRow url="${ctx}/xmu/rep/xmuReportMnt/form" targetAction="${ctx}/xmu/rep/xmuReportMnt/saveAudit" title="项目汇报" id="contentTable"></table:auditRow><!-- 审核按钮 -->
				</shiro:hasPermission>
				
			</c:if>
			<!-- 
			<shiro:hasPermission name="xmu:rep:xmuReportMnt:import">
				<table:importExcel url="${ctx}/xmu/rep/xmuReportMnt/import"></table:importExcel>导入按钮 
			</shiro:hasPermission>-->
			
			<shiro:hasPermission name="xmu:rep:xmuReportMnt:export">
	       		<table:exportExcel url="${ctx}/xmu/rep/xmuReportMnt/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column xrm_months">年份</th>
				<th  class="sort-column ">学院</th>
				<th  class="sort-column xrm_proj_id">项目名称</th>
				<th  class="sort-column xrm_files">附件名称</th>
				<th  class="sort-column xrm_status">审核状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuReportMnt">
			<tr>
				<td> <input type="checkbox" id="${xmuReportMnt.id}" status="${xmuReportMnt.xrmStatus}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看项目汇报', '${ctx}/xmu/rep/xmuReportMnt/form?id=${xmuReportMnt.id}&urlType=view','800px', '500px')">
					${xmuReportMnt.xrmMonths}
				</a></td>
				<td>
					${xmuReportMnt.xrmOfficeName}
				</td>
				<td>
					${xmuReportMnt.xrmProjName}
				</td>
				<td>
					<input id="xrmFiles" value="${xmuReportMnt.xrmFiles}" type="hidden" />
					<sys:ckfinder input="xrmFiles" readonly="true" type="files" uploadPath="/xmu/rep/xmuReportMnt" selectMultiple="true"/>
				</td>
				<td>
					${fns:getDictLabel(xmuReportMnt.xrmStatus, 'XMU_EVENT_STATUS', '')}
				</td>
				<td>
					<shiro:hasPermission name="xmu:rep:xmuReportMnt:view">
						<a href="#" onclick="openDialogView('查看项目汇报', '${ctx}/xmu/rep/xmuReportMnt/form?id=${xmuReportMnt.id}&urlType=view','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xmu:rep:xmuReportMnt:edit">
    					<a href="#" onclick="openDialog('修改项目汇报', '${ctx}/xmu/rep/xmuReportMnt/form?id=${xmuReportMnt.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xmu:rep:xmuReportMnt:del">
						<a href="${ctx}/xmu/rep/xmuReportMnt/delete?id=${xmuReportMnt.id}" onclick="return confirmx('确认要删除该项目汇报吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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