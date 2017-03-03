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
					stcMoney: {
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
					if($("#stcMoney").val()<1000){
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
			var type=$("#stcResearchType").find("option:selected").val();  
			$.ajax({
				type: "POST",
				url: "${ctx}/sch/contract/schTechConcract/getResTypeSub",
				data: { //发送给数据库的数据
					type: type
			},
			dataType: 'json',
			success: function(data) {
				$("#stcResearchTypeSub").empty();
				$("#stcResearchTypeSub").append("<option class='required' value=''> </option>")
				$.each(data, function(index,item){
					$("#stcResearchTypeSub").append("<option class='required' value='"+item.value+"'>"+item.label+"</option>")
				});
			}
			})
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sch/contract/schTechConcract/">合同列表</a></li>
		<li class="active"><a href="${ctx}/sch/contract/schTechConcract/form?id=${schTechConcract.id}">合同<shiro:hasPermission name="sch:contract:schTechConcract:edit">${not empty schTechConcract.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:contract:schTechConcract:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="schTechConcract" action="${ctx}/sch/contract/schTechConcract/saveSuper" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<form:hidden path="stcNo"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<table class="table-form">	
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同名称：
					</td>
					<td colspan="3">
						<form:input path="stcName" htmlEscape="false" maxlength="64" class="input-large editForm2ColWidth required"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同类别：
					</td>
					<td>
						<form:select path="stcType" class="input-large editFormSelectWidth required">
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
						<form:select path="stcIndustry" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_INDUSTRY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>研究方向：
					</td>
					<td>
						<form:select path="stcResearchType" onchange="getResTypeSub()" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('CONTRACT_RESEARCH_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>组织形式：
					</td>
					<td>
						<form:select path="stcResearchTypeSub" class="input-large editFormSelectWidth required">
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
						<sys:treeselect id="sccResponseUserId" name="stcResponseUserId" value="${schTechConcract.stcResponseUserId!=null ? schTechConcract.stcResponseUserId : fns:getUser().getId()}" labelName="stcResponseUserName" labelValue="${schTechConcract.stcResponseUserName!=null ? schTechConcract.stcResponseUserName : fns:getUser().getName()}"
							title="用户" allowInput="true" url="/sys/office/treeData?type=3" cssClass="input-large required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>负责人所属院系：
					</td>
					<td>
						<!-- 
						<sys:treeselect id="stcResponseOfficeId" name="stcResponseOfficeId" value="${schTechConcract.stcResponseOfficeId}" labelName="stcResponseOfficeName" labelValue="${schTechConcract.stcResponseOfficeName}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="input-medium required" allowClear="true" notAllowSelectParent="true"/>
						 -->
						<form:hidden path="stcResponseOfficeId" value="${schTechConcract.stcResponseOfficeId!=null ? schTechConcract.stcResponseOfficeId : fns:getUser().getOffice().getId()}"/>
						<form:input path="stcResponseOfficeName" value="${schTechConcract.stcResponseOfficeName!=null ? schTechConcract.stcResponseOfficeName : fns:getUser().getOffice().getName()}" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" /> 
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合同金额（元）：
					</td>
					<td>
						<form:input path="stcMoney" htmlEscape="false" maxlength="13" class="input-large editFormFieldWidth required"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业名称：
					</td>
					<td>
						<form:input path="stcCompanyName" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业地区：
					</td>
					<td>
						<sys:treeselect id="stcCompanyArea" name="stcCompanyArea" value="${schTechConcract.stcCompanyArea}" labelName="stcCompanyAreaName" labelValue="${schTechConcract.stcCompanyAreaName}"
							title="区域" url="/sys/area/treeData" cssClass="input-large required" allowClear="true" notAllowSelectParent="false" showParent="true"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>合作企业类别：
					</td>
					<td>
						<form:select path="stcCompanyType" class="input-large editFormSelectWidth required">
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
						<input name="stcSubmitDate" type="text" readonly="readonly" maxlength="20" class="input-large editFormFieldWidth Wdate required"
							value="<fmt:formatDate value="${schTechConcract.stcSubmitDate}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</td>
				</tr>
				<tr>
					<td class="tit">
						合同附件：
					</td>
					<td colspan="5">
						<form:hidden id="stcFiles" path="stcFiles" htmlEscape="false" maxlength="1000" class="input-large"/>
						<sys:ckfinder input="stcFiles" type="files" uploadPath="/tech_concract_file" selectMultiple="true"/>
					</td>
				</tr>
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>院系秘书审批意见</td>
					<td colspan="5">
						<form:textarea path="stcTeachComment" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000" />
					</td>
				</tr>
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>科研负责人审批意见</td>
					<td colspan="5">
						<form:textarea path="stcRespComment" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000" />
					</td>
				</tr>
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>合同管理员审批意见</td>
					<td colspan="5">
						<form:textarea path="stcManaComment" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000" />
					</td>
				</tr>
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>副处长/处长审批意见</td>
					<td colspan="5">
						<form:textarea path="stcFinalComment" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000" />
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="sch:contract:schTechConcract:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<c:if test="${not empty schTechConcract.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schTechConcract.act.procInsId}" />
		</c:if>
		
		<c:if test="${empty schTechConcract.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schTechConcract.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>