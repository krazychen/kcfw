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
				rules: {
					sccMoney: {
		                required: true,
		                number: true
		            }
		        },
		        messages: {
		        	rules: {
		                required: "必填信息",
		                number: "请输入数字"
		            }
		        },
				submitHandler: function(form){
					
					if($("#sccMoney").val()<1000){
						top.$.jBox.confirm("合同金额小于1000，确定保存合同吗？","系统提示",function(v,h,f){
							if(v=="ok"){
								loading('正在提交，请稍等...');
								form.submit();
							}
						},{buttonsFocus:1});
						top.$('.jbox-body .jbox-icon').css('top','55px');
					}else{
						loading('正在提交，请稍等...');
						form.submit();
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
		
		function getResTypeSub(){
			var type=$("#sccResearchType").find("option:selected").val();  
			$.ajax({
				type: "POST",
				url: "${ctx}/sch/contract/schComConcract/getResTypeSub",
				data: { //发送给数据库的数据
					type: type
			},
			dataType: 'json',
			success: function(data) {
				$("#sccResearchTypeSub").empty();
				$("#sccResearchTypeSub").append("<option class='required' value=''> </option>")
				$.each(data, function(index,item){
					$("#sccResearchTypeSub").append("<option class='required' value='"+item.value+"'>"+item.label+"</option>")
				});
			}
			})
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sch/contract/schComConcract/">合同列表</a></li>
		<li class="active"><a href="${ctx}/sch/contract/schComConcract/form?id=${schComConcract.id}">合同<shiro:hasPermission name="sch:contract:schComConcract:edit">${not empty schComConcract.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:contract:schComConcract:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schComConcract" action="${ctx}/sch/contract/schComConcract/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<form:hidden path="sccNo"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<table class="table-form">	
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同名称：
					</td>
					<td colspan="3">
						<form:input path="sccName" htmlEscape="false" maxlength="64" class="input-large editForm2ColWidth required"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同类别：
					</td>
					<td>
						<form:select path="sccType" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>	
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>所属行业：
					</td>
					<td>
						<form:select path="sccIndustry" class="input-large editFormSelectWidth required" >
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_INDUSTRY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>学科分类：
					</td>
					<td>
						<form:select path="sccResearchType" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_RESEARCH_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作形式：
					</td>
					<td>
						<form:select path="sccResearchTypeSub" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_ORGANIZATION_FORM')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人：
					</td>
					<td>
						<sys:treeselect id="sccResponseUserId" name="sccResponseUserId" value="${schComConcract.sccResponseUserId!=null ? schComConcract.sccResponseUserId : fns:getUser().getId()}" labelName="sccResponseUserName" labelValue="${schComConcract.sccResponseUserName!=null ? schComConcract.sccResponseUserName : fns:getUser().getName()}"
							title="用户" allowInput="true" url="/sys/office/treeData?type=3" cssClass="input-large editFormTreeWidth required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人所属院系：
					</td>
					<td>
						<!--
						<sys:treeselect id="sccResponseOfficeId" name="sccResponseOfficeId" value="${schComConcract.sccResponseOfficeId}" labelName="sccResponseOfficeName" labelValue="${schComConcract.sccResponseOfficeName}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="input-medium required" allowClear="true" notAllowSelectParent="true"/>
						-->
						<form:hidden path="sccResponseOfficeId" value="${schComConcract.sccResponseOfficeId!=null ? schComConcract.sccResponseOfficeId : fns:getUser().getOffice().getId()}"/>
						<form:input path="sccResponseOfficeName" value="${schComConcract.sccResponseOfficeName!=null ? schComConcract.sccResponseOfficeName : fns:getUser().getOffice().getName()}" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" />
						
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同金额（元）：
					</td>
					<td>
						<form:input path="sccMoney" htmlEscape="false" maxlength="13" class="input-large editFormFieldWidth required"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业名称：
					</td>
					<td>
						<form:input path="sccCompanyName" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业地区：
					</td>
					<td>
						<sys:treeselect id="sccCompanyArea" name="sccCompanyArea" value="${schComConcract.sccCompanyArea}" labelName="sccCompanyAreaName" labelValue="${schComConcract.sccCompanyAreaName}"
							title="区域" allowInput="true" url="/sys/area/treeData" cssClass="input-large editFormTreeWidth required" allowClear="true" notAllowSelectParent="false" showParent="true"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业类别：
					</td>
					<td>
						<form:select path="sccCompanyType" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_COMPANY_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同签订日期：
					</td>
					<td>
						<input name="sccSubmitDate" type="text" readonly="readonly" maxlength="20" class="input-large editFormFieldWidth Wdate required"
							value="<fmt:formatDate value="${schComConcract.sccSubmitDate}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						合同附件：
					</td>
					<td colspan="5">
						<form:hidden id="sccFiles" path="sccFiles" htmlEscape="false" maxlength="1000" class="input-large"/>
						<sys:ckfinder input="sccFiles" type="files" uploadPath="/com_concract_file" selectMultiple="true"/>
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="sch:contract:schComConcract:edit">
				<c:if test="${schComConcract.sccStatus==1 || empty schComConcract.id}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存草稿"/>&nbsp;
				</c:if>
					<input id="btnSubmit2" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${schComConcract.sccStatus==1 || empty schComConcract.id}">
					<input id="btnAdd" class="btn btn-primary" type="button" value="新 增" onClick="location.href='${ctx}/sch/contract/schComConcract/form'"/>&nbsp;
				</c:if>
				<c:if test="${not empty schComConcract.id && not empty schComConcract.act.procInsId}">
					<input id="btnSubmit3" class="btn btn-inverse" type="submit" value="取消申请" onclick="$('#flag').val('no')"/>&nbsp;
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