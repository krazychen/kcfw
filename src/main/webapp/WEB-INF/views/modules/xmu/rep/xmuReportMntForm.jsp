<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目汇报管理</title>
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
	<form:form id="inputForm" modelAttribute="xmuReportMnt" action="${ctx}/xmu/rep/xmuReportMnt/save" method="post" class="form-horizontal">
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
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>年份：</label></td>
					<td class="width-35">
						<form:input path="xrmMonths" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>学院：</label></td>
					<td class="width-35">
						<sys:treeselect id="xrmOfficeId" name="xrmOfficeId" value="${xmuReportMnt.xrmOfficeId}" labelName="xrmOfficeName" labelValue="${xmuReportMnt.xrmOfficeName}"
							title="部门" url="/sys/office/treeData?type=2" isAll="true"  cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>项目名称：</label></td>
					<td class="width-35">
						<sys:gridselect url="${ctx}/xmu/rep/xmuReportMnt/selectProject" id="xrmProjId" name="xrmProjId"  value="${xmuReportMnt.xrmProjId}"  title="选择项目" labelName="xrmProjName" 
					labelValue="${xmuReportMnt.xrmProjName}" cssClass="form-control required" fieldLabels="项目名称|项目开始时间|项目结束时间|项目简介" fieldKeys="xmpName|xmpMaintDate|xmpEndDate|xmpDescp" searchLabel="项目名称" searchKey="xmpName" ></sys:gridselect>
					<!-- 
						<form:input path="xrmProjId" htmlEscape="false" type="hidden" maxlength="200" class="form-control "/>
						<form:input path="xrmProjName" htmlEscape="false" maxlength="64" class="form-control "/> -->
					</td>
					<td class="width-15 active"><label class="pull-right">下载模版：</label></td>
					<td class="width-35">
						<form:hidden id="xrmTemplate" path="xrmTemplate" htmlEscape="false" maxlength="1000" class="input-large"/>
						<sys:ckfinder input="xrmTemplate" type="files" readonly="true" uploadPath="/xrmTemplate" selectMultiple="false"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">汇报说明：</label></td>
					<td colspan="5">
						<form:textarea id="xrmDescp" htmlEscape="false" path="xrmDescp" rows="2" maxlength="2000" class="input-xxlarge"/>
						<sys:ckeditor replace="xrmDescp" uploadPath="/xrmDescp "  height="250px"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">附件：</label></td>
					<td class="width-35">
						<form:hidden id="xrmFiles" path="xrmFiles" htmlEscape="false" maxlength="2000" class="form-control"/>
						<sys:ckfinder input="xrmFiles" type="files" uploadPath="/xmu/rep/xmuReportMnt" selectMultiple="true"/>
					</td>
					<td class="width-15 active"></td>
		   			<td class="width-35" ></td>
		  		</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>