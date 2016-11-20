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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sch/patent/schPatentUnder/">发明专利列表</a></li>
		<li class="active"><a href="${ctx}/sch/patent/schPatentUnder/form?id=${schPatentUnder.id}">发明专利<shiro:hasPermission name="sch:patent:schPatentUnder:edit">${not empty schPatentUnder.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sch:patent:schPatentUnder:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="schPatentUnder" action="${ctx}/sch/patent/schPatentUnder/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<fieldset>
			<table class="table-form">
				<tr>
					<td class="tit" ><span class="help-inline"><font color="red">*</font> </span>专利名称：</td><td>
						<form:input path="spuName" htmlEscape="false" maxlength="200" class="input-large required" style="width:195px"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利类型：</td><td>
						<form:select path="spuTypeName" class="input-large required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('PATENT_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利申请人：</td><td>
						<form:input path="spuApplySchoolName" htmlEscape="false" maxlength="100" class="input-large required"/>
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>联络人：</td><td>
						<sys:treeselect id="spuApplyUserId" name="spuApplyUserId" value="${schPatentUnder.spuApplyUserId}" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="required"  cssStyle="width:150px"  allowClear="true" notAllowSelectParent="true"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>所属院系：</td><td>
						<sys:treeselect id="spuApplyUserOfficeId" name="spuApplyUserOfficeId" value="${schPatentUnder.spuApplyUserOfficeId}" labelName="" labelValue=""
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" cssStyle="width:150px"  allowClear="true" notAllowSelectParent="true"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>联系电话：</td><td>
						<form:input path="spuApplyPhone" htmlEscape="false" maxlength="45" class="input-large required"/>
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>指导老师：</td><td>
						<sys:treeselect id="schAdvisTeacherId" name="schAdvisTeacherId" value="${schPatentUnder.schAdvisTeacherId}" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" cssStyle="width:150px"  allowClear="true" notAllowSelectParent="true"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>老师所属院系：</td><td>
						<sys:treeselect id="schAdvisTeacherOfficeId" name="schAdvisTeacherOfficeId" value="${schPatentUnder.schAdvisTeacherOfficeId}" labelName="" labelValue=""
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" cssStyle="width:150px"  allowClear="true" notAllowSelectParent="true"/>
					</td><td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利代理机构：</td><td>
						<form:input path="schProxyId" htmlEscape="false" maxlength="45" class="input-large required"/>
					</td>
				</tr>
				
				<tr>
					<td class="tit"><span class="help-inline"><font color="red">*</font> </span>专利摘要：</td>
					<td colspan="5">
						<form:textarea path="schRemark" htmlEscape="false" rows="4" maxlength="2000" class="input-xxlarge required"/>
					</td>
				</tr>
				<tr>
					<td colspan="6"><h5>发明人信息</h5></td>
				</tr>
				<tr>
					<td colspan="6">
						<table id="contentTable" class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th class="hide"></th>
									<th>发明人类型</th>
									<th>发明人姓名</th>
									<th>发明人单位</th>
									<th>贡献度(%)</th>
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
								<input id="schPatentUnderInventorList{{idx}}_spiTypeCode" name="schPatentUnderInventorList[{{idx}}].spiTypeCode" type="text" value="{{row.spiTypeCode}}" maxlength="45" class="input-small required"/>
							</td>
							<td>
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiUserName" name="schPatentUnderInventorList[{{idx}}].spiUserName" value="{{row.spiUserName}}" labelName="schPatentUnderInventorList{{idx}}." labelValue="{{row.}}"
									title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
							</td>
							<td>
								<sys:treeselect id="schPatentUnderInventorList{{idx}}_spiOfficeName" name="schPatentUnderInventorList[{{idx}}].spiOfficeName" value="{{row.spiOfficeName}}" labelName="schPatentUnderInventorList{{idx}}." labelValue="{{row.}}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
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
			</table>
		</fieldset>


		<div class="form-actions">
			<shiro:hasPermission name="sch:patent:schPatentUnder:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>