<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>资源申请记录</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sch/res/schTechResourceApply/">资源申请记录</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="schTechResourceApply" action="${ctx}/sch/res/schTechResourceApply/applyList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>申请日期：</label>
				<input name="scaApplyDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${schTechResourceApply.scaApplyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>申请状态：</label>
				<form:select path="scaApplyStatus" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('TECH_RESOURCE_APPLY_STATUS')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>科研资源信息</th>
			<!-- 	<th>申请人ID</th> -->
				<th>申请时间段</th>
				<th>申请日期</th>
				<th>申请审核意见</th>
				<th>申请状态</th>
				<!-- <shiro:hasPermission name="sch:res:schTechResourceApply:edit"><th>操作</th></shiro:hasPermission> -->
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schTechResourceApply">
			<tr>
				<td><!-- <a href="${ctx}/sch/res/schTechResourceApply/form?id=${schTechResourceApply.id}">
					
				</a> -->
					${schTechResourceApply.scaSchName}
				</td>
				<!-- <td>
					${schTechResourceApply.scaApplyUserName}
				</td> -->
				<td>
					${schTechResourceApply.scaApplyTimeRange}
				</td>
				<td>
					${schTechResourceApply.scaApplyDate}
				</td>
				<td>
					${schTechResourceApply.scaApplyComment}
				</td>
				<td>
					${fns:getDictLabel(schTechResourceApply.scaApplyStatus, 'SCH_TECH_RESOURCE_APPLY_STATUS', '')}
				</td>
				<!-- 
				<shiro:hasPermission name="sch:res:schTechResourceApply:edit"><td>
    				<a href="${ctx}/sch/res/schTechResourceApply/form?id=${schTechResourceApply.id}">修改</a>
					<a href="${ctx}/sch/res/schTechResourceApply/delete?id=${schTechResourceApply.id}" onclick="return confirmx('确认要删除该科研资源申请吗？', this.href)">删除</a>
				</td></shiro:hasPermission> -->
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>