<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>论文发表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			laydate({
	            elem: '#xppPageTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
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
		<h5>论文发表列表 </h5>
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
	<form:form id="searchForm" modelAttribute="xmuPagePub" action="${ctx}/xmu/res/xmuPagePub/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学院：</span>
					<sys:treeselect id="xppOfficeName" name="xppOfficeName" value="${xmuPagePub.xppOfficeName}" labelName="xppOfficeId" labelValue="${xmuPagePub.xppOfficeId}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;专业：</span>
					<form:select style="width:210px" path="xppUserProfession"  class="form-control m-b">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('XMU_PROJECT_COR_PROFESSION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">	
					<span>姓名：</span>
					<form:input style="width:210px" path="xppUserName" htmlEscape="false" maxlength="2000"  class=" form-control input-sm"/>
				</div>
			</div>
		</div>
		<div class="row" style="margin-bottom:7px">
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>论文题目：</span>
					<form:input style="width:210px" path="xppPageName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
				<div class="form-group">
					<span>发表时间：</span>
					<input style="width:210px" id="xppPageTime" name="xppPageTime" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
						value="<fmt:formatDate value="${xmuPagePub.xppPageTime}" pattern="yyyy"/>"/>
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
				<shiro:hasPermission name="xmu:res:xmuPagePub:add">
					<table:addRow url="${ctx}/xmu/res/xmuPagePub/form" title="论文发表"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:res:xmuPagePub:edit">
				    <table:editRow url="${ctx}/xmu/res/xmuPagePub/form" title="论文发表" id="contentTable"></table:editRow><!-- 编辑按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="xmu:res:xmuPagePub:submit">
			   		<table:submitRow url="${ctx}/xmu/res/xmuPagePub/form" title="论文发表" id="contentTable"></table:submitRow><!-- 提交按钮 -->
				</shiro:hasPermission>
			</c:if>
			<shiro:hasPermission name="xmu:res:xmuPagePub:audit">
			    <table:auditRow url="${ctx}/xmu/res/xmuPagePub/form" targetAction="${ctx}/xmu/res/xmuPagePub/saveAudit" title="学术活动" id="contentTable"></table:auditRow><!-- 审核按钮 -->
			</shiro:hasPermission>
			<c:if test="${!fn:contains(role, 'dept')}" >
				<shiro:hasPermission name="xmu:res:xmuPagePub:back">
				    <table:backRow url="${ctx}/xmu/res/xmuPagePub/form" targetAction="${ctx}/xmu/res/xmuPagePub/back" title="学术活动" id="contentTable"></table:backRow><!-- 撤回按钮 -->
				</shiro:hasPermission>
			</c:if>
			<c:if test="${!fn:contains(role, 'dept')}" >
				<shiro:hasPermission name="xmu:res:xmuPagePub:del">
					<button class="btn btn-white btn-sm" onclick="deleteAllList()" data-toggle="tooltip" data-placement="top"><i class="fa fa-trash-o"> ${label==null?'删除':label}</i>
	                        </button><!-- 删除按钮 -->
				</shiro:hasPermission>
			</c:if>
			<!--  
			<shiro:hasPermission name="xmu:res:xmuPagePub:import">
				<table:importExcel url="${ctx}/xmu/res/xmuPagePub/import"></table:importExcel><!-- 导入按钮 
			</shiro:hasPermission>-->
			
			<shiro:hasPermission name="xmu:res:xmuPagePub:export">
	       		<table:exportExcel url="${ctx}/xmu/res/xmuPagePub/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column xae_user_stuno">学号</th>
				<th  class="sort-column xae_user_name">姓名</th>
				<th  class="sort-column ">学院</th>
				<th  class="sort-column xae_user_profession">专业</th>	
				<th  class="sort-column xpp_page_name">论文题目</th>				
				<th  class="sort-column xpp_page_publication">发表刊物</th>
				<th  class="sort-column xpp_page_time">发表时间</th>
				<th  class="sort-column xpp_page_author_no">第几作者</th>
				<th  class="sort-column xpp_page_type">刊物类别</th>
				<th  class="sort-column xpp_page_factor">发表文章影响因子</th>
				<th  class="sort-column xpp_page_remark">备注</th>
				<th  class="sort-column xpp_status">审核状态</th>			
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xmuPagePub">
			<tr>
				<td> <input type="checkbox" id="${xmuPagePub.id}" status="${xmuPagePub.xppStatus}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看论文发表', '${ctx}/xmu/res/xmuPagePub/form?id=${xmuPagePub.id}','800px', '500px')">
					${xmuPagePub.xppUserStuno}
				</a></td>
				<td>
					${xmuPagePub.xppUserName}
				</td>
				<td>
					${xmuPagePub.xppOfficeName}
				</td>
				<td>
					${fns:getDictLabel(xmuPagePub.xppUserGrade, 'XMU_PROJECT_COR_GRADE', '')}
				</td>
				<td>
					${xmuPagePub.xppPageName}
				</td>
				<td>
					${xmuPagePub.xppPagePublication}
				</td>
				<td>
					<fmt:formatDate value="${xmuPagePub.xppPageTime}" pattern="yyyy"/>
				</td>
				<td>
					${xmuPagePub.xppPageAuthorNo}
				</td>
				<td>
					${xmuPagePub.xppPageType}
				</td>
				<td>
					${xmuPagePub.xppPageFactor}
				</td>
				<td>
					${xmuPagePub.xppPageRemark}
				</td>
				<td>
					${fns:getDictLabel(xmuPagePub.xppStatus, 'XMU_EVENT_STATUS', '')}
				</td>			
				<td>
					<shiro:hasPermission name="xmu:res:xmuPagePub:view">
						<a href="#" onclick="openDialogView('查看论文发表', '${ctx}/xmu/res/xmuPagePub/form?id=${xmuPagePub.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xmu:res:xmuPagePub:edit">
    					<a href="#" onclick="openDialog('修改论文发表', '${ctx}/xmu/res/xmuPagePub/form?id=${xmuPagePub.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xmu:res:xmuPagePub:del">
						<a href="${ctx}/xmu/res/xmuPagePub/delete?id=${xmuPagePub.id}" onclick="return confirmx('确认要删除该论文发表吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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