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
                        isMobile : "请正确填写手机号码"  
                    },
                    scrCompanyEmail : {  
                		required : "请输入邮箱",  
                        email : "请正确填写邮箱"  
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
		<li><a href="${ctx}/sch/req/schCompReq/">企业需求列表</a></li>
		<li class="active"><a href="${ctx}/sch/req/schCompReq/form?id=${schCompReq.id}">企业需求<shiro:hasPermission name="sch:req:schCompReq:edit">${not empty schCompReq.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:req:schCompReq:edit">查看</shiro:lacksPermission></a></li>
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
						<form:input path="scrName" htmlEscape="false" maxlength="100" class="input-large required editFormSelectWidth"/>
					</td>
					
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>所属行业：
					</td>
					<td>
						<form:select path="scrIndustry" class="input-large editFormSelectWidth required ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('COMPANY_REQ_INDUSTRY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>内容与说明：
					</td>
					<td colspan="5">
						<form:textarea path="scrContent" htmlEscape="false" rows="3" maxlength="2000" class="input-xxlarge editFormSelectWidth required"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						市场前景(方向)：
					</td>
					<td colspan="5">
						<form:textarea path="scrMarket" htmlEscape="false" rows="3" maxlength="2000" class="input-xxlarge editFormSelectWidth"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作方式：
					</td>
					<td>
						<form:select path="scrCoopMethod" class="input-large editFormSelectWidth required ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('COMPANY_REQ_COOP_METHOD')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>

					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>企业名称：
					</td>
					<td>
						<form:input path="scrCompanyName" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>联系人：
					</td>
					<td>
						<form:input path="scrCompanyContact" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
					</td>
					

				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>联系电话：
					</td>
					<td>
						<form:input path="scrCompanyPhone" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>电子邮箱：
					</td>
					<td>
						<form:input path="scrCompanyEmail" htmlEscape="false" maxlength="100" class="input-large required editFormFieldWidth"/>
					</td>
					<td class="tit">
						失效日期：
					</td>
					<td>
						<input name="scrExpiryDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate editFormFieldWidth"
							value="<fmt:formatDate value="${schCompReq.scrExpiryDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						文件：
					</td>
					<td colspan="5">
						<form:hidden id="scrFiles" path="scrFiles" htmlEscape="false" maxlength="2000" class="input-large editFormFieldWidth"/>
						<sys:ckfinder input="scrFiles" type="files" uploadPath="/company_req" selectMultiple="true"/>
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="sch:req:schCompReq:edit">
				<c:if test="${schCompReq.scrStatus==1 || empty schCompReq.id}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存草稿"/>&nbsp;
				</c:if>
					<input id="btnSubmit2" class="btn btn-primary" type="submit" value="提交申报" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${schCompReq.scrStatus==1 || empty schCompReq.id}">
					<input id="btnAdd" class="btn btn-primary" type="button" value="新 增" onClick="location.href='${ctx}/sch/req/schCompReq/form'"/>&nbsp;
				</c:if>
				<c:if test="${not empty schCompReq.id && not empty schCompReq.act.procInsId}">
					<input id="btnSubmit3" class="btn btn-inverse" type="submit" value="取消申报" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<c:if test="${not empty schComConcract.act.procInsId}">
			<act:histoicFlow procInsId="${schComConcract.act.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>