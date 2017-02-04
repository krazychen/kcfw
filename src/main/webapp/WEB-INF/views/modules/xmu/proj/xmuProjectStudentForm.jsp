<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目人员管理</title>
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
	<form:form id="inputForm" modelAttribute="xmuProjectStudent" action="${ctx}/xmu/proj/xmuProjectStudent/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>项目ID：</label></td>
					<td class="width-35">
						<form:input path="xpsProjId" htmlEscape="false" maxlength="200" class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>学生学院ID：</label></td>
					<td class="width-35">
						<form:input path="xpsOfficeId" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>学院：</label></td>
					<td class="width-35">
						<form:input path="xpsOfficeName" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>学生ID：</label></td>
					<td class="width-35">
						<form:input path="xpsUserId" htmlEscape="false" maxlength="2000" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>姓名：</label></td>
					<td class="width-35">
						<form:input path="xpsUserName" htmlEscape="false" maxlength="2000" class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right">年级：</label></td>
					<td class="width-35">
						<form:input path="xpuUserGrade" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">专业：</label></td>
					<td class="width-35">
						<form:input path="xpuUserProfession" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">学号：</label></td>
					<td class="width-35">
						<form:input path="xpuUserStuno" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">证件号：</label></td>
					<td class="width-35">
						<form:input path="xpuUserLincno" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">毕业中学：</label></td>
					<td class="width-35">
						<form:input path="xpuUserMidsch" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">毕业时间：</label></td>
					<td class="width-35">
						<input id="xpuUserGradTime" name="xpuUserGradTime" type="text" maxlength="20" class="laydate-icon form-control layer-date formDateMaxWidth "
							value="<fmt:formatDate value="${xmuProjectStudent.xpuUserGradTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</td>
					<td class="width-15 active"><label class="pull-right">毕业去向：</label></td>
					<td class="width-35">
						<form:select path="xpuUserGradAdd" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_STU_GRAD_ADD')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">读研学校：</label></td>
					<td class="width-35">
						<form:input path="xpuUserGraduteSch" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">读研专业：</label></td>
					<td class="width-35">
						<form:input path="xpuUserGraduteProf" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">工作单位：</label></td>
					<td class="width-35">
						<form:input path="xpuUserWork" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">待定说明：</label></td>
					<td class="width-35">
						<form:input path="xpuUserRemark" htmlEscape="false" maxlength="2000" class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">导师：</label></td>
					<td class="width-35">
						<form:input path="xpuUserTeacher" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">职称：</label></td>
					<td class="width-35">
						<form:select path="xpuUserTeacherJobtitle" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_STU_TEA_JOBTITLE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">头衔：</label></td>
					<td class="width-35">
						<form:select path="xpuUserTeacherTitle" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_STU_TEA_TITLE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="width-15 active"><label class="pull-right">入选时间：</label></td>
					<td class="width-35">
						<input id="xpuUserRegTime" name="xpuUserRegTime" type="text" maxlength="20" class="laydate-icon form-control layer-date formDateMaxWidth "
							value="<fmt:formatDate value="${xmuProjectStudent.xpuUserRegTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">退出时间：</label></td>
					<td class="width-35">
						<input id="xpuUserExitTime" name="xpuUserExitTime" type="text" maxlength="20" class="laydate-icon form-control layer-date formDateMaxWidth "
							value="<fmt:formatDate value="${xmuProjectStudent.xpuUserExitTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</td>
					<td class="width-15 active"><label class="pull-right">状态：</label></td>
					<td class="width-35">
						<form:select path="xpuUserStatus" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_STU_STATUS')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>