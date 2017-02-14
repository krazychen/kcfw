<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目课程管理</title>
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
	<form:form id="inputForm" modelAttribute="xmuProject" action="${ctx}/xmu/proj/xmuProjectCource/saveList" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		</table>
		<div class="tabs-container">
			<div id="tab-5" class="tab-pane">
				<table id="contentTable" class="table table-striped table-bordered" >
					<thead>
						<tr>
							<th class="hide"></th>
							<th nowrap>序号</th>
							<th nowrap>学院名称</th>
							<th>项目名称</th>
							<th>课程类型</th>
							<th>开课年级</th>
							<th>开课学期</th>
							<th>授课语言</th>
							<th>拟开课学期</th>
							<th nowrap>开课单位</th>
							<th nowrap>课程名称</th>
							<th nowrap>学时</th>
							<th nowrap>学分</th>
						</tr>
					</thead>
					<tbody id="xmuProjectCourceList">
					</tbody>
				</table>
				<script type="text/template" id="xmuProjectCourceTpl">//<!--
						<tr id="xmuProjectCourceList{{idx}}">
							<td class="hide" nowrap>
								<input id="xmuProjectCourceList{{idx}}_id" name="xmuProjectCourceList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="xmuProjectCourceList{{idx}}_delFlag" name="xmuProjectCourceList[{{idx}}].delFlag" type="hidden" value="0"/>
								<input id="xmuProjectCourceList{{idx}}_xpcCourseInfoId" name="xmuProjectCourceList[{{idx}}].xpcCourseInfoId" type="hidden" value="{{row.xpcCourseInfoId}}"/>
							</td>
							<td nowrap>
								{{idx}}
							</td>
							<td nowrap>
								<input type="hidden" id="xmuProjectCourceList{{idx}}_xpcOfficeId" name="xmuProjectCourceList[{{idx}}].xpcOfficeId" type="text" value="{{row.xpcOfficeId}}"    class="input-small"/>
								<input type="hidden" id="xmuProjectCourceList{{idx}}_xpcOfficeName" name="xmuProjectCourceList[{{idx}}].xpcOfficeName" type="text" value="{{row.xpcOfficeName}}"    class="input-small"/>{{row.xpcOfficeName}}
							</td>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectCourceList{{idx}}_xpcProjId" name="xmuProjectCourceList[{{idx}}].xpcProjId" type="text" value="{{row.xpcProjId}}"    class="input-small"/>
								<input type="hidden" id="xmuProjectCourceList{{idx}}_xpcProjName" name="xmuProjectCourceList[{{idx}}].xpcProjName" type="text" value="{{row.xpcProjName}}"    class="input-small"/>{{row.xpcProjName}}
							</td>
							
							
							<td>
								<select id="xmuProjectCourceList{{idx}}_xpcCourseType" name="xmuProjectCourceList[{{idx}}].xpcCourseType" data-value="{{row.xpcCourseType}}" class="input-mini" style="height:25px;width:85px;*width:75px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_COR_TYPE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<input id="xmuProjectCourceList{{idx}}_xciCourseGrade" name="xmuProjectCourceList[{{idx}}].xciCourseGrade" type="text" value="{{row.xciCourseGrade}}"  class="input-small"/>
							</td>
							
							
							<td>
								<select id="xmuProjectCourceList{{idx}}_xciCourseSemester" name="xmuProjectCourceList[{{idx}}].xciCourseSemester" data-value="{{row.xciCourseSemester}}" class="input-mini" style="height:25px;width:85px;*width:75px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_COR_SEMESTER')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<select id="xmuProjectCourceList{{idx}}_xpcCourseLang" name="xmuProjectCourceList[{{idx}}].xpcCourseLang" data-value="{{row.xpcCourseLang}}" class="input-mini" style="height:25px;width:85px;*width:75px"> 
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_COR_LANG')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							<td>
								<select id="xmuProjectCourceList{{idx}}_xciCourseSemesterNew" name="xmuProjectCourceList[{{idx}}].xciCourseSemesterNew" data-value="{{row.xciCourseSemesterNew}}" class="input-mini" style="height:25px;width:85px;*width:75px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_COR_SEMESTER')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>

							<td nowrap>
								<input type="hidden" id="xmuProjectCourceList{{idx}}_xpcCourseUnit" name="xmuProjectCourceList[{{idx}}].xpcCourseUnit" type="text" value="{{row.xpcCourseUnit}}"    class="input-small"/>{{row.xpcCourseUnit}}
							</td>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectCourceList{{idx}}_xpcCourseName" name="xmuProjectCourceList[{{idx}}].xpcCourseName" type="text" value="{{row.xpcCourseName}}"    class="input-small"/>{{row.xpcCourseName}}
							</td>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectCourceList{{idx}}_xciCourseHours" name="xmuProjectCourceList[{{idx}}].xciCourseHours" type="text" value="{{row.xciCourseHours}}"    class="input-small"/>{{row.xciCourseHours}}
							</td>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectCourceList{{idx}}_xciCourseCredit" name="xmuProjectCourceList[{{idx}}].xciCourseCredit" type="text" value="{{row.xciCourseCredit}}"    class="input-small"/>{{row.xciCourseCredit}}
							</td>
							
						</tr>//-->
					</script>
					<script type="text/javascript">
						var xmuProjectCourceRowIdx = 0, xmuProjectCourceTpl = $("#xmuProjectCourceTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(xmuProject.xmuProjectCourceList)};
							for (var i=0; i<data.length; i++){
								addRow('#xmuProjectCourceList', xmuProjectCourceRowIdx, xmuProjectCourceTpl, data[i]);
								xmuProjectCourceRowIdx = xmuProjectCourceRowIdx + 1;
							}
						});
			</script>
			</div>
		</div>
	</form:form>
</body>
</html>