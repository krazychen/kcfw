<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr><th nowrap>环节类型</th><th nowrap>执行环节</th><th nowrap>执行人</th><th nowrap>执行人部门</th>
	<th nowrap>执行人电话</th><th nowrap>开始时间</th><th nowrap>结束时间</th><th nowrap>提交意见</th><th nowrap>任务历时</th></tr>
	</thead>
	<tbody>
	<c:forEach items="${histoicFlowList}" var="act">
		<tr>
			<td>已完成</td>
			<td>${act.histIns.activityName}</td>
			<td>${act.assigneeName}</td>
			<td>${act.assigneeOfficeName}</td>
			<td>${act.assigneePhone}</td>
			<td><fmt:formatDate value="${act.histIns.startTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td><fmt:formatDate value="${act.histIns.endTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td style="word-wrap:break-word;word-break:break-all;">${act.comment}</td>
			<td>${act.durationTime}</td>
		</tr>
	</c:forEach>
	<c:forEach items="${currentNode}" var="act">
		<tr>
			<td>正在执行</td>
			<td>${act.taskName}</td>
			<td>${act.assigneeName}</td>
			<td>${act.assigneeOfficeName}</td>
			<td>${act.assigneePhone}</td>
			<td></td>
			<td></td>
			<td style="word-wrap:break-word;word-break:break-all;"></td>
			<td></td>
		</tr>
	</c:forEach>
	</tbody>
</table>