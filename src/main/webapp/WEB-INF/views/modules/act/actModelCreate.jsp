<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建模型 - 模型管理</title>
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
	
		$(document).ready(function(){
			top.$.jBox.tip.mess = null;
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
					//setTimeout(function(){location='${ctx}/act/model/'}, 50);
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
	<form id="inputForm" action="${ctx}/act/model/create" target="_blank" method="post" class="form-horizontal">
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">流程分类：</label></td>
					<td class="width-35">
						<select id="category" name="category" class="form-control required">
							<c:forEach items="${fns:getDictList('act_category')}" var="dict">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>模块名称：</label></td>
					<td class="width-35">
						<input id="name" name="name" type="text" class="form-control required" />
					</td>
				</tr>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>模块标识：</label></td>
					<td class="width-35">
						<input id="key" name="key" type="text" class="form-control required" />
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>模块描述：</label></td>
					<td class="width-35">
						<textarea id="description" name="description" class="form-control required"></textarea>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form>
</body>
</html>
