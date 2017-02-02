<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成方案管理</title>
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

		function save(index,layero,body){
			var flag=body.find("#flag");
			flag.val("0");
		}
		function saveGen(index,layero,body){
			var flag=body.find("#flag");
			flag.val("1");
		}
		$(document).ready(function() {
			$("#name").focus();
			layer.layerAddBtn("关闭",function(index){top.layer.close(index)},"true");
			layer.layerAddBtn("保存并生成代码",saveGen);
			 layer.layerAddBtn("保存",save);
			validateForm=$("#inputForm").validate({
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
	<form:form id="inputForm" modelAttribute="genScheme" action="${ctx}/gen/genScheme/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="flag"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
		      	<td  class="width-15 active">	<label class="pull-right">方案名称:</label></td>
		        <td colspan="3" ><form:input path="name" htmlEscape="false" maxlength="200" class="form-control required"/></td>
		      </tr>	
		      <tr>
		      	<td  class="width-15 active">	<label class="pull-right">模板分类:</label></td>
		        <td  class="width-35" >
			        <form:select path="category" class="form-control required">
						<form:options items="${config.categoryList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline">
						生成结构：{包名}/{模块名}/{分层(dao,entity,service,web)}/{子模块名}/{java类}
					</span>
		        </td>
		      	<td  class="width-15 active">	<label class="pull-right">生成包路径:</label></td>
		        <td class="width-35" >
		        	<form:input path="packageName" htmlEscape="false" maxlength="500" class="form-control required"/>
		        	<span class="help-inline">建议模块包：com.krazy.kcfw.modules</span>
		        </td>  
		      </tr>
		      <tr>
		      	<td  class="width-15 active">	<label class="pull-right">生成模块名:</label></td>
		        <td  class="width-35" >
			        <form:input path="moduleName" htmlEscape="false" maxlength="500" class="form-control required"/>
		        	<span class="help-inline">可理解为子系统名，例如 sys</span>
		        </td>
		      	<td  class="width-15 active">	<label class="pull-right">生成子模块名:</label></td>
		        <td class="width-35" >
		        	<form:input path="subModuleName" htmlEscape="false" maxlength="500" class="form-control required"/>
		        	<span class="help-inline">可选，分层下的文件夹，例如 </span>
		        </td>
		      </tr>
		      <tr>
		      	<td  class="width-15 active">	<label class="pull-right">生成功能描述:</label></td>
		        <td  class="width-35" >
			        <form:input path="functionName" htmlEscape="false" maxlength="500" class="form-control required"/>
		        	<span class="help-inline">将设置到类描述</span>
		        </td>
		      	<td  class="width-15 active">	<label class="pull-right">生成功能名:</label></td>
		        <td class="width-35" >
		        	<form:input path="functionNameSimple" htmlEscape="false" maxlength="500" class="form-control required"/>
		        	<span class="help-inline">用作功能提示，如：保存“某某”成功</span>
		        </td>	        
		      </tr>
		      <tr>
		         <td  class="width-15 active">	<label class="pull-right">业务表名:</label></td>
		        <td colspan="3">
		        	<form:select path="genTable.id" class="form-control required">
						<form:options items="${tableList}" itemLabel="nameAndComments" itemValue="id" htmlEscape="false"/>
					</form:select>
					<span class="help-inline">生成的数据表，一对多情况下请选择主表。</span>
		        </td>		      
		      </tr>
		      <tr>
		      	<td  class="width-15 active">	<label class="pull-right">生成功能作者:</label></td>
		      	<td  class="width-35" >
			        <form:input path="functionAuthor" htmlEscape="false" maxlength="500" class="form-control required"/>
		        	<span class="help-inline">功能开发者</span>
		        </td>
		     	 <td  class="width-15 active">	<label class="pull-right">生成选项:</label></td>
		        <td  class="width-35" >
			        <form:checkbox path="replaceFile" label="是否替换现有文件" cssClass="i-checks"/>
		        </td>
		      </tr>
		      <tr>
		         <td class="active"><label class="pull-right">备注:</label></td>
		         <td colspan="3"><form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/></td>
		      </tr>
			</tbody>
		</table>   
	</form:form>
</body>
</html>
