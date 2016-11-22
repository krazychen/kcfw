<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专利机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

			//手机号码验证  
			jQuery.validator.addMethod("isMobile", function(value, element) {  
			    var length = value.length;  
			    var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;  
			    return this.optional(element) || (length == 11 && mobile.test(value));  
			}, "请正确填写您的手机号码");  
			
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				rules: {
					spaPhone: { required : true,  
			            minlength : 11,  
			            isMobile : true  }
                },
                messages : {  
                	spaPhone : {  
                		required : "请输入手机号",  
                        minlength : "确认手机不能小于11个字符",  
                        isMobile : "请正确填写您的手机号码"  
                    }
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
			
			if($("#spaCode").val()){
				 $('#spaCode').attr("disabled","disabled");
			}
		});

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sch/patent/schPatentAgency/">专利机构列表</a></li>
		<li class="active"><a href="${ctx}/sch/patent/schPatentAgency/form?id=${schPatentAgency.id}">专利机构<shiro:hasPermission name="sch:patent:schPatentAgency:edit">${not empty schPatentAgency.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:patent:schPatentAgency:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schPatentAgency" action="${ctx}/sch/patent/schPatentAgency/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<table class="table-form">	
						<tr>
							<td class="tit">
									<span class="help-inline"><font color="red">*</font> </span>机构代码：
							</td>
							<td>
								<form:input path="spaCode" htmlEscape="false" maxlength="45" class="input-xlarge required"/>
							</td>
							<td class="tit">
									<span class="help-inline"><font color="red">*</font> </span>机构名称：
							</td>
							<td>
								<form:input path="spaName" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
							</td>
							<td class="tit">
									<span class="help-inline"><font color="red">*</font> </span>联系人：
							</td>
							<td>
								<form:input path="spaContacts" htmlEscape="false" maxlength="45" class="input-xlarge required"/>
							</td>
						</tr>
						<tr>
							<td class="tit">
									<span class="help-inline"><font color="red">*</font> </span>联系方式：
							</td>
							<td>
								<form:input path="spaPhone" htmlEscape="false" maxlength="45" class="input-xlarge required"/>
							</td>
							<td class="tit">
									<span class="help-inline"><font color="red">*</font> </span>联系地址：
							</td>
							<td>
								<form:input path="spaAddress" htmlEscape="false" maxlength="45" class="input-xlarge required"/>
							</td>
						</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="sch:patent:schPatentAgency:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<input id="btnAdd" class="btn btn-primary" type="button" value="新 增" onClick="location.href='${ctx}/sch/patent/schPatentAgency/form'"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>