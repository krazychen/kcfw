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
		<li class="active"><a href="${ctx}/sch/contract/schTechConcract/form?id=${schTechConcract.id}">合同详情</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schTechConcract" action="${ctx}/sch/contract/schTechConcract/saveAudit" method="post" class="form-horizontal">
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
						<span class="help-inline"><font color="red">*</font> </span>合同名称：
					</td>
					<td>
						${schTechConcract.stcName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同类别：
					</td>
					<td>
						${fns:getDictLabel(schTechConcract.stcType, 'PATENT_TYPE', '')}
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>所属行业：
					</td>
					<td>
						${fns:getDictLabel(schTechConcract.stcIndustry, 'CONTRACT_INDUSTRY', '')}
					</td>
					
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>研究方向：
					</td>
					<td>
						${fns:getDictLabel(schTechConcract.stcResearchType, 'CONTRACT_RESEARCH_TYPE', '')}
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>研究方向子目：
					</td>
					<td>
						${resTypeSub}
					</td>
					
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人：
					</td>
					<td>
						${schTechConcract.stcResponseUserName }
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人所属院系：
					</td>
					<td>
						${schTechConcract.stcResponseOfficeName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业名称：
					</td>
					<td>
						${schTechConcract.stcCompanyName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业地区：
					</td>
					<td>
						${schTechConcract.stcCompanyAreaName }
					</td>
				</tr>
				<td class="tit">
					<span class="help-inline"><font color="red">*</font> </span>合同金额（元）：
				</td>
				<td>
					${schTechConcract.stcMoney }
				</td>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业类别：
					</td>
					<td>
						${fns:getDictLabel(schTechConcract.stcCompanyType, 'CONTRACT_COMPANY_TYPE', '')}
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同签订日期：
					</td>
					<td>
						<fmt:formatDate value="${schTechConcract.stcSubmitDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						合同附件：
					</td>
					<td colspan="5">
						<form:hidden id="stcFiles" path="stcFiles" htmlEscape="false" maxlength="1000" class="input-large"/>
						<sys:ckfinder input="stcFiles" type="files" uploadPath="/tech_concract_file" selectMultiple="true" readonly="true"/>
					</td>
				</tr>
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>您的审批意见</td>
					<td colspan="5">
						<form:textarea path="act.comment" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000" />
					</td>
				</tr>
			</table>
		</fieldset>
		
		<div class="form-actions">
			<shiro:hasPermission name="sch:contract:schTechConcract:edit">
				<c:if test="${schTechConcract.act.taskDefKey ne 'apply_end'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意" onclick="$('#flag').val('yes')"/>&nbsp;
					<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>			
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<c:if test="${not empty schTechConcract.id}">
			</br>
			<act:histoicFlow procInsId="${schTechConcract.act.procInsId}" />
		</c:if>

	</form:form>
</body>
</html>