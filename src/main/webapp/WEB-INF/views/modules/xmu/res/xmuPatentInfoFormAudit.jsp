<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专利信息管理</title>
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
			
			laydate({
	            elem: '#xpiPatentYears', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	           	format: 'YYYY' //日期格式
	        });
			laydate({
	            elem: '#xpiPatentPtime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	            format: 'YYYY-MM-DD' //日期格式
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
						 $("#xppUserId").val(items[0]);
						 $("#xppUserStuno").val(items[1]);
						 $("#xppUserName").val(items[2]);
						 $("#xppOfficeId").val(items[5]);
						 $("#xppOfficeName").val(items[6]);
						 $("#xppUserProfession").find("option[value='"+items[4]+"']").attr("selected",true);
						// $("#xaeUserProfession").val(items[4]);
						 $("#xppUserGrade").val(items[3]);
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
	<form:form id="inputForm" modelAttribute="xmuPatentInfo" action="${ctx}/xmu/res/xmuPatentInfo/save" method="post" class="form-horizontal">
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
						<form:input readonly="true" path="xpiUserStuno" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">姓名：</label></td>
					<td class="width-35">
						<form:hidden path="xpiUserId" htmlEscape="false" maxlength="2000" class="form-control"/>
						<form:input readonly="true" path="xpiUserName" htmlEscape="false" maxlength="2000" class="form-control required"/>
					</td>
				</tr>
				
				<tr>
					<td class="width-15 active"><label class="pull-right">学院：</label></td>
					<td class="width-35">
						<form:hidden path="xpiOfficeId" htmlEscape="false" maxlength="2000" class="form-control"/>
						<form:input readonly="true" path="xpiOfficeName" htmlEscape="false" maxlength="2000" class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right">专业：</label></td>
					<td class="width-35">
						<form:select disabled="true" path="xpiUserProfession" class="form-control ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_COR_PROFESSION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>					
				</tr>

				<tr>
					<td class="width-15 active"><label class="pull-right">年份：</label></td>
					<td class="width-35">
						<input id="xpiPatentYears" name="xpiPatentYears" type="text" maxlength="20" class="laydate-icon form-control layer-date formDateMaxWidth "
							value="<fmt:formatDate value="${xmuPatentInfo.xpiPatentYears}" pattern="yyyy"/>"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>专利名称：</label></td>
					<td class="width-35">
						<form:input readonly="true" path="xpiPatentName" htmlEscape="false" maxlength="200" class="form-control required"/>
					</td>
				</tr>
			
				<tr>
					
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>申请公开号：</label></td>
					<td class="width-35">
						<form:input readonly="true" path="xpiPatentPno" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right">申请公开日：</label></td>
					<td class="width-35">
						<input readonly="true" id="xpiPatentPtime" name="xpiPatentPtime" type="text" maxlength="20" class="laydate-icon form-control layer-date formDateMaxWidth "
							value="<fmt:formatDate value="${xmuPatentInfo.xpiPatentPtime}" pattern="yyyy-MM-dd"/>"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">备注：</label></td>
					<td colspan="5">
						<form:textarea readonly="true" path="xpiPatentRemark" htmlEscape="false" rows="4" maxlength="2000" class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>您的审批意见：</label></td>
					<td colspan="5">
						<form:textarea path="act.comment" class="form-control required" rows="5" maxlength="2000" />
					</td>
				</tr>
		 	</tbody>
		</table>
		
		<c:if test="${not empty xmuPagePub.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${xmuPagePub.act.procInsId}" />
		</c:if>
		
		<c:if test="${empty xmuPagePub.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${xmuPagePub.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>