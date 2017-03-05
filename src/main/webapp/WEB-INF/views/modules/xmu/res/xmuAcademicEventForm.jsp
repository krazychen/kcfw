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
		
		function addStu(){
			top.layer.open({
			    type: 2,  
			    area: ['800px', '550px'],
			    title:"选择项目人员",
			    name:'friend',
			    content: "${ctx}/xmu/res/xmuAcademicEvent/listStu" ,
			    btn: ['确定', '关闭'],
			    yes: function(index, layero){
			    	 var iframeWin = layero.find('iframe')[0].contentWindow; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
			    	 var items = iframeWin.getSelectedItem();
					 if(items=="-1"){
						 return false;
					 }else{
						 $("#xaeUserId").val(items[0]);
						 $("#xaeUserStuno").val(items[1]);
						 $("#xaeUserName").val(items[2]);
						 $("#xaeOfficeId").val(items[5]);
						 $("#xaeOfficeName").val(items[6]);
						 $("#xaeUserProfession").find("option[value='"+items[4]+"']").attr("selected",true);
						// $("#xaeUserProfession").val(items[4]);
						 $("#xaeUserGrade").val(items[3]);
						 top.layer.close(index);//关闭对话框。
					 }
					 
				  },
				  cancel: function(index){ 
			       }
			});
		}
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
						<c:if test="${fn:contains(role, 'Student')}" >
							<form:input readonly="true" path="xaeUserStuno" htmlEscape="false" maxlength="64" class="form-control "/>
						</c:if>
						<c:if test="${fn:contains(role, 'Manager')}" >
							<div class="input-group">
								<input id="xaeUserStuno"  name="xaeUserStuno" readonly="readonly" type="text" value="${xmuAcademicEvent.xaeUserStuno}" class="form-control "/>
					       		 <span class="input-group-btn">
						       		 <button type="button" onclick="addStu();" id="xaeUserStunoButton" class="btn btn-primary"><i class="fa fa-search"></i>
						             </button> 
					       		 </span>
						       		
						    </div>
						</c:if>
					</td>
					<td class="width-15 active"><label class="pull-right">姓名：</label></td>
					<td class="width-35">
						<form:hidden path="xaeUserId" htmlEscape="false" maxlength="2000" class="form-control"/>
						<form:input readonly="true" path="xaeUserName" htmlEscape="false" maxlength="2000" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">学院：</label></td>
					<td class="width-35">
						<form:hidden path="xaeOfficeId" htmlEscape="false" maxlength="2000" class="form-control"/>
						<form:input readonly="true" path="xaeOfficeName" htmlEscape="false" maxlength="2000" class="form-control required"/>
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
						<form:input path="xaeEventYears" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>				
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>学术活动名称：</label></td>
					<td class="width-35">
						<form:input path="xaeEventName" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>	
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>活动类型：</label></td>
					<td class="width-35">
						<form:select path="xaeEventType" class="form-control required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_EVENT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>				
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">地区：</label></td>
					<td class="width-35">
						<sys:treeselect id="xaeEventAreaId" name="xaeEventAreaId" value="${xmuAcademicEvent.xaeEventAreaId}" labelName="xaeEventAreaName" labelValue="${xmuAcademicEvent.xaeEventAreaName}"
							title="区域" url="/sys/area/treeData" cssClass="form-control " allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>