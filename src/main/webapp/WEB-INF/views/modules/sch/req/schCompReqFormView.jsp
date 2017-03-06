<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业需求管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
			//手机号码验证  
			jQuery.validator.addMethod("isMobile", function(value, element) {  
			  var length = value.length; 
        var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/; 
        var tel = /^\d{3,4}-?\d{7,9}$/; 
        return this.optional(element) || (tel.test(value) || mobile.test(value));
			}, "请正确填写联系电话");  
			
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				rules: {
					scrCompanyPhone: { 
						required : true,  
			            minlength : 11,  
			            isMobile : true 
			        },
		         	scrCompanyEmail: { 
		         		required : true,  
			            email: true 
			         }
                },
                messages : {  
                	scrCompanyPhone : {  
                		required : "请输入手机号",  
                        minlength : "确认手机不能小于11个字符",  
                        isMobile : "请正确填写您的手机号码"  
                    },
                    scrCompanyEmail : {  
                		required : "请输入邮箱",  
                        email : "请正确填写您的邮箱"  
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
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sch/req/schCompReq/form?id=${schCompReq.id}">企业需求详情</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schCompReq" action="${ctx}/sch/req/schCompReq/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<table class="table-form">	
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>难题名称：
					</td>
					<td colspan="3">
						${schCompReq.scrName }
					</td>
					
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>所属行业：
					</td>
					<td>
						${fns:getDictLabel(schCompReq.scrIndustry, 'COMPANY_REQ_INDUSTRY', '')}
					</td>
					
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>内容与说明：
					</td>
					<td colspan="5">
						${schCompReq.scrContent }
					</td>
				</tr>
				<tr>
					<td class="tit">
						市场前景(方向)：
					</td>
					<td colspan="5">
						${schCompReq.scrMarket }
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作方式：
					</td>
					<td>
						${fns:getDictLabel(schCompReq.scrCoopMethod, 'COMPANY_REQ_COOP_METHOD', '')}
					</td>

					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>企业名称：
					</td>
					<td>
						${schCompReq.scrCompanyName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>联系人：
					</td>
					<td>
						${schCompReq.scrCompanyContact }
					</td>
					

				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>联系电话：
					</td>
					<td>
						${schCompReq.scrCompanyPhone }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>电子邮箱：
					</td>
					<td>
						${schCompReq.scrCompanyEmail }
					</td>
					<td class="tit">
						失效日期：
					</td>
					<td>
						<fmt:formatDate value="${schCompReq.scrExpiryDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						文件：
					</td>
					<td colspan="5">
						<form:hidden id="scrFiles" path="scrFiles" htmlEscape="false" maxlength="2000" class="input-large editFormFieldWidth"/>
						<sys:ckfinder input="scrFiles" type="files" uploadPath="/company_req" selectMultiple="true"  readonly="true"/>
					</td>
				</tr>
			</table>
		</fieldset>
		
		<c:if test="${not empty schCompReq.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schCompReq.act.procInsId}" />
		</c:if>
		
		<c:if test="${empty schCompReq.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schCompReq.procInsId}" />
		</c:if>
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>