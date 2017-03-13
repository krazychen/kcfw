<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专利信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
		
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
				window.location = "${ctx}/xmu/res/xmuAcademicEvent/deleteAll?ids="+ids;
			    top.layer.close(index);
			});
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>专利信息列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuPatentInfo" action="${ctx}/xmu/res/xmuPatentInfo/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学院：</span>
					<sys:treeselect id="xpiOfficeName" name="xpiOfficeName" value="${xmuPatentInfo.xpiOfficeName}" labelName="xpiOfficeId" labelValue="${xmuPatentInfo.xpiOfficeId}"
							title="部门" url="/sys/office/treeData?type=2" isAll="true" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;专业：</span>
					<form:select style="width:210px" path="xpiUserProfession"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_COR_PROFESSION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">	
					<span>姓名：</span>
					<form:input style="width:210px" path="xpiUserName" htmlEscape="false" maxlength="2000"  class=" form-control input-sm"/>
				</div>
			</div>
		</div>
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>专利名称：</span>
					<form:input style="width:210px" path="xpiPatentName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
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
			<c:if test="${!fn:contains(role, 'dept')}" >
				<shiro:hasPermission name="xmu:res:xmuPatentInfo:add">
					<table:addRow url="${ctx}/xmu/res/xmuPatentInfo/form" title="专利信息"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:res:xmuPatentInfo:edit">
				    <table:editRow url="${ctx}/xmu/res/xmuPatentInfo/form" title="专利信息" id="contentTable"></table:editRow><!-- 编辑按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:res:xmuPatentInfo:submit">
			   		<table:submitRow url="${ctx}/xmu/res/xmuPatentInfo/form" title="专利信息" id="contentTable"></table:submitRow><!-- 提交按钮 -->
				</shiro:hasPermission>
			</c:if>
			<shiro:hasPermission name="xmu:res:xmuPatentInfo:audit">
			    <table:auditRow url="${ctx}/xmu/res/xmuPatentInfo/form" targetAction="${ctx}/xmu/res/xmuPatentInfo/saveAudit" title="学术活动" id="contentTable"></table:auditRow><!-- 审核按钮 -->
			</shiro:hasPermission>
			<c:if test="${!fn:contains(role, 'dept')}" >
				<shiro:hasPermission name="xmu:res:xmuPatentInfo:back">
				    <table:backRow url="${ctx}/xmu/res/xmuPatentInfo/form" targetAction="${ctx}/xmu/res/xmuPatentInfo/back" title="学术活动" id="contentTable"></table:backRow><!-- 撤回按钮 -->
				</shiro:hasPermission>
			</c:if>
			<c:if test="${!fn:contains(role, 'dept')}" >
				<shiro:hasPermission name="xmu:res:xmuPatentInfo:del">
					<button class="btn btn-white btn-sm" onclick="deleteAllList()" data-toggle="tooltip" data-placement="top"><i class="fa fa-trash-o"> ${label==null?'删除':label}</i>
	                        </button><!-- 删除按钮 -->
				</shiro:hasPermission>
			</c:if>
			<!--  
			<shiro:hasPermission name="xmu:res:xmuPatentInfo:import">
				<table:importExcel url="${ctx}/xmu/res/xmuPatentInfo/import"></table:importExcel><!-- 导入按钮
			</shiro:hasPermission> -->
			<shiro:hasPermission name="xmu:res:xmuPatentInfo:export">
	       		<table:exportExcel url="${ctx}/xmu/res/xmuPatentInfo/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column xpi_user_stuno">学号</th>
				<th  class="sort-column xpi_user_name">姓名</th>
				<th  class="sort-column ">学院</th>
				<th  class="sort-column xpi_user_profession">专业</th>	
				<th  class="sort-column xpi_patent_years">年份</th>
				<th  class="sort-column xpi_patent_name">专利名称</th>
				<th  class="sort-column xpi_patent_pno">申请公开号</th>
				<th  class="sort-column xpi_patent_ptime">申请公开日</th>
				<th  class="sort-column xpi_patent_remark">备注</th>
				<th  class="sort-column xpi_status">审核状态</th>			
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuPatentInfo">
			<tr>
				<td> <input type="checkbox" id="${xmuPatentInfo.id}" status="${xmuPatentInfo.xpiStatus}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看专利信息', '${ctx}/xmu/res/xmuPatentInfo/form?id=${xmuPatentInfo.id}&urlType=view','800px', '500px')">
					${xmuPatentInfo.xpiUserStuno}
				</a></td>
				<td>
					${xmuPatentInfo.xpiUserName}
				</td>
				<td>
					${xmuPatentInfo.xpiOfficeName}
				</td>
				<td>
					${fns:getDictLabel(xmuPatentInfo.xpiUserGrade, 'XMU_PROJECT_COR_GRADE', '')}
				</td>
				<td>
					<fmt:formatDate value="${xmuPatentInfo.xpiPatentYears}" pattern="yyyy"/>
				</td>
				<td>
					${xmuPatentInfo.xpiPatentName}
				</td>
				<td>
					${xmuPatentInfo.xpiPatentPno}
				</td>
				<td>
					<fmt:formatDate value="${xmuPatentInfo.xpiPatentPtime}" pattern="yyyy-MM-dd"/>
				</td>				
				<td>
					${xmuPatentInfo.xpiPatentRemark}
				</td>
				<td>
					${fns:getDictLabel(xmuPatentInfo.xpiStatus, 'XMU_EVENT_STATUS', '')}
				</td>	
				<td>
					<shiro:hasPermission name="xmu:res:xmuPatentInfo:view">
						<a href="#" onclick="openDialogView('查看专利信息', '${ctx}/xmu/res/xmuPatentInfo/form?id=${xmuPatentInfo.id}&urlType=view','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xmu:res:xmuPatentInfo:edit">
    					<a href="#" onclick="openDialog('修改专利信息', '${ctx}/xmu/res/xmuPatentInfo/form?id=${xmuPatentInfo.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xmu:res:xmuPatentInfo:del">
						<a href="${ctx}/xmu/res/xmuPatentInfo/delete?id=${xmuPatentInfo.id}" onclick="return confirmx('确认要删除该专利信息吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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