<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专家讲座管理</title>
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
	<form:form id="inputForm" modelAttribute="xmuExpertLecture" action="${ctx}/xmu/res/xmuExpertLecture/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">项目名称：</label></td>
					<td class="width-35">
						<sys:gridselect url="${ctx}/xmu/proj/xmuProjectCource/selectProject" id="xelProjId" name="xelProjId"  value="${xmuExpertLecture.xelProjId}"  title="选择项目" labelName="xelProjName" 
						labelValue="${xmuExpertLecture.xelProjName}" cssClass="form-control required" fieldLabels="项目名称|项目开始时间|项目结束时间|项目简介" fieldKeys="xmpName|xmpMaintDate|xmpEndDate|xmpDescp" searchLabel="项目名称" searchKey="xmpName" ></sys:gridselect>
					</td>
					<td class="width-15 active"><label class="pull-right">学院：</label></td>
					<td class="width-35">
						<sys:treeselect id="xelExpretOfficeId" name="xelExpretOfficeId" value="${xmuExpertLecture.xelExpretOfficeId}" labelName="xelExpretOffice" labelValue="${xmuExpertLecture.xelExpretOffice}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="form-control " allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">专业：</label></td>
					<td class="width-35">
						<form:select path="xelExpertProfession" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_COR_PROFESSION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="width-15 active"><label class="pull-right">学年学期：</label></td>
					<td class="width-35">
						<form:select path="xelExpertGrade" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_COR_GRADE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">姓名：</label></td>
					<td class="width-35">
						<form:input path="xelExpertName" htmlEscape="false" maxlength="200" class="form-control "/>
					</td>					
					<td class="width-15 active"><label class="pull-right">讲座名称：</label></td>
					<td class="width-35">
						<form:input path="xelExpertLectureName" htmlEscape="false" maxlength="200" class="form-control "/>
					</td>
				</tr>
				<tr>					
					<td class="width-15 active"><label class="pull-right">地区：</label></td>
					<td class="width-35">
						<sys:treeselect id="xelExpertAreaId" name="xelExpertAreaId" value="${xmuExpertLecture.xelExpertAreaId}" labelName="xelExpertArea" labelValue="${xmuExpertLecture.xelExpertArea}"
							title="区域" url="/sys/area/treeData" cssClass="form-control " allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="width-15 active"><label class="pull-right">单位：</label></td>
					<td class="width-35">
						<form:input path="xelExpertUnit" htmlEscape="false" maxlength="200" class="form-control "/>
					</td>
				</tr>
				<tr>										
					<td class="width-15 active"><label class="pull-right">职称：</label></td>
					<td class="width-35">
						<form:select path="xelExpertJobTitle" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_STU_TEA_JOBTITLE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="width-15 active"><label class="pull-right">头衔：</label></td>
					<td class="width-35">
						<form:select path="xelExpertTitle" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_STU_TEA_TITLE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>