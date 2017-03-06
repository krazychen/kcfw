<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学术活动管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			validateForm = $("#inputForm").validate({
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
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="xmuAcademicEvent" action="${ctx}/xmu/res/xmuAcademicEvent/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">学号：</label></td>
					<td class="width-35">
						<form:input readonly="true" path="xaeUserStuno" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">姓名：</label></td>
					<td class="width-35">
						<form:hidden path="xaeUserId" htmlEscape="false" maxlength="2000" class="form-control"/>
						<form:input readonly="true" path="xaeUserName" htmlEscape="false" maxlength="2000" class="form-control"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">学院：</label></td>
					<td class="width-35">
						<form:hidden path="xaeOfficeId" htmlEscape="false" maxlength="2000" class="form-control"/>
						<form:input readonly="true" path="xaeOfficeName" htmlEscape="false" maxlength="2000" class="form-control"/>
					</td>
					<td class="width-15 active"><label class="pull-right">专业：</label></td>
					<td class="width-35">
						<form:select disabled="true" path="xaeUserProfession" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_COR_PROFESSION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>					
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">年级：</label></td>
					<td class="width-35">
						<form:select disabled="true"  path="xaeUserGrade" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_COR_GRADE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="width-15 active"><label class="pull-right">参加年份：</label></td>
					<td class="width-35">
						<form:input readonly="true" path="xaeEventYears" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>				
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>学术活动名称：</label></td>
					<td class="width-35">
						<form:input readonly="true"  path="xaeEventName" htmlEscape="false" maxlength="64" class="form-control"/>
					</td>	
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>活动类型：</label></td>
					<td class="width-35">
						<form:select disabled="true" path="xaeEventType" class="form-control required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_EVENT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>				
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">地区：</label></td>
					<td class="width-35">
						<form:hidden path="xaeEventAreaId" htmlEscape="false" maxlength="2000" class="form-control"/>
						<form:input readonly="true" path="xaeEventAreaName" htmlEscape="false" maxlength="2000" class="form-control"/>
					</td>
				</tr>
		 	</tbody>
		</table>
		
		<c:if test="${not empty xmuAcademicEvent.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${xmuAcademicEvent.act.procInsId}" />
		</c:if>
		
		<c:if test="${empty xmuAcademicEvent.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${xmuAcademicEvent.procInsId}" />
		</c:if>

	</form:form>
</body>
</html>