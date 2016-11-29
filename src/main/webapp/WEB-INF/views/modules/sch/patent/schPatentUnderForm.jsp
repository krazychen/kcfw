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
			
			$("#spuTypeCode").change(function(){
				$("#spuTypeName").val($(this).children('option:selected').text());
			});
			if($("[id='act.taskId']").val()){
				$("#listli").hide();
			}

		});
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
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
				$(obj).parent().next().children().eq(0).hide();
				$(obj).parent().next().children().eq(1).hide();
				 $(prefix+"_spiUserNameEx").show();
				 $(obj).parent().next().next().children().eq(0).hide();
				 $(prefix+"_spiOfficeNameEx").show();
			}else if ($(obj).children('option:selected').text()=='老师'){
				//alert(row)
				//$(obj).parent().next().children().hide();
				//$(obj).parent().next().children().eq(1).show();
				// $(obj).parent().next().next().children().hide();
				// $(prefix+"_spiOfficeId").show();
				//alert($(obj).parent().next().children().eq(1).html());
				//$(obj).parent().next().children().eq(0).show();;
				//$(obj).parent().next().children().eq(2).hide();
				$(obj).parent().next().children().eq(0).hide();
				$(obj).parent().next().children().eq(1).show();
				$(prefix+"_spiTeacherId").show()//.css('display','block');
				//$(prefix+"_spiTeacherIdButton").show()//css('display','block');
				//$(prefix+"_spiTeacherIdButton").addClass("btn");
				 $(prefix+"_spiUserNameEx").hide();
				 $(obj).parent().next().next().children().eq(0).show();
				 $(prefix+"_spiOfficeNameEx").hide();
			}else {
				$(obj).parent().next().children().eq(0).show();
				$(obj).parent().next().children().eq(1).hide();
				 $(prefix+"_spiUserNameEx").hide();
				 $(obj).parent().next().next().children().eq(0).show();
				 $(prefix+"_spiOfficeNameEx").hide();
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
					<td class="tit" ><span class="help-inline"><font color="red">*</font> </span>专利名称：</td><td>
						<form:input path="spuName" htmlEscape="false" maxlength="200" class="input-large required" style="width:195px"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利类型：</td><td>
						<form:hidden path="spuTypeName"/>
						<form:select path="spuTypeCode" class="input-large required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('PATENT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利申请人：</td><td>
						<form:input path="spuApplySchoolName" htmlEscape="false" maxlength="100" class="input-large required"/>
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>联络人：</td><td>
						<sys:treeselect id="spuApplyUserId" name="spuApplyUserId" value="${schPatentUnder.spuApplyUserId}" labelName="spuApplyUserName" labelValue="${schPatentUnder.spuApplyUserName}"
					title="用户" roleEnName="Student" userURL="treeDataByRoleEnName" url="/sys/office/treeData?type=3" cssClass="required"  cssStyle="width:150px"  allowClear="true" notAllowSelectParent="true"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>所属院系：</td><td>
						<sys:treeselect id="spuApplyUserOfficeId" name="spuApplyUserOfficeId" value="${schPatentUnder.spuApplyUserOfficeId}" labelName="spuApplyUserOfficeName" labelValue="${schPatentUnder.spuApplyUserOfficeName}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" cssStyle="width:150px"  allowClear="true" notAllowSelectParent="true"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>联系电话：</td><td>
						<form:input path="spuApplyPhone" htmlEscape="false" maxlength="45" class="input-large required"/>
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>指导老师：</td><td>
						<sys:treeselect id="spuAdvisTeacherId" name="spuAdvisTeacherId" value="${schPatentUnder.spuAdvisTeacherId}" labelName="spuAdvisTeacherName" labelValue="${schPatentUnder.spuAdvisTeacherName}"
					title="用户" roleEnName="teacher" userURL="treeDataByRoleEnName" url="/sys/office/treeData?type=3" cssClass="required" cssStyle="width:150px"  allowClear="true" notAllowSelectParent="true"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>老师所属院系：</td><td>
						<sys:treeselect id="spuAdvisTeacherOfficeId" name="spuAdvisTeacherOfficeId" value="${schPatentUnder.spuAdvisTeacherOfficeId}" labelName="spuAdvisTeacherOfficeName" labelValue="${schPatentUnder.spuAdvisTeacherOfficeName}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" cssStyle="width:150px"  allowClear="true" notAllowSelectParent="true"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利代理机构：</td><td>
						<form:select path="spuProxyId" class="input-large required">
							<form:option value="" label=""/>
							<form:options items="${schPatentAgencyLiss}" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利摘要：</td>
					<td colspan="5">
						<form:textarea path="spuRemark" htmlEscape="false" rows="4" maxlength="2000" class="input-xxlarge required"/>
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
								<select onchange="changeInvType(this,'#schPatentUnderInventorList{{idx}}',{{idx}})" id="schPatentUnderInventorList{{idx}}_spiTypeCode" name="schPatentUnderInventorList[{{idx}}].spiTypeCode" data-value="{{row.spiTypeCode}}" maxlength="45" class="input-small required">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('INVENTOR_TYPE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiUserId" name="schPatentUnderInventorList[{{idx}}].spiUserId" value="{{row.spiUserId}}" labelName="schPatentUnderInventorList{{idx}}.spiUserName" labelValue="{{row.spiUserName}}"
									title="用户" roleEnName="Student" userURL="treeDataByRoleEnName" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiTeacherId" name="schPatentUnderInventorList[{{idx}}].spiTeacherName" value="{{row.spiTeacherId}}" labelName="schPatentUnderInventorList{{idx}}.spiTeacherName" labelValue="{{row.spiTeacherName}}"
									title="用户" roleEnName="teacher" userURL="treeDataByRoleEnName" url="/sys/office/treeData?type=3" cssClass="required" cssStyle="display:none" hideBtn="true" allowClear="true" notAllowSelectParent="true"/>
								<input id="schPatentUnderInventorList{{idx}}_spiUserNameEx" name="schPatentUnderInventorList{{idx}}_spiUserNameEx" type="text" value="{{row.spiUserNameEx}}" maxlength="11" class="input-small required" style="display:none;width:250px"/>
							</td>
							<td>
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiOfficeId" name="schPatentUnderInventorList[{{idx}}].spiOfficeId" value="{{row.spiOfficeId}}" labelName="schPatentUnderInventorList{{idx}}.spiOfficeName" labelValue="{{row.spiOfficeName}}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
								<input id="schPatentUnderInventorList{{idx}}_spiOfficeNameEx" name="schPatentUnderInventorList{{idx}}_spiOfficeNameEx" type="text" value="{{row.spiOfficeNameEx}}" maxlength="11" class="input-small required" style="display:none;width:250px"/>
							</td>
							<td>
								<input id="schPatentUnderInventorList{{idx}}_spiContributionPer" name="schPatentUnderInventorList[{{idx}}].spiContributionPer" type="text" value="{{row.spiContributionPer}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<input id="schPatentUnderInventorList{{idx}}_spiRemark" name="schPatentUnderInventorList[{{idx}}].spiRemark" type="text" value="{{row.spiRemark}}" maxlength="2000" class="input-small "/>
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
				<!--  
				<tr>
					<td class="tit">初审评审意见</td>
					<td colspan="5">
						${schPatentUnder.firstText}
					</td>
				</tr>
				<tr>
					<td class="tit">审核评审意见</td>
					<td colspan="5">
						${schPatentUnder.leadText}
					</td>
				</tr>
				<tr>
					<td class="tit">机构评审意见</td>
					<td colspan="5">
						${schPatentUnder.agencyText}
					</td>
				</tr>-->
			</table>
		</fieldset>


		<div class="form-actions">
			<shiro:hasPermission name="sch:patent:schPatentUnder:edit">
				<c:if test="${schPatentUnder.spuStatus==1 || empty schPatentUnder.id}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/>&nbsp;
				</c:if>
				<input id="btnSubmit2" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${schPatentUnder.spuStatus==1}">
					<input id="btnAdd" class="btn btn-primary" type="button" value="新 增" onClick="location.href='${ctx}onClick="location.href='${ctx}/sch/patent/schPatentAgency/form'"/>&nbsp;
				</c:if>
				<c:if test="${not empty schPatentUnder.id && not empty schPatentUnder.act.procInsId}">
					<input id="btnSubmit3" class="btn btn-inverse" type="submit" value="取消申请" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<c:if test="${not empty schPatentUnder.act.procInsId}">
			<act:histoicFlow procInsId="${schPatentUnder.act.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>