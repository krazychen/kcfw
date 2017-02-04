<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目管理</title>
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
		
		function addUser(list, idx, tpl, row){
			var vals=$('input[id$=_xpmUserId]');
			var cuids=[];
			if(vals){
				for(var i=0;i<vals.length;i++){
					cuids.push($(vals[i]).val());
				}
			}
			// 正常打开	
			top.layer.open({
			    type: 2, 
			    area: ['300px', '420px'],
			    title:"选择管理员",
			    content: "${ctx}/tag/treeselect?url=/sys/office/treeData?type=3&checked=true&selectIds="+cuids.join(",")+"&roleEnName=Manager&userURL=treeDataByRoleEnName" ,
			    btn: ['确定', '关闭']
	    	       ,yes: function(index, layero){ //或者使用btn1
							var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
							var nodes = [],parents=[];
							nodes = tree.getCheckedNodes(true);
							for(var i=0; i<nodes.length; i++) {
								if (nodes[i].isParent&&nodes[i].level != 0){
									parents.push(nodes[i]);
								}
							}

							$(list).children().remove();
							
							for(var i=0;i<parents.length;i++){
								var childrens=parents[i].children;
								var ids = [], names = [];
								for(var j=0;j<childrens.length;j++){
									if(childrens[j].checked){
										ids.push(childrens[j].id);
										names.push(childrens[j].name);
									}
								}
								xmuProjectManaRowIdx = xmuProjectManaRowIdx + 1;
								var data={"xpmOfficeId":(parents[i].id).replace(/u_/ig,""),"xpmOfficeName":parents[i].name,
										"xpmUserId":ids.join(",").replace(/u_/ig,""),"xpmUserName":names.join(","),"delFlag":"1"};
								addRow(list,xmuProjectManaRowIdx,tpl,data);
							}
							//$("#${id}Id").val(ids.join(",").replace(/u_/ig,""));
							//$("#${id}Name").val(names.join(","));
							//$("#${id}Name").focus();
							top.layer.close(index);
					    },
	    			cancel: function(index){ //或者使用btn2
	    	           //按钮【按钮二】的回调
	    	       }
			}); 
		
		}
		
		function addUser2(list, idx, tpl, row){
			var vals=$('input[id$=_xprUserId]');
			var cuids=[];
			if(vals){
				for(var i=0;i<vals.length;i++){
					cuids.push($(vals[i]).val());
				}
			}
			// 正常打开	
			top.layer.open({
			    type: 2, 
			    area: ['300px', '420px'],
			    title:"选择负责人",
			    content: "${ctx}/tag/treeselect?url=/sys/office/treeData?type=3&checked=true&selectIds="+cuids.join(",")+"&roleEnName=RESP&userURL=treeDataByRoleEnName" ,
			    btn: ['确定', '关闭']
	    	       ,yes: function(index, layero){ //或者使用btn1
							var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
							var nodes = [],parents=[];
							nodes = tree.getCheckedNodes(true);
							for(var i=0; i<nodes.length; i++) {
								if (nodes[i].isParent&&nodes[i].level != 0){
									parents.push(nodes[i]);
								}
							}
							
							$(list).children().remove();
							
							for(var i=0;i<parents.length;i++){
								var childrens=parents[i].children;
								var ids = [], names = [];
								for(var j=0;j<childrens.length;j++){
									if(childrens[j].checked){
										ids.push(childrens[j].id);
										names.push(childrens[j].name);
									}
								}
								xmuProjectRespRowIdx = xmuProjectRespRowIdx + 1;
								var data={"xprOfficeId":(parents[i].id).replace(/u_/ig,""),"xprOfficeName":parents[i].name,
										"xprUserId":ids.join(",").replace(/u_/ig,""),"xprUserName":names.join(","),"delFlag":"1"};
								addRow(list,xmuProjectRespRowIdx,tpl,data);
							}
							//$("#${id}Id").val(ids.join(",").replace(/u_/ig,""));
							//$("#${id}Name").val(names.join(","));
							//$("#${id}Name").focus();
							top.layer.close(index);
					    },
	    			cancel: function(index){ //或者使用btn2
	    	           //按钮【按钮二】的回调
	    	       }
			}); 
		
		}
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
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="xmuProject" action="${ctx}/xmu/proj/xmuProject/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>项目名称：</label></td>
					<td class="width-35">
						<form:input path="xmpName" htmlEscape="false" maxlength="200" class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>项目级别：</label></td>
					<td class="width-35">
						<form:select path="xmpLevel" class="form-control required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('XMU_PROJECT_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">项目开始时间：</label></td>
					<td class="width-35">
						<input id="xmpMaintDate" name="xmpMaintDate" type="text" maxlength="20" class="laydate-icon form-control layer-date formDateMaxWidth"
							value="<fmt:formatDate value="${xmuProject.xmpMaintDate}" pattern="yyyy-MM-dd"/>" />
					</td>
					<td class="width-15 active"><label class="pull-right">项目结束时间：</label></td>
					<td class="width-35">
						<input id="xmpEndDate" name="xmpEndDate" type="text" maxlength="20" class="laydate-icon form-control layer-date formDateMaxWidth"
							value="<fmt:formatDate value="${xmuProject.xmpEndDate}" pattern="yyyy-MM-dd"/>"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>项目状态：</label></td>
					<td class="width-35">
						<form:select path="xmpStatus" class="form-control required">
							<form:options items="${fns:getDictList('XMU_PROJECT_STATUS')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="width-15 active"><label class="pull-right">项目停用时间：</label></td>
					<td class="width-35">
						<input id="xmpStopDate" name="xmpStopDate" type="text" maxlength="20" class="laydate-icon form-control layer-date formDateMaxWidth"
							value="<fmt:formatDate value="${xmuProject.xmpStopDate}" pattern="yyyy-MM-dd"/>"/>
					</td>
					
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">项目简介：</label></td>
					<td colspan="3">
						<form:textarea path="xmpDescp" htmlEscape="false" rows="4" maxlength="2000" class="form-control "/>
					</td>
		  		</tr>
		 	</tbody>
		</table>
		<div class="tabs-container">
            <ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">项目学院管理员：</a>
                </li>
				<li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">项目学院负责人：</a>
                </li>
            </ul>
            <div class="tab-content">
				<div id="tab-1" class="tab-pane active">
				<a class="btn btn-white btn-sm" onclick="addUser('#xmuProjectManaList', xmuProjectManaRowIdx, xmuProjectManaTpl);" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th class="hide"></th>
						<th>项目学院名称</th>
						<th>学院管理员名称</th>
					</tr>
				</thead>
				<tbody id="xmuProjectManaList">
				</tbody>
			</table>
			<script type="text/template" id="xmuProjectManaTpl">//<!--
				<tr id="xmuProjectManaList{{idx}}">
					<td class="hide">
						<input id="xmuProjectManaList{{idx}}_id" name="xmuProjectManaList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="xmuProjectManaList{{idx}}_delFlag" name="xmuProjectManaList[{{idx}}].delFlag" type="hidden" value="{{row.delFlag}}"/>
					</td>
					
					<td>
						<input id="xmuProjectManaList{{idx}}_xpmOfficeId" name="xmuProjectManaList[{{idx}}].xpmOfficeId" type="hidden" value="{{row.xpmOfficeId}}"/>
						<input id="xmuProjectManaList{{idx}}_xpmOfficeName" name="xmuProjectManaList[{{idx}}].xpmOfficeName" class="form-control" type="text" readonly="true" value="{{row.xpmOfficeName}}"/>
					</td>

					<td>
						<input id="xmuProjectManaList{{idx}}_xpmUserId" name="xmuProjectManaList[{{idx}}].xpmUserId" type="hidden" value="{{row.xpmUserId}}"/>
						<input id="xmuProjectManaList{{idx}}_xpmUserName" name="xmuProjectManaList[{{idx}}].xpmUserName" class="form-control" type="text" readonly="true" value="{{row.xpmUserName}}"/>
					</td>
					
				</tr>//-->
			</script>
			<script type="text/javascript">
				var xmuProjectManaRowIdx = 0, xmuProjectManaTpl = $("#xmuProjectManaTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(xmuProject.xmuProjectManaList)};
					for (var i=0; i<data.length; i++){
						addRow('#xmuProjectManaList', xmuProjectManaRowIdx, xmuProjectManaTpl, data[i]);
						xmuProjectManaRowIdx = xmuProjectManaRowIdx + 1;
					}
				});
			</script>
			</div>
				<div id="tab-2" class="tab-pane">
			<a class="btn btn-white btn-sm" onclick="addUser2('#xmuProjectRespList', xmuProjectRespRowIdx, xmuProjectRespTpl);" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th class="hide"></th>
						<th>项目学院名称</th>
						<th>学院负责人名称</th>
					</tr>
				</thead>
				<tbody id="xmuProjectRespList">
				</tbody>
			</table>
			<script type="text/template" id="xmuProjectRespTpl">//<!--
				<tr id="xmuProjectRespList{{idx}}">
					<td class="hide">
						<input id="xmuProjectRespList{{idx}}_id" name="xmuProjectRespList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="xmuProjectRespList{{idx}}_delFlag" name="xmuProjectRespList[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>

					<td>
						<input id="xmuProjectRespList{{idx}}_xprOfficeId" name="xmuProjectRespList[{{idx}}].xprOfficeId" type="hidden" value="{{row.xprOfficeId}}"/>
						<input id="xmuProjectRespList{{idx}}_xprOfficeName" name="xmuProjectRespList[{{idx}}].xprOfficeName" class="form-control" type="text" readonly="true" value="{{row.xprOfficeName}}"/>
					</td>

					<td>
						<input id="xmuProjectRespList{{idx}}_xprUserId" name="xmuProjectRespList[{{idx}}].xprUserId" type="hidden" value="{{row.xprUserId}}"/>
						<input id="xmuProjectRespList{{idx}}_xprUserName" name="xmuProjectRespList[{{idx}}].xprUserName" class="form-control" type="text" readonly="true" value="{{row.xprUserName}}"/>
					</td>
					
				</tr>//-->
			</script>
			<script type="text/javascript">
				var xmuProjectRespRowIdx = 0, xmuProjectRespTpl = $("#xmuProjectRespTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(xmuProject.xmuProjectRespList)};
					for (var i=0; i<data.length; i++){
						addRow('#xmuProjectRespList', xmuProjectRespRowIdx, xmuProjectRespTpl, data[i]);
						xmuProjectRespRowIdx = xmuProjectRespRowIdx + 1;
					}
				});
			</script>
			</div>
		</div>
		</div>
	</form:form>
</body>
</html>