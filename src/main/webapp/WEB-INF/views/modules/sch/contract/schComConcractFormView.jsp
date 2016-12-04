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
		<li class="active"><a href="${ctx}/sch/contract/schComConcract/form?id=${schComConcract.id}">合同详情</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schComConcract" action="${ctx}/sch/contract/schComConcract/save" method="post" class="form-horizontal">
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
					<td colspan="3">
						${schComConcract.sccName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同类别：
					</td>
					<td>
						${fns:getDictLabel(schComConcract.sccType, 'PATENT_TYPE', '')}
					</td>
					
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>所属行业：
					</td>
					<td>
						${fns:getDictLabel(schComConcract.sccIndustry, 'CONTRACT_INDUSTRY', '')}
					</td>
					
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>研究方向：
					</td>
					<td>
						${fns:getDictLabel(schComConcract.sccResearchType, 'CONTRACT_RESEARCH_TYPE', '')}
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>研究方向子目：
					</td>
					<td>
						${resTypeSub}
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人：
					</td>
					<td>
						${schComConcract.sccResponseUserName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人所属院系：
					</td>
					<td>
						${schComConcract.sccResponseOfficeName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同金额：
					</td>
					<td>
						${schComConcract.sccMoney }
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业名称：
					</td>
					<td>
						${schComConcract.sccCompanyName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业地区：
					</td>
					<td>
						${schComConcract.sccCompanyAreaName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业类别：
					</td>
					<td>
						${fns:getDictLabel(schComConcract.sccCompanyType, 'CONTRACT_COMPANY_TYPE', '')}
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同签订日期：
					</td>
					<td>
						<fmt:formatDate value="${schComConcract.sccSubmitDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						合同附件：
					</td>
					<td colspan="5">
						<form:hidden id="sccFiles" path="sccFiles" htmlEscape="false" maxlength="1000" class="input-large"/>
						<sys:ckfinder input="sccFiles" type="files" uploadPath="/com_concract_file" selectMultiple="true" readonly="true"/>
					</td>
				</tr>
			</table>
		</fieldset>
		
		<c:if test="${not empty schComConcract.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schComConcract.act.procInsId}" />
		</c:if>
		
		<c:if test="${empty schComConcract.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schComConcract.procInsId}" />
		</c:if>

		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>