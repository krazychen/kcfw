<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>发明专利管理</title>
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
		<li class="active"><a href="#">${schPatentUnder.act.taskName}<shiro:lacksPermission name="sch:patent:schPatentUnder:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schPatentUnder" action="${ctx}/sch/patent/schPatentUnder/saveAudit" method="post" class="form-horizontal">
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
					<td class="tit" ><span class="help-inline"><font color="red">*</font> </span>专利名称：</td>
					<td colspan="3">
						${schPatentUnder.spuName}
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利类型：</td>
					<td>
						${fns:getDictLabel(schPatentUnder.spuTypeCode, 'PATENT_TYPE', '')}
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利申请人：</td>
					<td>
						${schPatentUnder.spuApplySchoolName}
					</td>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>联络人：</td>
					<td>
						${schPatentUnder.spuApplyUserName}					
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>所属院系：</td>
					<td>
						${schPatentUnder.spuApplyUserOfficeName}
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>联系电话：</td>
					<td>
						${schPatentUnder.spuApplyPhone}
					</td>
				<c:if test="${schPatentUnder.spuAdvisTeacherName ne null || schPatentUnder.spuAdvisTeacherName ne ''}" >
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>指导老师：</td>
					<td>
						${schPatentUnder.spuAdvisTeacherName}					
					</td>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>老师所属院系：</td>
					<td>
						${schPatentUnder.spuAdvisTeacherOfficeName}			
					</td>
				</tr>
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利代理机构：</td>
					<td>
						${schPatentUnder.spuProxyName}	
					</td>
					<td colspan="3">
						<span id="spuProxyInfo"><c:if test="${not empty schPatentUnder.spuProxyId }">&nbsp;&nbsp;&nbsp;&nbsp;代理机构联系人:${schPatentUnder.spuProxyContact }&nbsp;&nbsp;&nbsp;&nbsp;代理机构联系方式：${schPatentUnder.spuProxyPhone }</c:if></span>
					</td>
				</tr>
				</c:if>
				
				<c:if test="${schPatentUnder.spuAdvisTeacherName eq null || schPatentUnder.spuAdvisTeacherName eq ''}" >
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利代理机构：</td>
					<td>
						${schPatentUnder.spuProxyName}	
					</td>
					<td colspan="2">
						<span id="spuProxyInfo"><c:if test="${not empty schPatentUnder.spuProxyId }">&nbsp;&nbsp;&nbsp;&nbsp;代理机构联系人:${schPatentUnder.spuProxyContact }&nbsp;&nbsp;&nbsp;&nbsp;代理机构联系方式：${schPatentUnder.spuProxyPhone }</c:if></span>
					</td>
				</tr>
				</c:if>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利摘要：</td>
					<td colspan="5">
						${schPatentUnder.spuRemark}	
					</td>
				</tr>
	
				<tr>
					<td colspan="6"><h5 id="inventInfo" name="inventInfo">发明人信息</h5></td>
				</tr>
				<tr>
					<td colspan="6">
						<table id="contentTable" class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th class="hide"></th>
									<th><span class="help-inline"><font color="red">*</font> </span>发明人类型</th>
									<th><span class="help-inline"><font color="red">*</font> </span>发明人姓名</th>
									<th><span class="help-inline"><font color="red">*</font> </span>发明人单位</th>
									<th><span class="help-inline"><font color="red">*</font> </span>贡献度(%)</th>
									<th>备注</th>
								</tr>
							</thead>
							<tbody id="schPatentUnderInventorList">
								<c:forEach items="${schPatentUnder.schPatentUnderInventorList}" var="inventor">
									<tr>
										<td class="hide">
											${inventor.id}
										</td>
										<td>${inventor.spiTypeName}</td>
										<td>${inventor.spiUserName}${inventor.spiTeacherName}${inventor.spiUserNameEX}</td>
										<td>${inventor.spiUserOfficeName}${inventor.spiTeacherOfficeName}${inventor.spiOfficeNameEx}</td>
										<td>${inventor.spiContributionPer}</td>
										<td>${inventor.spiRemark}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</td>
				</tr>	
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>您的审批意见</td>
					<td colspan="5">
						<form:textarea path="act.comment" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000"/>
					</td>
				</tr>
			</table>
		</fieldset>


		<div class="form-actions">
			<shiro:hasPermission name="sch:patent:schPatentUnder:edit">
				<c:if test="${schPatentUnder.act.taskDefKey ne 'apply_end'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意" onclick="$('#flag').val('yes')"/>&nbsp;
					<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>			
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<c:if test="${not empty schPatentUnder.id}">
			<act:histoicFlow procInsId="${schPatentUnder.act.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>