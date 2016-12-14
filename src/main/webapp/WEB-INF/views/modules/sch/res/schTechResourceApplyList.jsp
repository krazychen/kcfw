<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>科研资源申请</title>
	<meta name="decorator" content="default"/>
	<link rel='stylesheet' href='${ctxStatic}/fullcalendar/fullcalendar.css' />
	<script src='${ctxStatic}/fullcalendar/lib/moment.min.js'></script>
	<script src='${ctxStatic}/fullcalendar/fullcalendar.js'></script>
	<script src='${ctxStatic}/fullcalendar/locale-all.js'></script>
	<style type="text/css">
		.fulltable {
			/*table-layout:fixed;*/
			margin:0;padding:0;
			width:700px;
		}
		
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#calendar').fullCalendar({
				header: {//设置日历头部信息 
		            left: 'prev,next today', 
		            center: 'title', 
		            right: 'month,agendaWeek,agendaDay' 
		        },
		        locale: 'zh-cn',
		        height: getWindowSize().toString().split(",")[0]-115,
		        dayClick: function(date, jsEvent, view, resourceObj) {

		            alert('Date: ' + date.format());
		            alert('Resource ID: ' + resourceObj.id);

		        }
		    })
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sch/res/schTechResource/">科研资源列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="schTechResource" action="${ctx}/sch/res/schTechResource/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="upfile" name="upfile" type="file" style="display:none"/>  
		<ul class="ul-form">
			<li><label>资产分类：</label>
				<form:select path="strTypeCode" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('TECH_RESOURCE_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>资产名称：</label>
				<form:input path="strName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>所属部门：</label>
				<sys:treeselect id="strOfficeId" name="strOfficeId" value="${schTechResource.strOfficeId}" labelName="strOfficeName" labelValue="${schTechResource.strOfficeName}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
		<div id="content" class="row-fluid">
		<div id="left" class="accordion-group">
			<div class="accordion-heading">
		    	<a class="accordion-toggle">科研资源</a>
		    </div>
		    <div id="middlecol">
		    	<table id="contentTable" class="table table-striped table-bordered table-condensed fulltable">
					<thead>
						<tr>
							<th>资产分类代码</th>
							<th>资产名称</th>
							<th>计量单位</th>
							<th>数量/面积</th>
							<th>品牌/规格型号</th>
							<th>单价/均价</th>
							<th>费用</th>
							<th>所属部门</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="schTechResource">
						<tr>
							<td><a href="${ctx}/sch/res/schTechResource/form?id=${schTechResource.id}">
								${fns:getDictLabel(schTechResource.strTypeCode, 'TECH_RESOURCE_TYPE', '')}
							</a></td>
							<td>
								${schTechResource.strName}
							</td>
							<td>
								${schTechResource.strUnit}
							</td>
							<td>
								${schTechResource.strPices}
							</td>
							<td>
								${schTechResource.strBrand}
							</td>
							<td>
								${schTechResource.strPrice}
							</td>
							<td>
								${schTechResource.strCosts}
							</td>
							<td>
								${schTechResource.strOfficeName}
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<div class="pagination">${page}</div>
			</div>
			
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right" style="border: 1px solid #e5e5e5;">
			<div class="accordion-heading" style="margin-bottom:10px">
		    	<a class="accordion-toggle">申请情况</a>
		    </div>
			<div id='calendar'></div>
		</div>
	</div>
	<script type="text/javascript">
		var leftWidth = 400; // 左侧窗口大小
		var htmlObj = $("html"), mainObj = $("#main");
		var frameObj = $("#left, #openClose, #right, #right iframe");
		function wSize(){
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":"hidden", "overflow-y":"auto"});
			mainObj.css("width","auto");
			frameObj.height(strs[0] - 115);
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -10);
			$("#middlecol").width(leftWidth);
			$("#middlecol").height("100%");
			$("#left").css({"overflow":"scroll"});
		}
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>