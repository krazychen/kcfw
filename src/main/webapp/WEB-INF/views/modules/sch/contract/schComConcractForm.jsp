<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合同管理</title>
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
		<li><a href="${ctx}/sch/contract/schComConcract/">合同列表</a></li>
		<li class="active"><a href="${ctx}/sch/contract/schComConcract/form?id=${schComConcract.id}">合同<shiro:hasPermission name="sch:contract:schComConcract:edit">${not empty schComConcract.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:contract:schComConcract:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schComConcract" action="${ctx}/sch/contract/schComConcract/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<table class="table-form">	
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同名称：
					</td>
					<td>
						<form:input path="sccName" htmlEscape="false" maxlength="64" class="input-large required"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同类别：
					</td>
					<td>
						<form:select path="sccType" class="input-large required" style="width:223px">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>所属行业：
					</td>
					<td>
						<form:select path="sccIndustry" class="input-large required" style="width:223px">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_INDUSTRY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>研究方向：
					</td>
					<td>
						<form:select path="sccResearchType" class="input-large required" style="width:223px">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_RESEARCH_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>研究方向子目：
					</td>
					<td>
						<form:select path="sccResearchTypeSub" class="input-large required" style="width:223px">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_RESEARCH_TYPE_SUB1')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人：
					</td>
					<td>
						<sys:treeselect id="sccResponseUserId" name="sccResponseUserId" value="${schComConcract.sccResponseUserId}" labelName="sccResponseUserName" labelValue="${schComConcract.sccResponseUserName}"
							title="用户" url="/sys/office/treeData?type=3" cssClass="input-medium required" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人所属院系：
					</td>
					<td>
						<sys:treeselect id="sccResponseOfficeId" name="sccResponseOfficeId" value="${schComConcract.sccResponseOfficeId}" labelName="sccResponseOfficeName" labelValue="${schComConcract.sccResponseOfficeName}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="input-medium required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业名称：
					</td>
					<td>
						<form:input path="sccCompanyName" htmlEscape="false" maxlength="64" class="input-large required"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业地区：
					</td>
					<td>
						<sys:treeselect id="sccCompanyArea" name="sccCompanyArea" value="${schComConcract.sccCompanyArea}" labelName="sccCompanyAreaName" labelValue="${schComConcract.sccCompanyAreaName}"
							title="区域" url="/sys/area/treeData" cssClass="input-medium required" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业类别：
					</td>
					<td>
						<form:select path="sccCompanyType" class="input-large required" style="width:223px">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_COMPANY_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同签订日期：
					</td>
					<td>
						<input name="sccSubmitDate" type="text" readonly="readonly" maxlength="20" class="input-large Wdate required"
							value="<fmt:formatDate value="${schComConcract.sccSubmitDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					</td>
					<td class="tit">
					</td><td></td>
				</tr>
				<tr>
					<td class="tit">
						合同附件：
					</td>
					<td colspan="5">
						<form:hidden id="sccFiles" path="sccFiles" htmlEscape="false" maxlength="1000" class="input-large"/>
						<sys:ckfinder input="sccFiles" type="files" uploadPath="/concract_file" selectMultiple="true"/>
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="sch:contract:schComConcract:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<input id="btnAdd" class="btn btn-primary" type="button" value="新 增" onClick="location.href='${ctx}/sch/contract/schComConcract/form'"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>