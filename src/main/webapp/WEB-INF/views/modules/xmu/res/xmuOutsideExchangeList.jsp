<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>校外交流管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			laydate({
	            elem: '#xoeExchangeYears', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	            format: 'YYYY' //日期格式
	        });
		});
		
		function deleteAllList(){
			if("${stu}"=="true"){
				top.layer.alert('项目已经关闭!', {icon: 0, title:'警告'});
				return;
			}
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
		
		function openModify(status,id){
			if(status!='1'){
				top.layer.alert('只能选择未审核的订单!', {icon: 0, title:'警告'});
			}else{
				openDialog('修改校外交流', '${ctx}/xmu/res/xmuOutsideExchange/form?id='+id,'800px', '500px')
			}
		}

	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>校外交流列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuOutsideExchange" action="${ctx}/xmu/res/xmuOutsideExchange/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学院：</span>
					<sys:treeselect id="xoeOfficeId" name="xoeOfficeId" value="${xmuOutsideExchange.xoeOfficeId}" labelName="xoeOfficeName" labelValue="${xmuOutsideExchange.xoeOfficeName}"
							title="部门" url="/sys/office/treeData?type=2" isAll="true" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="false"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;专业：</span>
					<form:select style="width:210px" path="xoeUserProfession"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_COR_PROFESSION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">	
					<span>姓名：</span>
					<form:input style="width:210px" path="xoeUserName" htmlEscape="false" maxlength="2000"  class=" form-control input-sm"/>
				</div>
			</div>
		</div>
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>交流年份：</span>
					<input id="xoeExchangeYears" style="width:210px" name="xoeExchangeYears" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="${xmuOutsideExchange.xoeExchangeYears}"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>交流学校：</span>
					<form:input style="width:210px" path="xoeExchangeSchool" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
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
				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:add">
					<table:addRow url="${ctx}/xmu/res/xmuOutsideExchange/form" stu="${stu}" title="校外交流"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:edit">
				    <table:editRow url="${ctx}/xmu/res/xmuOutsideExchange/form" stu="${stu}" status="1" title="校外交流" id="contentTable"></table:editRow><!-- 编辑按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:submit">
			   		<table:submitRow url="${ctx}/xmu/res/xmuOutsideExchange/form" stu="${stu}"title="校外交流" id="contentTable"></table:submitRow><!-- 提交按钮 -->
				</shiro:hasPermission>
			</c:if>
			<c:if test="${fn:contains(role, 'Manager')}" >
				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:audit">
				    <table:auditRow url="${ctx}/xmu/res/xmuOutsideExchange/form" status="2" targetAction="${ctx}/xmu/res/xmuOutsideExchange/saveAudit" title="校外交流" id="contentTable"></table:auditRow><!-- 审核按钮 -->
				</shiro:hasPermission>
			</c:if>
			<c:if test="${fn:contains(role, 'dept')}" >
				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:audit">
				    <table:auditRow url="${ctx}/xmu/res/xmuOutsideExchange/form" status="3" targetAction="${ctx}/xmu/res/xmuOutsideExchange/saveAudit" title="校外交流" id="contentTable"></table:auditRow><!-- 审核按钮 -->
				</shiro:hasPermission>
			</c:if>
			
			<c:if test="${fn:contains(role, 'Student')}" >
				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:back">
				    <table:backRow url="${ctx}/xmu/res/xmuOutsideExchange/form" stu="${stu}" status="2" targetAction="${ctx}/xmu/res/xmuOutsideExchange/back" title="校外交流" id="contentTable"></table:backRow><!-- 撤回按钮 -->
				</shiro:hasPermission>
			</c:if>
			<c:if test="${fn:contains(role, 'Manager')}" >
				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:back">
				    <table:backRow url="${ctx}/xmu/res/xmuOutsideExchange/form" status="3" targetAction="${ctx}/xmu/res/xmuOutsideExchange/back" title="校外交流" id="contentTable"></table:backRow><!-- 撤回按钮 -->
				</shiro:hasPermission>
			</c:if>
			<c:if test="${!fn:contains(role, 'dept')}" >
				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:del">
					<button class="btn btn-white btn-sm" onclick="deleteAllList()" data-toggle="tooltip" data-placement="top"><i class="fa fa-trash-o"> ${label==null?'删除':label}</i>
	                        </button><!-- 删除按钮 -->
				</shiro:hasPermission>
			</c:if>
			<!-- 
			<shiro:hasPermission name="xmu:res:xmuOutsideExchange:import">
				<table:importExcel url="${ctx}/xmu/res/xmuOutsideExchange/import"></table:importExcel><!-- 导入按钮
			</shiro:hasPermission> -->
			<shiro:hasPermission name="xmu:res:xmuOutsideExchange:export">
	       		<table:exportExcel url="${ctx}/xmu/res/xmuOutsideExchange/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column xoe_user_stuno">学号</th>
				<th  class="sort-column xoe_user_name">姓名</th>
				<th  class="sort-column XOE_OFFICE_NAME">学院</th>
				<th  class="sort-column xoe_user_profession">专业</th>	
				<th  class="sort-column xoe_exchange_years">交流年份</th>
				<th  class="sort-column xoe_exchange_area">派往国家或地区</th>
				<th  class="sort-column xoe_exchange_school">交流学校</th>
				<th  class="sort-column xoe_exchange_time">交流时间</th>
				<th  class="sort-column xoe_exchange_type">交流类型</th>
				<th  class="sort-column xoe_exchange_way">交流渠道</th>
				<th  class="sort-column xoe_status">审核状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuOutsideExchange">
			<tr>
				<td> <input type="checkbox" id="${xmuOutsideExchange.id}" status="${xmuOutsideExchange.xoeStatus}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看校外交流', '${ctx}/xmu/res/xmuOutsideExchange/form?id=${xmuOutsideExchange.id}','800px', '500px')">
					${xmuOutsideExchange.xoeUserStuno}
				</a></td>
				<td>
					${xmuOutsideExchange.xoeUserName}
				</td>
				<td>
					${xmuOutsideExchange.xoeOfficeName}
				</td>
				<td>
					${fns:getDictLabel(xmuOutsideExchange.xoeUserProfession, 'XMU_PROJECT_COR_PROFESSION', '')}
				</td>
				<td>
					${xmuOutsideExchange.xoeExchangeYears}
				</td>
				<td>
					${xmuOutsideExchange.xoeExchangeArea}
				</td>
				<td>
					${xmuOutsideExchange.xoeExchangeSchool}
				</td>
				<td>
					<fmt:formatDate value="${xmuOutsideExchange.xoeExchangeTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(xmuOutsideExchange.xoeExchangeType, 'XMU_EXCHANGE_TYPE', '')}
				</td>
				<td>
					${fns:getDictLabel(xmuOutsideExchange.xoeExchangeWay, 'XMU_EXCHANGE_WAY', '')}
				</td>

				<td>
					${fns:getDictLabel(xmuOutsideExchange.xoeStatus, 'XMU_EVENT_STATUS', '')}
				</td>				
				<td>
					<shiro:hasPermission name="xmu:res:xmuOutsideExchange:view">
						<a href="#" onclick="openDialogView('查看校外交流', '${ctx}/xmu/res/xmuOutsideExchange/form?id=${xmuOutsideExchange.id}&urlType=view','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<c:if test="${stu ne 'true'}" >
						<shiro:hasPermission name="xmu:res:xmuOutsideExchange:edit">
	    					<a href="#" onclick='openModify("${xmuOutsideExchange.xoeStatus}","${xmuOutsideExchange.id}")' class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
	    				</shiro:hasPermission>
	    				<shiro:hasPermission name="xmu:res:xmuOutsideExchange:del">
							<a href="${ctx}/xmu/res/xmuOutsideExchange/delete?id=${xmuOutsideExchange.id}" onclick="return confirmx('确认要删除该校外交流吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
						</shiro:hasPermission>
					</c:if>
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