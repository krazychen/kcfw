<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>科研资源查看</title>
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
		<li class="active"><a href="${ctx}/sch/res/schTechResourceApply/form?id=${schTechResourceApply.id}">科研资源申请查看</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schTechResourceApply" action="${ctx}/sch/res/schTechResourceApply/save" method="post" class="form-horizontal">
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
						<span class="help-inline"><font color="red">*</font> </span>资产名称：
					</td>
					<td colspan="3">
						${schTechResource.strName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>资产分类代码：
					</td>
					<td>
						${fns:getDictLabel(schTechResource.strTypeCode, 'TECH_RESOURCE_TYPE', '')}
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>资产编号：
					</td>
					<td>
						${schTechResource.strCode }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>计量单位：
					</td>
					<td>
						${schTechResource.strUnit }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>数量/面积：
					</td>
					<td>
						${schTechResource.strPices }
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>品牌/规格型号：
					</td>
					<td>
						${schTechResource.strBrand }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>单价/均价：
					</td>
					<td>
						${schTechResource.strPrice }
					</td>
					<td class="tit">
						费用：
					</td>
					<td>
						${schTechResource.strCosts }
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>取得日期：
					</td>
					<td>
						<fmt:formatDate value="${schTechResource.strCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人：
					</td>
					<td>
						${schTechResource.strUserName }
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>所属部门：
					</td>
					<td>
						${schTechResource.strOfficeName }
					</td>
				</tr>
				<tr>
					<td class="tit">
						申请人
					</td>
					<td>
						${schTechResourceApply.scaApplyUserName }
					</td>
					<td class="tit">
						申请使用日期
					</td>
					<td>
						${schTechResourceApply.scaApplyDate }
					</td>
					<td class="tit">
						申请使用时间段
					</td>
					<td>
						${schTechResourceApply.scaApplyTimeRange }
					</td>
				</tr>
			</table>
		</fieldset>
		
		<c:if test="${not empty schTechResourceApply.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schTechResourceApply.act.procInsId}" />
		</c:if>
		
		<c:if test="${empty schTechResourceApply.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schTechResourceApply.procInsId}" />
		</c:if>
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>