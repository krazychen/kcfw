<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>科研资源维护</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
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
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sch/res/schTechResource/">科研资源列表</a></li>
		<li class="active"><a href="${ctx}/sch/res/schTechResource/form?id=${schTechResource.id}">科研资源<shiro:hasPermission name="sch:res:schTechResource:edit">${not empty schTechResource.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:res:schTechResource:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schTechResource" action="${ctx}/sch/res/schTechResource/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<table class="table-form">	
						<tr>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>资产名称：
							</td>
							<td colspan="3">
								<form:input path="strName" htmlEscape="false" maxlength="200" class="input-large editForm2ColWidth required"/>
							</td>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>资产分类代码：
							</td>
							<td>
								<form:select path="strTypeCode" class="input-large editFormSelectWidth required">
									<form:option value="" label=""/>
									<form:options items="${fns:getDictList('TECH_RESOURCE_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</td>
						</tr>
						<tr>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>资产编号：
							</td>
							<td>
								<form:input path="strCode" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
							</td>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>计量单位：
							</td>
							<td>
								<form:input path="strUnit" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
							</td>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>数量/面积：
							</td>
							<td>
								<form:input path="strPices" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
							</td>
						</tr>
						<tr>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>品牌/规格型号：
							</td>
							<td>
								<form:input path="strBrand" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
							</td>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>单价/均价：
							</td>
							<td>
								<form:input path="strPrice" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" />
							</td>
							<td class="tit">
								费用：
							</td>
							<td>
								<form:input path="strCosts" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth "/>
							</td>
						</tr>
						<tr>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>取得日期：
							</td>
							<td>
								<input name="strCreateDate" type="text" readonly="readonly" maxlength="20" class="input-large editFormFieldWidth Wdate required"
									value="<fmt:formatDate value="${schTechResource.strCreateDate}" type="date" pattern="yyyy-MM-dd"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>负责人：
							</td>
							<td>
								<sys:treeselect id="strUserId" name="strUserId" value="${schTechResource.strUserId!=null ? schTechResource.strUserId : fns:getUser().getId()}" labelName="strUserName" labelValue="${schTechResource.strUserName!=null ? schTechResource.strUserName : fns:getUser().getName()}"
							title="用户" allowInput="true" url="/sys/office/treeData?type=3" cssClass="input-large editFormSelectWidth required" allowClear="true" notAllowSelectParent="true"/>
							</td>
							<td class="tit">
								<span class="help-inline"><font color="red">*</font> </span>所属部门：
							</td>
							<td>
								<form:hidden path="strOfficeId" value="${schTechResource.strOfficeId!=null ? schTechResource.strOfficeId : fns:getUser().getOffice().getId()}"/>
								<form:input path="strOfficeName" value="${schTechResource.strOfficeName!=null ? schTechResource.strOfficeName : fns:getUser().getOffice().getName()}" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" />
							</td>
						</tr>
						<tr>
							<td class="tit">
								联系电话：
							</td>
							<td>
								<form:input path="strPhone" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth "/>
							</td>
						</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="sch:res:schTechResource:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<input id="btnAdd" class="btn btn-primary" type="button" value="新 增" onClick="location.href='${ctx}/sch/res/schTechResource/form'"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>