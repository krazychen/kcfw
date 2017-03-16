<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学年教学管理</title>
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
	<form:form id="inputForm" modelAttribute="xmuProject" action="${ctx}/xmu/proj/xmuProjectTeaching/saveList" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		</table>
		<div class="tabs-container">
				<div id="tab-5" class="tab-pane">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th nowrap>序号</th>
								<th nowrap>项目名称</th>
								<th>学院</th>
								<th>专业</th>
								<th>学年学期</th>
								<th>课程名称</th>
								<th nowrap>总学时</th>
								<th nowrap>上课人数</th>
								<th>授课语言</th>
								<th >主讲老师</th>
								<th>职称</th>
								<th>头衔</th>
							</tr>
						</thead>
						<tbody id="xmuProjectTeachingList">
						</tbody>
					</table>
					<script type="text/template" id="xmuProjectTeachingTpl">//<!--
						<tr id="xmuProjectTeachingList{{idx}}">
							<td class="hide" nowrap>
								<input id="xmuProjectTeachingList{{idx}}_id" name="xmuProjectTeachingList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="xmuProjectTeachingList{{idx}}_delFlag" name="xmuProjectTeachingList[{{idx}}].delFlag" type="hidden" value="0"/>
								<input id="xmuProjectTeachingList{{idx}}_xptTeachingInfoId" name="xmuProjectTeachingList[{{idx}}].xptTeachingInfoId" type="hidden" value="{{row.xptTeachingInfoId}}"/>
							</td>
							<td nowrap>
								{{idx}}
							</td>
							
							<td nowrap>
								<input type="hidden" id="xmuProjectTeachingList{{idx}}_xptProjId" name="xmuProjectTeachingList[{{idx}}].xptProjId" type="text" value="{{row.xptProjId}}"    class="input-small " style="width:100px;"/>
								<input type="hidden" id="xmuProjectTeachingList{{idx}}_xptProjName" name="xmuProjectTeachingList[{{idx}}].xptProjName" type="text" value="{{row.xptProjName}}"    class="input-small " style="width:100px;"/>{{row.xptProjName}}
							</td>

							<td nowrap>
								<input type="hidden" id="xmuProjectTeachingList{{idx}}_xptTeachingOffice" name="xmuProjectTeachingList[{{idx}}].xptTeachingOffice" type="text" value="{{row.xptTeachingOffice}}"    class="input-small"/>{{row.xptTeachingOffice}}
							</td>
							

							<td nowrap>
								<input type="hidden" id="xmuProjectTeachingList{{idx}}_xptTeachingProfeesion" name="xmuProjectTeachingList[{{idx}}].xptTeachingProfeesion" type="text" value="{{row.xptTeachingProfeesion}}"    class="input-small"/>{{row.xptTeachingProfeesion}}
							</td>

							
							<td>
								<input id="xmuProjectTeachingList{{idx}}_xptTeachingGrade" name="xmuProjectTeachingList[{{idx}}].xptTeachingGrade" type="text" value="{{row.xptTeachingGrade}}"    class="input-small"/>
							</td>
							
							<td nowrap>
								<input type="hidden" id="xmuProjectTeachingList{{idx}}_xptTeachingName" name="xmuProjectTeachingList[{{idx}}].xptTeachingName" type="text" value="{{row.xptTeachingName}}"    class="input-small"/>{{row.xptTeachingName}}
							</td>
							
							<td nowrap>
								<input type="hidden" id="xmuProjectTeachingList{{idx}}_xptTeachingHours" name="xmuProjectTeachingList[{{idx}}].xptTeachingHours" type="text" value="{{row.xptTeachingHours}}"    class="input-small"/>{{row.xptTeachingHours}}
							</td>
							
							
							<td nowrap>
								<input type="hidden" id="xmuProjectTeachingList{{idx}}_xptTeachingStu" name="xmuProjectTeachingList[{{idx}}].xptTeachingStu" type="text" value="{{row.xptTeachingStu}}"    class="input-small"/>{{row.xptTeachingStu}}
							</td>
							
							<td>
								<select id="xmuProjectTeachingList{{idx}}_xptTeachingLang" name="xmuProjectTeachingList[{{idx}}].xptTeachingLang" data-value="{{row.xptTeachingLang}}" class="input-small" style="height:25px;width:85px;*width:75px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_COR_LANG')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							<td>
								<input type="hidden" id="xmuProjectTeachingList{{idx}}_xptTeachingTeacher" name="xmuProjectTeachingList[{{idx}}].xptTeachingTeacher" type="text" value="{{row.xptTeachingTeacher}}"    class="input-small"/>{{row.xptTeachingTeacher}}
							</td>
							
							
							<td>
								<select id="xmuProjectTeachingList{{idx}}_xptTeachingJobtitle" name="xmuProjectTeachingList[{{idx}}].xptTeachingJobtitle" data-value="{{row.xptTeachingJobtitle}}" class="input-small" style="height:25px;width:85px;*width:75px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_TEA_JOBTITLE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							
							
							<td>
								<select id="xmuProjectTeachingList{{idx}}_xptTeachingTitle" name="xmuProjectTeachingList[{{idx}}].xptTeachingTitle" data-value="{{row.xptTeachingTitle}}" class="input-small" style="height:25px;width:85px;*width:75px">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('XMU_PROJECT_STU_TEA_TITLE')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>

						</tr>//-->
					</script>
					<script type="text/javascript">
						var xmuProjectTeachingRowIdx = 0, xmuProjectTeachingTpl = $("#xmuProjectTeachingTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(xmuProject.xmuProjectTeachingList)};
							for (var i=0; i<data.length; i++){
								addRow('#xmuProjectTeachingList', xmuProjectTeachingRowIdx, xmuProjectTeachingTpl, data[i]);
								xmuProjectTeachingRowIdx = xmuProjectTeachingRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		</div>
	</form:form>
</body>
</html>