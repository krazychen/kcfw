<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>科研资源申请管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sch/res/schTechResourceApply/">科研资源申请列表</a></li>
		<li class="active"><a href="${ctx}/sch/res/schTechResourceApply/form?id=${schTechResourceApply.id}">科研资源申请<shiro:hasPermission name="sch:res:schTechResourceApply:edit">${not empty schTechResourceApply.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:res:schTechResourceApply:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schTechResourceApply" action="${ctx}/sch/res/schTechResourceApply/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<table class="table-form">	
						<tr>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>科研资源信息ID：
							</td>
							<td>
								<form:input path="scaSchId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
							</td>
						</tr>
						<tr>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>申请人ID：
							</td>
							<td>
								<sys:treeselect id="scaApplyUserId" name="scaApplyUserId" value="${schTechResourceApply.scaApplyUserId}" labelName="" labelValue="${schTechResourceApply.}"
									title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
							</td>
						</tr>
						<tr>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>申请时间段：
							</td>
							<td>
								<form:input path="scaApplyTimeRange" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
							</td>
						</tr>
						<tr>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>申请日期：
							</td>
							<td>
								<input name="scaApplyDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
									value="<fmt:formatDate value="${schTechResourceApply.scaApplyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</td>
						</tr>
						<tr>
							<td class="tit">
								申请审核意见：
							</td>
							<td>
								<form:input path="scaApplyComment" htmlEscape="false" maxlength="2000" class="input-xlarge "/>
							</td>
						</tr>
						<tr>
							<td class="tit">
								流程实例ID：
							</td>
							<td>
								<form:input path="procInsId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
							</td>
						</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="sch:res:schTechResourceApply:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<input id="btnAdd" class="btn btn-primary" type="button" value="新 增" onClick="location.href='${ctx}/sch/res/schTechResourceApply/form'"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>