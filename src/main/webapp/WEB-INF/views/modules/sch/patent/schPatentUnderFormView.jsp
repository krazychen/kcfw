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
					var ils=$("tr[id^=schPatentUnderInventorList]");
					if(ils.length==0){
						alert("请填写发明人信息！");	
						return
					}else{
						var persum=0;
						for(var i=0;i<ils.length;i++){
							var per=ils.find("#schPatentUnderInventorList"+i+"_spiContributionPer").val();
							persum=parseInt(persum)+parseInt(per);
						}
						if(parseInt(persum)!=100){
							alert("发明人贡献度总和必须等于100%，请调整！");	
						}
					}
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
		<li><a href="${ctx}/sch/patent/schPatentUnder/">专利申报列表</a></li>
		<li class="active"><a href="${ctx}/sch/patent/schPatentUnder/form?id=${schPatentUnder.id}">专利申报详情</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schPatentUnder" action="${ctx}/sch/patent/schPatentUnder/save" method="post" class="form-horizontal">
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
									<th><span class="help-inline"><font color="red">*</font> </span>排名</th>
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
										<td>${inventor.spiNo}</td>
										<td>${inventor.spiRemark}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</td>
				</tr>	
			</table>
		</fieldset>
		
		<c:if test="${not empty schPatentUnder.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schPatentUnder.act.procInsId}" />
		</c:if>
		
		<c:if test="${empty schPatentUnder.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schPatentUnder.procInsId}" />
		</c:if>


		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
	</form:form>
</body>
</html>