<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>流程管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			top.$.jBox.tip.mess = null;
		});
		function page(n,s){
        	location = '${ctx}/act/process/?pageNo='+n+'&pageSize='+s;
        }
		function updateCategory(id, category){
			$.jBox($("#categoryBox").html(), {title:"设置分类", buttons:{"关闭":true}, submit: function(){}});
			$("#categoryBoxId").val(id);
			$("#categoryBoxCategory").val(category);
		}
	</script>
	<script type="text/template" id="categoryBox">
		<form id="categoryForm" action="${ctx}/act/process/updateCategory" method="post" enctype="multipart/form-data"
			style="text-align:center;" class="form-search" onsubmit="loading('正在设置，请稍等...');"><br/>
			<input id="categoryBoxId" type="hidden" name="procDefId" value="" />
			<select id="categoryBoxCategory" name="category">
				<option value="">无分类</option>
				<c:forEach items="${fns:getDictList('act_category')}" var="dict">
					<option value="${dict.value}">${dict.label}</option>
				</c:forEach>
			</select>
			<br/><br/>　　
			<input id="categorySubmit" class="btn btn-primary" type="submit" value="   保    存   "/>　　
		</form>
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-content">
	
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/act/process/">流程管理</a></li>
		<li><a href="${ctx}/act/process/deploy/">部署流程</a></li>
		<li><a href="${ctx}/act/process/running/">运行中的流程</a></li>
	</ul>
	<sys:message content="${message}"/>
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form id="searchForm" action="${ctx}/act/process/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<select style="width:210px" id="category" name="category" class="form-control m-b">
				<option value="">全部分类</option>
				<c:forEach items="${fns:getDictList('act_category')}" var="dict">
					<option value="${dict.value}" ${dict.value==category?'selected':''}>${dict.label}</option>
				</c:forEach>
			</select>
		</div>
	</form>
	
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
			</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" style="word-break:break-all; word-wrap:break-all;" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th nowrap>流程分类</th>
				<th nowrap>流程ID</th>
				<th nowrap>流程标识</th>
				<th nowrap>流程名称</th>
				<th nowrap>流程版本</th>
				<th nowrap>部署时间</th>
				<th nowrap>流程XML</th>
				<th nowrap>流程图片</th>
				<th nowrap>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="object">
				<c:set var="process" value="${object[0]}" />
				<c:set var="deployment" value="${object[1]}" />
				<tr>
					<td><a href="javascript:updateCategory('${process.id}', '${process.category}')" title="设置分类">${fns:getDictLabel(process.category,'act_category','无分类')}</a></td>
					<td>${process.id}</td>
					<td>${process.key}</td>
					<td>${process.name}</td>
					<td><b title='流程版本号'>V: ${process.version}</b></td>
					<td><fmt:formatDate value="${deployment.deploymentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td><a target="_blank" href="${ctx}/act/process/resource/read?procDefId=${process.id}&resType=xml">${process.resourceName}</a></td>
					<td><a target="_blank" href="${ctx}/act/process/resource/read?procDefId=${process.id}&resType=image">${process.diagramResourceName}</a></td>
					<td>
						<c:if test="${process.suspended}">
							<a href="${ctx}/act/process/update/active?procDefId=${process.id}" onclick="return confirmx('确认要激活吗？', this.href)">激活</a>
						</c:if>
						<c:if test="${!process.suspended}">
							<a href="${ctx}/act/process/update/suspend?procDefId=${process.id}" onclick="return confirmx('确认挂起除吗？', this.href)">挂起</a>
						</c:if>
						<a href='${ctx}/act/process/delete?deploymentId=${process.deploymentId}' onclick="return confirmx('确认要删除该流程吗？', this.href)">删除</a>
                        <a href='${ctx}/act/process/convert/toModel?procDefId=${process.id}' onclick="return confirmx('确认要转换为模型吗？', this.href)">转换为模型</a>
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
