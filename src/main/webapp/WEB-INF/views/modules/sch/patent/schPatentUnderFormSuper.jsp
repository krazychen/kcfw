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
						return;
					}else{
						var persum=0;
						for(var i=0;i<ils.length;i++){
							var per=ils.find("#schPatentUnderInventorList"+i+"_spiContributionPer").val();
							persum=parseInt(persum)+parseInt(per);
						}
						if(parseInt(persum)!=100){
							alert("发明人贡献度总和必须等于100%，请调整！");	
							return;
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
			
			$("#spuTypeCode").change(function(){
				$("#spuTypeName").val($(this).children('option:selected').text());
			});
			$("#spuProxyId").change(function(){
				var pv=$(this).children('option:selected').val();
				if(pv){
					$("#spuProxyInfo").show();
					$.ajax({
						type: "POST",
						url: "${ctx}/sch/patent/schPatentUnder/getSpaProxyInfo",
						data: { //发送给数据库的数据
							code: pv
					},
					dataType: 'json',
					success: function(data) {
						$("#spuProxyInfo").html("&nbsp;&nbsp;&nbsp;&nbsp;联系人:"+data.spaContacts+"&nbsp;&nbsp;&nbsp;&nbsp;联系方式:"+data.spaPhone);
					}
					})
				}else{
					$("#spuProxyInfo").hide();
				}
			});
			if($("[id='act.taskId']").val()){
				$("#listli").hide();
			}

		});
		function spuApplyUserIdTreeselectCallBack(v,h,f){
			if (v=="ok"){
				var userId=$("#spuApplyUserIdId").val();
				if(userId){
					setOffice(userId,"spuApplyUserOfficeId","spuApplyUserOfficeName");
				}
				
			}else if (v=="clear"){
				$("#spuApplyUserOfficeId").val("");
				$("#spuApplyUserOfficeName").val("");
			}
		}
		
		function spuAdvisTeacherIdTreeselectCallBack(v,h,f){
			if (v=="ok"){
				var userId=$("#spuAdvisTeacherIdId").val();
				if(userId){
					setOffice(userId,"spuAdvisTeacherOfficeId","spuAdvisTeacherOfficeName");
				}
				
			}else if (v=="clear"){
				$("#spuAdvisTeacherOfficeId").val("");
				$("#spuAdvisTeacherOfficeName").val("");
			}
		}
		
		function setOffice(userId,code,name){
			$.ajax({
				type: "POST",
				url: "${ctx}/sys/user/infoDataById",
				data: { //发送给数据库的数据
					id: userId
			},
			dataType: 'json',
			success: function(data) {
					$("#"+code).val(data.id);
					$("#"+name).val(data.name);
				}
			})
		}
		
		function addRow(list, idx, tpl, row){
			var userIdName='schPatentUnderInventorList'+idx+'_spiUserNo';
			window[userIdName+'TreeselectCallBack'] = function (v,h,f) { 
				if (v=="ok"){
					var userId=$("#"+userIdName+"Id").val();
					if(userId){
						setOffice(userId,'schPatentUnderInventorList'+idx+'_spiUserOfficeId','schPatentUnderInventorList'+idx+'_spiUserOfficeName');
						$('#schPatentUnderInventorList'+idx+'_spiUserId').val(userId);
					}
					
				}else if (v=="clear"){
					$("#"+"schPatentUnderInventorList"+idx+"_spiUserOfficeId").val("");
					$("#"+"schPatentUnderInventorList"+idx+"_spiUserOfficeName").val("");
				}
			};
			var teacherIdName='schPatentUnderInventorList'+idx+'_spiTeacherNo';
			window[teacherIdName+'TreeselectCallBack'] = function (v,h,f) { 
				if (v=="ok"){
					var teacherId=$("#"+teacherIdName+"Id").val();
					if(teacherId){
						setOffice(teacherId,'schPatentUnderInventorList'+idx+'_spiTeacherOfficeId','schPatentUnderInventorList'+idx+'_spiTeacherOfficeName');
						$('#schPatentUnderInventorList'+idx+'_spiTeacherId').val(teacherId);
					}
					
				}else if (v=="clear"){
					$("#"+"schPatentUnderInventorList"+idx+"_spiTeacherOfficeId").val("");
					$("#"+"schPatentUnderInventorList"+idx+"_spiTeacherOfficeName").val("");
				}
			};
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
				$(this).change();
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
			
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
		function changeInvType(obj, prefix,row){
			//alert($(obj).children('option:selected').text());
			if($(obj).children('option:selected').text()=='校外'){
			//	var html='<input id="schPatentUnderInventorList{{idx}}_spiUserId" name="schPatentUnderInventorList{{idx}}_spiUserId" type="text" value="{{row.spiUserId}}" maxlength="11" class="input-small required"/>';
			 	//alert($(prefix+"_spiUserNameEx").html());	 
			//$(prefix+"_spiUserId").hide();
				//$(obj).parent().next().children().eq(0).hide();
				//$(obj).parent().next().children().eq(1).hide();
				// $(prefix+"_spiUserNameEx").show();
				// $(obj).parent().next().next().children().eq(0).hide();
				 //$(prefix+"_spiOfficeNameEx").show();
				$(prefix+"_spiUserIdTd").hide();
				$(prefix+"_spiUserNameTd").hide();
				$(prefix+"_spiTeacherIdTd").hide();
				$(prefix+"_spiTeacherNameTd").hide();
				$(prefix+"_spiUserNameExTd").show();
				$(prefix+"_spiUserIdExTd").show();
				$(prefix+"_spiUserOfficeIdTd").hide();
				$(prefix+"_spiTeacherOfficeIdTd").hide();
				$(prefix+"_spiOfficeNameExTd").show();
			}else if ($(obj).children('option:selected').text()=='老师'){
				//$(obj).parent().next().children().eq(0).hide();
				//$(obj).parent().next().children().eq(1).show();
				//$(prefix+"_spiTeacherIdName").show()
				//$(prefix+"_spiTeacherIdButton").css('display', 'initial');
				//$(prefix+"_spiTeacherIdButton").show();
				 //$(prefix+"_spiUserNameEx").hide();
				$(prefix+"_spiUserIdTd").hide();
				$(prefix+"_spiUserNameTd").hide();
				$(prefix+"_spiTeacherIdTd").show();
				$(prefix+"_spiTeacherNameTd").show();
				$(prefix+"_spiUserNameExTd").hide();
				$(prefix+"_spiUserIdExTd").hide();
				$(prefix+"_spiUserOfficeIdTd").hide();
				$(prefix+"_spiTeacherOfficeIdTd").show();
				$(prefix+"_spiOfficeNameExTd").hide();
				 //$(obj).parent().next().next().children().eq(0).show();
				// $(prefix+"_spiOfficeNameEx").hide();
			}else {
				//$(obj).parent().next().children().eq(0).show();
				//$(obj).parent().next().children().eq(1).hide();
				// $(prefix+"_spiUserNameEx").hide();
				$(prefix+"_spiUserIdTd").show();
				$(prefix+"_spiUserNameTd").show();
				$(prefix+"_spiTeacherIdTd").hide();
				$(prefix+"_spiTeacherNameTd").hide();
				$(prefix+"_spiUserNameExTd").hide();
				$(prefix+"_spiUserIdExTd").hide();
				$(prefix+"_spiUserOfficeIdTd").show();
				$(prefix+"_spiTeacherOfficeIdTd").hide();
				$(prefix+"_spiOfficeNameExTd").hide();
				// $(obj).parent().next().next().children().eq(0).show();
				// $(prefix+"_spiOfficeNameEx").hide();
			}
			//$(obj).parent().next().children().hide();
			//$(obj).parent().next().children().append(html);
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li id="listli"><a href="${ctx}/sch/patent/schPatentUnder/">专利申报列表</a></li>
		<li class="active"><a href="${ctx}/sch/patent/schPatentUnder/form?id=${schPatentUnder.id}">专利申报<shiro:hasPermission name="sch:patent:schPatentUnder:edit">${not empty schPatentUnder.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:patent:schPatentUnder:edit">查看</shiro:lacksPermission></a></li>
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
						<form:input path="spuName" htmlEscape="false" maxlength="200" class="input-large editForm2ColWidth required"/>
					</td>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利类型：</td>
					<td>
						<form:hidden path="spuTypeName"/>
						<form:select path="spuTypeCode" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('PATENT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利申请人：</td><td>
						<form:input path="spuApplySchoolName" value="${schPatentUnder.spuApplySchoolName!=null ? schPatentUnder.spuApplySchoolName : fns:getUser().getCompany().getName()} " htmlEscape="false" maxlength="100" class="input-large editFormFieldWidth required"/>
					</td>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>联络人：</td><td>
						<sys:treeselect id="spuApplyUserId" name="spuApplyUserId" value="${schPatentUnder.spuApplyUserId!=null ? schPatentUnder.spuApplyUserId : fns:getUser().getId()}" labelName="spuApplyUserName" labelValue="${schPatentUnder.spuApplyUserName!=null ? schPatentUnder.spuApplyUserName : fns:getUser().getName()}"
					title="用户" roleEnName="Student" allowInput="true" isAll="true" userURL="treeDataByRoleEnName" url="/sys/office/treeData?type=3" cssClass="input-large editFormSelectWidth required"  allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="tit">
						<span class="help-inline"><font color="red">*</font> </span>所属院系：
					</td>
					<td>
						<!--<sys:treeselect id="spuApplyUserOfficeId" name="spuApplyUserOfficeId" value="${schPatentUnder.spuApplyUserOfficeId}" labelName="spuApplyUserOfficeName" labelValue="${schPatentUnder.spuApplyUserOfficeName}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="editFormTreeWidth required" allowClear="true" notAllowSelectParent="true"/>
						-->
						<form:hidden path="spuApplyUserOfficeId" value="${schPatentUnder.spuApplyUserOfficeId!=null ? schPatentUnder.spuApplyUserOfficeId : fns:getUser().getOffice().getId()}"/>
						<form:input path="spuApplyUserOfficeName" value="${schPatentUnder.spuApplyUserOfficeName!=null ? schPatentUnder.spuApplyUserOfficeName : fns:getUser().getOffice().getName()}" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" />
					</td>
				</tr>
				
				<tr>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>联系电话：</td><td>
						<form:input path="spuApplyPhone" htmlEscape="false" maxlength="45" class="input-large editFormFieldWidth required"/>
					</td>
				<c:if test="${schPatentUnder.isTeacher ne 'true'}" >
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>指导老师：</td><td>
						<sys:treeselect id="spuAdvisTeacherId" name="spuAdvisTeacherId" value="${schPatentUnder.spuAdvisTeacherId}" labelName="spuAdvisTeacherName" labelValue="${schPatentUnder.spuAdvisTeacherName}"
					title="用户" roleEnName="Student" allowInput="${schPatentUnder.isTeacher=='true' ? 'false':'true'}" disabled="${schPatentUnder.isTeacher=='true' ? 'disabled' :''}" isAll="true" userURL="treeDataExcludeRoleEnName" url="/sys/office/treeData?type=3" cssClass="input-large editFormSelectWidth required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>老师所属院系：</td>
					<td>
						<!--
						<sys:treeselect id="spuAdvisTeacherOfficeId" name="spuAdvisTeacherOfficeId" value="${schPatentUnder.spuAdvisTeacherOfficeId}" labelName="spuAdvisTeacherOfficeName" labelValue="${schPatentUnder.spuAdvisTeacherOfficeName}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="editFormTreeWidth required" allowClear="true" notAllowSelectParent="true"/>
						-->
						<form:hidden path="spuAdvisTeacherOfficeId"/>
						<form:input path="spuAdvisTeacherOfficeName" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" />
					</td>
				</tr>
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利代理机构：</td>
					<td>
						<form:select path="spuProxyId" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${schPatentAgencyLiss}" htmlEscape="false"/>
						</form:select>
					</td>
					<td colspan="3">
						<span id="spuProxyInfo"><c:if test="${not empty schPatentUnder.spuProxyId }">&nbsp;&nbsp;&nbsp;&nbsp;联系人:${schPatentUnder.spuProxyContact }&nbsp;&nbsp;&nbsp;&nbsp;联系方式：${schPatentUnder.spuProxyPhone }</c:if></span>
					</td>
				</tr>
				</c:if>
				
				<c:if test="${schPatentUnder.isTeacher eq 'true'}" >
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利代理机构：</td>
					<td>
						<form:select path="spuProxyId" class="input-large editFormSelectWidth required">
							<form:option value="" label=""/>
							<form:options items="${schPatentAgencyLiss}" htmlEscape="false"/>
						</form:select>
					</td>
					<td colspan="2">
						<span id="spuProxyInfo"><c:if test="${not empty schPatentUnder.spuProxyId }">&nbsp;&nbsp;&nbsp;&nbsp;联系人:${schPatentUnder.spuProxyContact }&nbsp;&nbsp;&nbsp;&nbsp;联系方式：${schPatentUnder.spuProxyPhone }</c:if></span>
					</td>
				</tr>
				</c:if>
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利摘要：</td>
					<td colspan="5">
						<form:textarea path="spuRemark" htmlEscape="false" rows="4" maxlength="2000" class="input-xxlarge editFormSelectWidth required"/>
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
									<th><span class="help-inline"><font color="red"></font> </span>发明人教工号/学号</th>
									<th><span class="help-inline"><font color="red">*</font> </span>发明人单位</th>
									<th><span class="help-inline"><font color="red">*</font> </span>贡献度(%)</th>
									<th><span class="help-inline"><font color="red">*</font> </span>排名</th>
									<th>备注</th>
									<shiro:hasPermission name="sch:patent:schPatentUnder:edit"><th width="10">操作</th></shiro:hasPermission>
								</tr>
							</thead>
							<tbody id="schPatentUnderInventorList">
							</tbody>
							<shiro:hasPermission name="sch:patent:schPatentUnder:edit"><tfoot>
								<tr><td colspan="8"><a href="javascript:" onclick="addRow('#schPatentUnderInventorList', schPatentUnderInventorRowIdx, schPatentUnderInventorTpl);schPatentUnderInventorRowIdx = schPatentUnderInventorRowIdx + 1;" class="btn">新增</a></td></tr>
							</tfoot></shiro:hasPermission>
						</table>
						<script type="text/template" id="schPatentUnderInventorTpl">//<!--
						<tr id="schPatentUnderInventorList{{idx}}">
							<td class="hide">
								<input id="schPatentUnderInventorList{{idx}}_id" name="schPatentUnderInventorList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="schPatentUnderInventorList{{idx}}_delFlag" name="schPatentUnderInventorList[{{idx}}].delFlag" type="hidden" value="0"/>
								<input id="schPatentUnderInventorList{{idx}}_spiId" name="schPatentUnderInventorList[{{idx}}].spiId" type="text" value="{{row.spiId}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<select onchange="changeInvType(this,'#schPatentUnderInventorList{{idx}}',{{idx}})" id="schPatentUnderInventorList{{idx}}_spiTypeCode" name="schPatentUnderInventorList[{{idx}}].spiTypeCode" data-value="{{row.spiTypeCode}}" maxlength="45" class="input-small editFormSelectWidth required">
									<c:forEach items="${fns:getDictList('INVENTOR_TYPE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiUserNameTd">
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiUserNo" name="schPatentUnderInventorList[{{idx}}].spiUserNo" value="{{row.spiUserNo}}" labelName="schPatentUnderInventorList[{{idx}}].spiUserName" labelValue="{{row.spiUserName}}"
									title="用户" allowInput="true" roleEnName="Student" isAll="true" userURL="treeDataByRoleEnName" url="/sys/office/treeData?type=3" cssClass="input-large editFormTreeWidth required" allowClear="true" notAllowSelectParent="true"/>
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiUserIdTd">
								<input id="schPatentUnderInventorList{{idx}}_spiUserId"	name="schPatentUnderInventorList[{{idx}}].spiUserId"	value="{{row.spiUserId}}" type="text" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" />					
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiTeacherNameTd" style="display:none">	
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiTeacherNo" name="schPatentUnderInventorList[{{idx}}].spiTeacherNo" value="{{row.spiTeacherNo}}" labelName="schPatentUnderInventorList[{{idx}}].spiTeacherName" labelValue="{{row.spiTeacherName}}"
									title="用户" allowInput="true" roleEnName="teacher" isAll="true" userURL="treeDataByRoleEnName" url="/sys/office/treeData?type=3" cssClass="input-large editFormTreeWidth required" allowClear="true" notAllowSelectParent="true"/>
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiTeacherIdTd" style="display:none">	
								<input id="schPatentUnderInventorList{{idx}}_spiTeacherId"	name="schPatentUnderInventorList[{{idx}}].spiTeacherId"	value="{{row.spiTeacherId}}" type="text" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required"/>					
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiUserNameExTd" style="display:none">
								<input id="schPatentUnderInventorList{{idx}}_spiUserNameEX" name="schPatentUnderInventorList[{{idx}}].spiUserNameEX" type="text" value="{{row.spiUserNameEX}}" maxlength="11" class="input-small editFormFieldWidth required"/>
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiUserIdExTd" style="display:none">
								<input type="text" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth"/>					
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiUserOfficeIdTd">
								<!--
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiUserOfficeId" name="schPatentUnderInventorList[{{idx}}].spiUserOfficeIdTd" value="{{row.spiUserOfficeId}}" labelName="schPatentUnderInventorList{{idx}}.spiUserOfficeName" labelValue="{{row.spiUserOfficeName}}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="editFormTreeWidth required" allowClear="true" notAllowSelectParent="true"/>
								-->
								<input type="hidden" id="schPatentUnderInventorList{{idx}}_spiUserOfficeId" name="schPatentUnderInventorList[{{idx}}].spiUserOfficeId" value="{{row.spiUserOfficeId}}"/>
								<input type="text" id="schPatentUnderInventorList{{idx}}_spiUserOfficeName" name="schPatentUnderInventorList[{{idx}}].spiUserOfficeName" value="{{row.spiUserOfficeName}}" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" />
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiTeacherOfficeIdTd" style="display:none">
								<!--
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiTeacherOfficeId" name="schPatentUnderInventorList[{{idx}}].spiTeacherOfficeId" value="{{row.spiTeacherOfficeId}}" labelName="schPatentUnderInventorList{{idx}}.spiTeacherOfficeName" labelValue="{{row.spiTeacherOfficeName}}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="editFormTreeWidth required" allowClear="true" notAllowSelectParent="true"/>
								-->
								<input type="hidden" id="schPatentUnderInventorList{{idx}}_spiTeacherOfficeId" name="schPatentUnderInventorList[{{idx}}].spiTeacherOfficeId" value="{{row.spiTeacherOfficeId}}"/>
								<input type="text" id="schPatentUnderInventorList{{idx}}_spiTeacherOfficeName" name="schPatentUnderInventorList[{{idx}}].spiTeacherOfficeName" value="{{row.spiTeacherOfficeName}}" readonly="true" htmlEscape="false" maxlength="64" class="input-large editFormFieldWidth required" />
							</td>
							<td id="schPatentUnderInventorList{{idx}}_spiOfficeNameExTd" style="display:none">
								<input id="schPatentUnderInventorList{{idx}}_spiOfficeNameEx" name="schPatentUnderInventorList[{{idx}}].spiOfficeNameEx" type="text" value="{{row.spiOfficeNameEx}}" maxlength="11" class="input-small editFormFieldWidth required"/>
							</td>
							<td>
								<input id="schPatentUnderInventorList{{idx}}_spiContributionPer" name="schPatentUnderInventorList[{{idx}}].spiContributionPer" type="text" value="{{row.spiContributionPer}}" maxlength="11" class="input-small editFormFieldWidth required"/>
							</td>
							<td>			
								<select id="schPatentUnderInventorList{{idx}}_spiNo" name="schPatentUnderInventorList[{{idx}}].spiNo" data-value="{{row.spiNo}}" maxlength="45" class="input-small editFormSelectWidth required">
									<c:forEach items="${fns:getDictList('PATENT_NO')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>				
							</td>
							<td>
								<input id="schPatentUnderInventorList{{idx}}_spiRemark" name="schPatentUnderInventorList[{{idx}}].spiRemark" type="text" value="{{row.spiRemark}}" maxlength="2000" class="input-small editFormFieldWidth"/>
							</td>
							<shiro:hasPermission name="sch:patent:schPatentUnder:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#schPatentUnderInventorList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
						<script type="text/javascript">
							var schPatentUnderInventorRowIdx = 0, schPatentUnderInventorTpl = $("#schPatentUnderInventorTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
							$(document).ready(function() {
								var data = ${fns:toJson(schPatentUnder.schPatentUnderInventorList)};
								for (var i=0; i<data.length; i++){
									addRow('#schPatentUnderInventorList', schPatentUnderInventorRowIdx, schPatentUnderInventorTpl, data[i]);
									schPatentUnderInventorRowIdx = schPatentUnderInventorRowIdx + 1;
								}
							});
						</script>
					</td>
				</tr>	
				<tr>
					<td class="tit">初审评审意见</td>
					<td colspan="5">
						<form:textarea path="firstText" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000" />						
					</td>
				</tr>
				<tr>
					<td class="tit">审核评审意见</td>
					<td colspan="5">
						<form:textarea path="leadText" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000" />
					</td>
				</tr>
				<tr>
					<td class="tit">机构评审意见</td>
					<td colspan="5">
						<form:textarea path="agencyText" class="input-xxlarge editFormSelectWidth required" rows="5" maxlength="2000" />
					</td>
				</tr>
			</table>
		</fieldset>


		<div class="form-actions">
			<shiro:hasPermission name="sch:patent:schPatentUnder:edit">		
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/>&nbsp;	
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<c:if test="${not empty schPatentUnder.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schPatentUnder.act.procInsId}" />
		</c:if>
		
		<c:if test="${empty schPatentUnder.act.procInsId}">
			</br>
			<act:histoicFlow procInsId="${schPatentUnder.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>