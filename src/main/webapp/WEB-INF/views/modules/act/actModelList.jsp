<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>模型管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			top.$.jBox.tip.mess = null;
		});

		function updateCategory(id, category){
			$.jBox($("#categoryBox").html(), {title:"设置分类", buttons:{"关闭":true}, submit: function(){}});
			$("#categoryBoxId").val(id);
			$("#categoryBoxCategory").val(category);
		}
		
		function createModel(){
			if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
				width='auto';
				height='auto';
			}else{//如果是PC端，根据用户设置的width和height显示。
			
			}
			
			top.layer.open({
			    type: 2,  
			    area: ['800px', '300px'],
			    title: "创建模型",
		        maxmin: true, //开启最大化最小化按钮
			    content: "${ctx}/act/model/create" ,
			    btn: ['确定', '关闭'],
			    yes: function(index, layero){
			    	 var body = top.layer.getChildFrame('body', index);
			         var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			         var inputForm = body.find('#inputForm');
			        inputForm.attr("target","_blank");//表单提交成功后，从服务器返回的url在当前tab中展示			         
		         	if(iframeWin.contentWindow.doSubmit() ){
		         		// top.layer.close(index);//关闭对话框。
		         		setTimeout(function(){
		         			top.layer.close(index);
		         			sortOrRefresh();
		         		}, 500);//延时0.1秒，对应360 7.1版本bug
		         	}
				  },
				  cancel: function(index){ 
			       }
			}); 	
		}
	</script>
	<script type="text/template" id="categoryBox">
		<form id="categoryForm" action="${ctx}/act/model/updateCategory" method="post" enctype="multipart/form-data"
			style="text-align:center;" class="form-search" onsubmit="loading('正在分类，请稍等...');"><br/>
			<input id="categoryBoxId" type="hidden" name="id" value="" />
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
	<div class="ibox-title">
		<h5>模型列表 </h5>
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
	<form id="searchForm" action="${ctx}/act/model/"  method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>项目名称：</span>
			<select id="category" name="category" style="width:210px"  class="form-control m-b">
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
			<shiro:hasPermission name="xmu:proj:xmuProject:add">				
				<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="createModel()" title="添加"><i class="glyphicon glyphicon-repeat"></i> 添加</button>
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
	<table id="contentTable" style="word-break:break-all; word-wrap:break-all;" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th nowrap>流程分类</th>
				<th>模型ID</th>
				<th>模型标识</th>
				<th>模型名称</th>
				<th nowrap>版本号</th>
				<th>创建时间</th>
				<th>最后更新时间</th>
				<th nowrap>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="model">
			<tr>
				<td> <input type="checkbox" id="${model.id}" class="i-checks"></td>
				<td><a href="javascript:updateCategory('${model.id}', '${model.category}')" title="设置分类">${fns:getDictLabel(model.category,'act_category','无分类')}</a></td>
				<td>${model.id}</td>
				<td>${model.key}</td>
				<td>${model.name}</td>
				<td><b title='流程版本号'>V: ${model.version}</b></td>
				<td><fmt:formatDate value="${model.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${model.lastUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
					<a href="${pageContext.request.contextPath}/act/process-editor/modeler.jsp?modelId=${model.id}" target="_blank">编辑</a>
					<a href="${ctx}/act/model/deploy?id=${model.id}" onclick="return confirmx('确认要部署该模型吗？', this.href)">部署</a>
					<a href="${ctx}/act/model/export?id=${model.id}" target="_blank">导出</a>
                    <a href="${ctx}/act/model/delete?id=${model.id}" onclick="return confirmx('确认要删除该模型吗？', this.href)">删除</a>
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
