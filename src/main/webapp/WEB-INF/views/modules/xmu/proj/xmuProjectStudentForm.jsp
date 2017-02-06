<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目人员管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			validateForm = $("#inputForm").validate({
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
				if($(this).attr("data-value"))
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
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="xmuProject" action="${ctx}/xmu/proj/xmuProjectStudent/saveList" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="ibox-content">
			<table id="contentTable" class="table table-striped table-bordered" style="overflow-x: auto; width:3300px;">
				<thead>
					<tr>
						<th class="hide"></th>
						<th class="hide">学生学院ID</th>
						<th width="40px">序号</th>
						<th width="150px">学院</th>
						<th class="hide">学生ID</th>
						<th width="110px">姓名</th>
						<th width="120px">年级</th>
						<th width="180px">专业</th>
						<th width="120px">学号</th>
						<th width="200px">证件号</th>
						<th width="150px">毕业中学</th>
						<th width="100px">毕业时间</th>
						<th width="120px">毕业去向</th>
						<th width="180px">读研学校</th>
						<th width="180px">读研专业</th>
						<th width="180px">工作单位</th>
						<th width="180px">待定说明</th>
						<th width="110px">导师</th>
						<th width="120px">职称</th>
						<th width="120px">头衔</th>
						<th width="100px">入选时间</th>
						<th width="100px">退出时间</th>
						<th width="80px">状态</th>
						<th width="10px">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="xmuProjectStudentList">
				</tbody>
			</table>
			<script type="text/template" id="xmuProjectStudentTpl">//<!--
						<tr id="xmuProjectStudentList{{idx}}">
							<td class="hide">
								<input id="xmuProjectStudentList{{idx}}_id" name="xmuProjectStudentList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="xmuProjectStudentList{{idx}}_delFlag" name="xmuProjectStudentList[{{idx}}].delFlag" type="hidden" value="0"/>
								<input id="xmuProjectStudentList{{idx}}_xpsProjId" name="xmuProjectStudentList[{{idx}}].xpsProjId" type="hidden" value="${xmuProject.id}"/>
							</td>
							
							<td class="hide">
								<input id="xmuProjectStudentList{{idx}}_xpsOfficeId" name="xmuProjectStudentList[{{idx}}].xpsOfficeId" type="text" value="{{row.xpsOfficeId}}"    class="form-control required"/>
							</td>
							<td>
								{{idx}}
							</td>
							<td>
								<input readonly="true" id="xmuProjectStudentList{{idx}}_xpsOfficeName" name="xmuProjectStudentList[{{idx}}].xpsOfficeName" type="text" value="{{row.xpsOfficeName}}"    class="form-control required"/>
							</td>
							
							
							<td class="hide">
								<input readonly="true" id="xmuProjectStudentList{{idx}}_xpsUserId" name="xmuProjectStudentList[{{idx}}].xpsUserId" type="text" value="{{row.xpsUserId}}"    class="form-control required"/>
							</td>
							
							
							<td>
								<input readonly="true" id="xmuProjectStudentList{{idx}}_xpsUserName" name="xmuProjectStudentList[{{idx}}].xpsUserName" type="text" value="{{row.xpsUserName}}"    class="form-control required"/>
							</td>
							
							
							<td>
								<input readonly="true" id="xmuProjectStudentList{{idx}}_xpuUserGrade" name="xmuProjectStudentList[{{idx}}].xpuUserGrade" type="text" value="{{row.xpuUserGrade}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input readonly="true" id="xmuProjectStudentList{{idx}}_xpuUserProfession" name="xmuProjectStudentList[{{idx}}].xpuUserProfession" type="text" value="{{row.xpuUserProfession}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input readonly="true" id="xmuProjectStudentList{{idx}}_xpuUserStuno" name="xmuProjectStudentList[{{idx}}].xpuUserStuno" type="text" value="{{row.xpuUserStuno}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input readonly="true" id="xmuProjectStudentList{{idx}}_xpuUserLincno" name="xmuProjectStudentList[{{idx}}].xpuUserLincno" type="text" value="{{row.xpuUserLincno}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserMidsch" name="xmuProjectStudentList[{{idx}}].xpuUserMidsch" type="text" value="{{row.xpuUserMidsch}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserGradTime" name="xmuProjectStudentList[{{idx}}].xpuUserGradTime" type="text" readonly="readonly" maxlength="20" class="laydate-icon form-control layer-date  "
									value="{{row.xpuUserGradTime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							
							
							<td>
								<select id="xmuProjectStudentList{{idx}}_xpuUserGradAdd" name="xmuProjectStudentList[{{idx}}].xpuUserGradAdd" data-value="{{row.xpuUserGradAdd}}" class="form-control m-b  ">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_GRAD_ADD')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserGraduteSch" name="xmuProjectStudentList[{{idx}}].xpuUserGraduteSch" type="text" value="{{row.xpuUserGraduteSch}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserGraduteProf" name="xmuProjectStudentList[{{idx}}].xpuUserGraduteProf" type="text" value="{{row.xpuUserGraduteProf}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserWork" name="xmuProjectStudentList[{{idx}}].xpuUserWork" type="text" value="{{row.xpuUserWork}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserRemark" name="xmuProjectStudentList[{{idx}}].xpuUserRemark" type="text" value="{{row.xpuUserRemark}}"    class="form-control "/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserTeacher" name="xmuProjectStudentList[{{idx}}].xpuUserTeacher" type="text" value="{{row.xpuUserTeacher}}"    class="form-control "/>
							</td>
							
							
							<td>
								<select id="xmuProjectStudentList{{idx}}_xpuUserTeacherJobtitle" name="xmuProjectStudentList[{{idx}}].xpuUserTeacherJobtitle" data-value="{{row.xpuUserTeacherJobtitle}}" class="form-control m-b  ">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_TEA_JOBTITLE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<select id="xmuProjectStudentList{{idx}}_xpuUserTeacherTitle" name="xmuProjectStudentList[{{idx}}].xpuUserTeacherTitle" data-value="{{row.xpuUserTeacherTitle}}" class="form-control m-b  ">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_TEA_TITLE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserRegTime" name="xmuProjectStudentList[{{idx}}].xpuUserRegTime" type="text" readonly="readonly" maxlength="20" class="laydate-icon form-control layer-date  "
									value="{{row.xpuUserRegTime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserExitTime" name="xmuProjectStudentList[{{idx}}].xpuUserExitTime" type="text" readonly="readonly" maxlength="20" class="laydate-icon form-control layer-date  "
									value="{{row.xpuUserExitTime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							
							
							<td>
								<select autocomplete="off" id="xmuProjectStudentList{{idx}}_xpuUserStatus" name="xmuProjectStudentList[{{idx}}].xpuUserStatus" data-value="{{row.xpuUserStatus}}" class="form-control m-b  ">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_STATUS')}" var="dict" varStatus="status">
										<c:if test="${status.index == 0}">
											<option value="${dict.value}" selected="selected">${dict.label}</option>
										</c:if>
										<c:if test="${status.index != 0}">
											<option value="${dict.value}">${dict.label}</option>
										</c:if>
									</c:forEach>						
								</select>
							</td>
							
							<td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#xmuProjectStudentList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td>
						</tr>//-->
					</script>
			<script type="text/javascript">
				var xmuProjectStudentRowIdx = 0, xmuProjectStudentTpl = $("#xmuProjectStudentTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(xmuProject.xmuProjectStudentList)};
					for (var i=0; i<data.length; i++){
						addRow('#xmuProjectStudentList', xmuProjectStudentRowIdx, xmuProjectStudentTpl, data[i]);
						xmuProjectStudentRowIdx = xmuProjectStudentRowIdx + 1;
					}
				});
			</script>
		</div>
	</form:form>
</body>
</html>