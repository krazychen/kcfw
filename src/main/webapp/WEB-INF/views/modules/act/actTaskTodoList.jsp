<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>待办任务</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		/**
		 * 签收任务
		 */
		function claim(taskId) {
			top.$.jBox.confirm("确定接受此任务吗？","系统提示",function(v,h,f){
				if(v=="ok"){
					$.get('${ctx}/act/task/claim' ,{taskId: taskId}, function(data) {
						if (data == 'true'){
				        	top.$.jBox.tip('接受任务完成',"success",{persistent:true,opacity:0});
				            location = '${ctx}/act/task/todo/';
						}else{
				        	top.$.jBox.tip('接受任务失败',"error",{persistent:true,opacity:0});
						}
				    });
				}
			},{buttonsFocus:1});
			top.$('.jbox-body .jbox-icon').css('top','55px');
		}
		
		/**
		 * 取消签收任务
		 */
		function unClaim(taskId) {
			top.$.jBox.confirm("确定取消接受此任务吗？","系统提示",function(v,h,f){
				if(v=="ok"){
					$.get('${ctx}/act/task/unClaim' ,{taskId: taskId}, function(data) {
						if (data == 'true'){
				        	top.$.jBox.tip('取消接受完成',"success",{persistent:true,opacity:0});
				            location = '${ctx}/act/task/todo/';
						}else{
				        	top.$.jBox.tip('取消接受失败',"error",{persistent:true,opacity:0});
						}
				    });
				}
			},{buttonsFocus:1});
			top.$('.jbox-body .jbox-icon').css('top','55px');
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/act/task/todo/">待办任务</a></li>
		<li><a href="${ctx}/act/task/historic/">已办任务</a></li>
	<!-- <li><a href="${ctx}/act/task/process/">新建任务</a></li> -->	
	</ul>
	<form:form id="searchForm" modelAttribute="act" action="${ctx}/act/task/todo/" method="get" class="breadcrumb form-search">
		<div>
			<label>流程类型：&nbsp;</label>
			<form:select path="procDefKey" class="input-medium">
				<form:option value="" label="全部流程"/>
				<form:options items="${fns:getDictList('act_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
			<label>创建时间：</label>
			<input id="beginDate"  name="beginDate"  type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:163px;"
				value="<fmt:formatDate value="${act.beginDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				　--　
			<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:163px;"
				value="<fmt:formatDate value="${act.endDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
			&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标题</th>
				<th>当前环节</th><%--
				<th>任务内容</th> --%>
				<th>流程名称</th>
				<!--  <th>流程版本</th>-->
				<th>发起人</th>
				<th>发起人部门</th>
				<th>发起人电话</th>
				<!-- <th>流程类型</th>-->
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="act">
				<c:set var="task" value="${act.task}" />
				<c:set var="vars" value="${act.vars}" />
				<c:set var="procDef" value="${act.procDef}" /><%--
				<c:set var="procExecUrl" value="${act.procExecUrl}" /> --%>
				<c:set var="status" value="${act.status}" />
				<tr>
					<td>
					<!-- 
						<c:if test="${empty task.assignee}">
							<a href="javascript:claim('${task.id}');" title="签收任务">${fns:abbr(not empty act.vars.map.title ? act.vars.map.title : task.id, 60)}</a>
						</c:if>
						<c:if test="${not empty task.assignee}">  
							<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">${fns:abbr(not empty vars.map.title ? vars.map.title : task.id, 60)}</a>
						</c:if>  
						 -->
						 <a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">${fns:abbr(not empty vars.map.title ? vars.map.title : task.id, 60)}</a>
						 
					</td>
					<td>
						<a target="_blank" href="${pageContext.request.contextPath}/act/diagram-viewer?processDefinitionId=${task.processDefinitionId}&processInstanceId=${task.processInstanceId}">${task.name}</a>
					</td><%--
					<td>${task.description}</td> --%>
					<td>${procDef.name}</td>
				<!--  <td><b title='流程版本号'>V: ${procDef.version}</b></td>-->	
					<td>${act.createName} </td>
					<td>${act.assigneeOfficeName} </td>
					<td>${act.assigneePhone} </td>
				<!-- 	<td><c:if test="${act.processType=='claim'}">待接受任务</c:if><c:if test="${act.processType=='todo'}">待办理任务</c:if></td>-->
					<td><fmt:formatDate value="${task.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>
					<!-- 移除签收任务节点，改为在办理时自动完成
						<c:if test="${empty task.assignee}">
							<a href="javascript:claim('${task.id}');">接受任务</a>
						</c:if>
						<c:if test="${act.isCliamed == 'true'}">
							<a href="javascript:unClaim('${task.id}');">取消接受</a>
						</c:if> -->
					
						<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}&assignee=${task.assignee}">任务办理</a>
						
						<!--<c:if test="${not empty task.assignee}"> --><%--
							<a href="${ctx}${procExecUrl}/exec/${task.taskDefinitionKey}?procInsId=${task.processInstanceId}&act.taskId=${task.id}">办理</a> --%>
						<!--</c:if>-->
						<shiro:hasPermission name="act:process:edit">
							<c:if test="${empty task.executionId}">
								<a href="${ctx}/act/task/deleteTask?taskId=${task.id}&reason=" onclick="return promptx('删除任务','删除原因',this.href);">删除任务</a>
							</c:if>
						</shiro:hasPermission>
						<a target="_blank" href="${pageContext.request.contextPath}/act/diagram-viewer?processDefinitionId=${task.processDefinitionId}&processInstanceId=${task.processInstanceId}">跟踪</a><%-- 
						<a target="_blank" href="${ctx}/act/task/trace/photo/${task.processDefinitionId}/${task.executionId}">跟踪2</a> 
						<a target="_blank" href="${ctx}/act/task/trace/info/${task.processInstanceId}">跟踪信息</a> --%>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
