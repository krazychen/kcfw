<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目人员管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/jquery-select2/3.5.4/select2.js"></script>
<link href="${ctxStatic}/jquery-select2/3.5.4/select2.css" type="text/css" rel="stylesheet" />
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
				if($(this).attr("data-value")){
					$(this).val($(this).attr("data-value"));
				}
				if($(this).attr("multiple")){
					if($(this).attr("data-value"))
						$(this).val(($(this).attr("data-value")).split(","));
				}
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
		function doSearch(){
			$("#pageNo").val(0);
			var xpsUserName=$("#xpsUserName").val();
			var xpuUserGrade=$("#xpuUserGrade").val();
			var xpuUserProfession=$("#xpuUserProfession").val();
			var xpuUserStuno=$("xpuUserStuno").val();
			var id=$("id").val();
			//var newAction="${ctx}/xmu/proj/xmuProjectStudent/formList?id="+id+"&xpsUserName="+xpsUserName
			//+"&xpuUserGrade="+xpuUserGrade+"&xpuUserProfession="+xpuUserProfession+"&xpuUserStuno="+xpuUserStuno;
			var newAction="${ctx}/xmu/proj/xmuProjectStudent/formList";
			$("#inputForm").attr("action", newAction);
			//alert($("#inputForm").attr("action"));
			//$("#inputForm").submit();
				return false;
		}
		
		function doReset(){
			$("#pageNo").val(0);
			$("#inputForm div.form-group input").val("");
			$("#inputForm div.form-group select").val("");
			var newAction="${ctx}/xmu/proj/xmuProjectStudent/formList";
			$("#inputForm").attr("action", newAction);
			//$("#searchForm").submit();
			return false;
		}
		
		function doExport(){
			top.layer.confirm('确认要导出Excel吗?', {icon: 3, title:'系统提示'}, function(index){
				//do something
		    	//导出之前备份
		    	var url =  $("#inputForm").attr("action");
		    	var pageNo =  $("#pageNo").val();
		    	var pageSize = $("#pageSize").val();
		    	//导出excel
		    	var newAction="${ctx}/xmu/proj/xmuProjectStudent/exportIn";
				$("#inputForm").attr("action", newAction);
			    $("#pageNo").val(-1);
				$("#pageSize").val(-1);
				$("#inputForm").submit();
	
				//导出excel之后还原
				$("#inputForm").attr("action",url);
			    $("#pageNo").val(pageNo);
				$("#pageSize").val(pageSize);
				//return false;
				top.layer.close(index);
			});
		}

	</script>
</head>

<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="xmuProject" action="${ctx}/xmu/proj/xmuProjectStudent/saveList" method="post" class="form-inline">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="ibox-content">
					<!-- 查询条件 -->
			<div class="row">
			<div class="col-sm-12">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
				<div class="row" style="margin-bottom:7px;margin-left:4px">
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
						<div class="form-group">
							<span>姓名：</span>
							<form:input path="xpsUserName" id="xpsUserName" htmlEscape="false" maxlength="2000"  class=" form-control input-sm"/>
						</div>
					</div>
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
						<div class="form-group">
							<span>年级：</span>
							<form:input path="xpuUserGrade" id="xpuUserGrade" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
						</div>
					</div>
				</div>
				<div class="row" style="margin-left:4px">
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
						<div class="form-group">
							<span>专业：</span>
							<form:input path="xpuUserProfession" id="xpuUserProfession" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
						</div>
					</div>
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
						<div class="form-group">
							<span>学号：</span>
							<form:input path="xpuUserStuno" id="xpuUserStuno" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
						</div>
					</div>
				 </div>	
			<br/>
			</div>
			</div>
			
			<!-- 工具栏 -->
			<div class="row">
			<div class="col-sm-12">
				<div class="pull-left">
			       	<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="doSearch()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
					<a id="btnExport" href="#" onclick="doExport()" class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="导出"><i class="fa fa-file-excel-o"></i> 导出</a>
				</div>
				<div class="pull-right">
					<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="doSearch()" ><i class="fa fa-search"></i> 查询</button>
					<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="doReset()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</div>
			</div>
		
			<table id="contentTable" class="table table-striped table-bordered" >
				<thead>
					<tr>
						<th class="hide"></th>
						<th nowrap>序号</th>
						<th>学院</th>
						<th>姓名</th>
						<th nowrap>年级</th>
						<th nowrap>专业</th>
						<th nowrap>学号</th>
						<th nowrap>证件号</th>
						<th>毕业中学</th>
						<th>毕业时间</th>
						<th>毕业去向</th>
						<th>读研学校</th>
						<th>读研专业</th>
						<th>工作单位</th>
						<th>待定说明</th>
						<th>导师</th>
						<th>职称</th>
						<th>头衔</th>
						<th>入选时间</th>
						<th>退出时间</th>
						<th>状态</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tbody id="xmuProjectStudentList">
				</tbody>
			</table>
			<table:page page="${xmuProject.xmuProjectStudentPage}"></table:page>
			<br/>
			<br/>
			<script type="text/template" id="xmuProjectStudentTpl">//<!--
						<tr id="xmuProjectStudentList{{idx}}">
							<td class="hide">
								<input id="xmuProjectStudentList{{idx}}_id" name="xmuProjectStudentList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="xmuProjectStudentList{{idx}}_delFlag" name="xmuProjectStudentList[{{idx}}].delFlag" type="hidden" value="0"/>
								<input id="xmuProjectStudentList{{idx}}_xpsProjId" name="xmuProjectStudentList[{{idx}}].xpsProjId" type="hidden" value="${xmuProject.id}"/>
								<input id="xmuProjectStudentList{{idx}}_xpsOfficeId" name="xmuProjectStudentList[{{idx}}].xpsOfficeId" type="text" value="{{row.xpsOfficeId}}"    class="input-small"/>							
								<input readonly="true" id="xmuProjectStudentList{{idx}}_xpsUserId" name="xmuProjectStudentList[{{idx}}].xpsUserId" type="text" value="{{row.xpsUserId}}"    class="input-small"/>
							</td>

							<td>
								{{idx}}
							</td>
							<td nowrap>
								<input type="hidden" id="xmuProjectStudentList{{idx}}_xpsOfficeName" name="xmuProjectStudentList[{{idx}}].xpsOfficeName" type="text" value="{{row.xpsOfficeName}}"    class="input-small"/>{{row.xpsOfficeName}}
							</td>
							
							<td nowrap>
								<input type="hidden" id="xmuProjectStudentList{{idx}}_xpsUserName" name="xmuProjectStudentList[{{idx}}].xpsUserName" type="text" value="{{row.xpsUserName}}"    class="input-small"/>{{row.xpsUserName}}
							</td nowrap>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectStudentList{{idx}}_xpuUserGrade" name="xmuProjectStudentList[{{idx}}].xpuUserGrade" type="text" value="{{row.xpuUserGrade}}"    class="input-small"/>{{row.xpuUserGradeName}}
							</td>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectStudentList{{idx}}_xpuUserProfession" name="xmuProjectStudentList[{{idx}}].xpuUserProfession" type="text" value="{{row.xpuUserProfession}}"    class="input-small"/>{{row.xpuUserProfessionName}}
							</td>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectStudentList{{idx}}_xpuUserStuno" name="xmuProjectStudentList[{{idx}}].xpuUserStuno" type="text" value="{{row.xpuUserStuno}}"    class="input-small"/>{{row.xpuUserStuno}}
							</td>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectStudentList{{idx}}_xpuUserLincno" name="xmuProjectStudentList[{{idx}}].xpuUserLincno" type="text" value="{{row.xpuUserLincno}}"    class="input-small"/>{{row.xpuUserLincno}}
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserMidsch" name="xmuProjectStudentList[{{idx}}].xpuUserMidsch" type="text" value="{{row.xpuUserMidsch}}"    class="input-small"/>
							</td>
							
							
							<td nowrap>
								<input id="xmuProjectStudentList{{idx}}_xpuUserGradTime" name="xmuProjectStudentList[{{idx}}].xpuUserGradTime" type="text" readonly="readonly" maxlength="20" class="laydate-icon layer-date  " style="height:25px;width:120px;*width:100px"
									value="{{row.xpuUserGradTime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							
							
							<td>
								<select id="xmuProjectStudentList{{idx}}_xpuUserGradAdd" name="xmuProjectStudentList[{{idx}}].xpuUserGradAdd" data-value="{{row.xpuUserGradAdd}}" class="input-mini" style="height:25px;width:85px;*width:75px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_GRAD_ADD')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserGraduteSch" name="xmuProjectStudentList[{{idx}}].xpuUserGraduteSch" type="text" value="{{row.xpuUserGraduteSch}}"    class="input-small"/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserGraduteProf" name="xmuProjectStudentList[{{idx}}].xpuUserGraduteProf" type="text" value="{{row.xpuUserGraduteProf}}"    class="input-small"/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserWork" name="xmuProjectStudentList[{{idx}}].xpuUserWork" type="text" value="{{row.xpuUserWork}}"    class="input-small"/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserRemark" name="xmuProjectStudentList[{{idx}}].xpuUserRemark" type="text" value="{{row.xpuUserRemark}}"    class="input-small "/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserTeacher" name="xmuProjectStudentList[{{idx}}].xpuUserTeacher" type="text" value="{{row.xpuUserTeacher}}"    class="input-small"/>
							</td>
							
							
							<td>
								<select id="xmuProjectStudentList{{idx}}_xpuUserTeacherJobtitle"  name="xmuProjectStudentList[{{idx}}].xpuUserTeacherJobtitle" data-value="{{row.xpuUserTeacherJobtitle}}" class="input-mini" style="height:25px;width:85px;*width:75px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_TEA_JOBTITLE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<select id="xmuProjectStudentList{{idx}}_xpuUserTeacherTitle" multiple="multiple" name="xmuProjectStudentList[{{idx}}].xpuUserTeacherTitle" data-value="{{row.xpuUserTeacherTitle}}" class="input-mini" style="min-height:25px;height:25px;width:255px;*width:245px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_TEA_TITLE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserRegTime" name="xmuProjectStudentList[{{idx}}].xpuUserRegTime" type="text" readonly="readonly" maxlength="20" class="laydate-icon input-small layer-date  " style="height:25px;width:120px;*width:100px"
									value="{{row.xpuUserRegTime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							
							
							<td>
								<input id="xmuProjectStudentList{{idx}}_xpuUserExitTime" name="xmuProjectStudentList[{{idx}}].xpuUserExitTime" type="text" readonly="readonly" maxlength="20" class="laydate-icon input-small layer-date  " style="height:25px;width:120px;*width:100px"
									value="{{row.xpuUserExitTime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							
							
							<td>
								<select autocomplete="off" id="xmuProjectStudentList{{idx}}_xpuUserStatus" name="xmuProjectStudentList[{{idx}}].xpuUserStatus" data-value="{{row.xpuUserStatus}}" class="input-mini" style="height:25px;width:85px;*width:75px">
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
					//var data = ${fns:toJson(xmuProject.xmuProjectStudentList)};
					var data = ${fns:toJson(xmuProject.xmuProjectStudentPage.list)};
					for (var i=0; i<data.length; i++){
						addRow('#xmuProjectStudentList', xmuProjectStudentRowIdx, xmuProjectStudentTpl, data[i]);
						var temp="#xmuProjectStudentList"+xmuProjectStudentRowIdx+"_xpuUserTeacherTitle";
						$(temp).select2();
						xmuProjectStudentRowIdx = xmuProjectStudentRowIdx + 1;
					}
				});
				
				
				function page(n,s){//翻页
					$("#pageNo").val(n);
					$("#pageSize").val(s);
					var newAction="${ctx}/xmu/proj/xmuProjectStudent/formList";
					$("#inputForm").attr("action", newAction);
					$("#inputForm").submit();
					$("span.page-size").text(s);
					return false;
				}
			</script>
		</div>
	</form:form>
</body>
</html>