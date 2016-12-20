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
	<script src='${ctxStatic}/fullcalendar/lib/jquery-ui.min.js'></script>
	<style type="text/css">
		.fulltable {
			/*table-layout:fixed;*/
			margin:0;padding:0;
			width:700px;
		}
		
		#wrap {
			margin: 0 auto;
		}
			
		#external-events {
			float: left;
			width: 85px;
			padding: 0 10px;
			border: 1px solid #ccc;
			background: #eee;
			text-align: center;
			margin-left:12px;
		}
			
		#external-events h4 {
			font-size: 16px;
			margin-top: 0;
			padding-top: 1em;
		}
			
		#external-events .fc-event {
			margin: 10px 0;
			cursor: pointer;
		}
		
		#external-events .fc-event-free {
			background: #fff;
			margin: 10px 0;
			font-size: 11px;
		}
		
		#external-events .fc-event-apply {
			background: #64be0f;
			margin: 10px 0;
			font-size: 11px;
			color: #666;
		}
		
		#external-events .fc-event-my {
			background: #3a87ad;
			margin: 10px 0;
			font-size: 11px;
			color: #666;
		}
		
		#external-events .fc-event-other {
			background: #7f7f7f;
			margin: 10px 0;
			font-size: 11px;
			color: #666;
		}
			
		#external-events p {
			margin: 1.5em 0;
			font-size: 11px;
			color: #666;
		}
			
		#external-events p input {
			margin: 0;
			vertical-align: middle;
		}
	
		#calendar {
			float: right;
			width: 700px;
			padding-right:25px;
			padding-bottom:10px;
		}
		.back {
		    background-color: #51b2f6;
		}
	</style>
	<script type="text/javascript">
		var clickcell=null;
		$(document).ready(function() {
			/*
			$("#apply").click(function(){
				if(clickcell==null){
					alert("请先选择要预约的科研资源！");
				}
				var strList= new Array();
				var obj=new Object();
				obj.scaSchId="1234";
				obj.
				strList.push(obj);
				//strList.push({scaSchId:"123",scaApplyUserId:"xx",scaApplyTimeRange:"fff",scaApplyDate:"xxx"});
				//strList.push({scaSchId:"1234",scaApplyUserId:"xsdx",scaApplyTimeRange:"ffxxf",scaApplyDate:"xxx1"});
				$.ajax({
				  url:"${ctx}/sch/res/schTechResourceApply/saveApply",
				  type:"POST",
				 // data:{id:"1234",schTechResourceApplys:strList},
				 data:{schTechResourceApplys:strList},
				  dataType:"json",
				  contentType: "application/json; charset=gbk",
				  success:function(data){
					  
				   },error:function(data){
				  }
				});
			});*/
			
			$("#contentTable").each(function() {  
				var self = this; 
				$("tr", $(self)).click(function (){ 
					var trThis = this; 
					clickcell=this;
					$(self).find(".back").removeClass('back'); 
					if ($(trThis).get(0) == $("tr:first", $(self)).get(0)){ 
						clickcell=null;
						return; 
					} 
					$(trThis).addClass('back'); 
					/**
					var eventObject =
	                {
	                    title  : 'event1',
	                    start  : '2016-12-01'
	                };
	                $('#calendar').fullCalendar('renderEvent', eventObject, true);**/
				}); 
			});
			
			/* initialize the external events
			----------------------------------------------------------------
			$('#external-events .fc-event').each(function() {

				// store data so the calendar knows to render an event upon drop
				$(this).data('event', {
					title: $.trim($(this).text()), // use the element's text as the event title
					stick: true // maintain when user navigates (see docs on the renderEvent method)
				});

				// make the event draggable using jQuery UI
				$(this).draggable({
					zIndex: 999,
					revert: true,      // will cause the event to go back to its
					revertDuration: 0  //  original position after the drag
				});

			});**/

			/* initialize the calendar
			-----------------------------------------------------------------*/
	
			$('#calendar').fullCalendar({
				header: {//设置日历头部信息 
		            left: 'prev,next today', 
		            center: 'title', 
		            right: 'month' 
		        },
		        locale: 'zh-cn',
		        height: getWindowSize().toString().split(",")[0]-200,
		        //editable: true,
				droppable: true, // this allows things to be dropped onto the calendar
				dropAccept:function(element,target){
					if(clickcell==null){
						alert("请先选择要预约的科研资源！");
						return false;
					}else{
						/*var event = $(element).data("event");
						var todaysEvents = $('#calendar').fullCalendar('clientEvents', function(event) {
							return event.start >= date && event.start <= date;
					   	});
						for(var i=0;i<todaysEvents.length;i++){
							if(event.title==todaysEvents[i].title){
								alert("该时段已经被预约，请选择其他时段！");
								return false;
							}
						}*/
						return true;
					}
				},
				drop: function(date,jsEvent,ui) {
					event=$(this).data("event");
					//alert($.fullCalendar.formatDate(date, "yyyy-MM-dd"));
					// var date2 = new Date(date.getYears(), date.getMonth(), date.getDate()+1);
					var todaysEvents = $('#calendar').fullCalendar('clientEvents', function(event) {
						 return event.start >= date && event.start <= date;
					 });
					for(var i=0;i<todaysEvents.length;i++){
						if(event.title==todaysEvents[i].title){
							alert("该时段已经被预约，请选择其他时段！");
							return false;
						}
					}
					//alert(todaysEvents[0].title);
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
		    	<table id="contentTable" class="table table-bordered table-condensed fulltable">
					<thead>
						<tr>
							<th>资产分类代码</th>
							<th>资产名称</th>
							<th>计量单位</th>
							<th>品牌/规格型号</th>
							<th>单价/均价</th>
							<th>费用</th>
							<th>所属部门</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="schTechResource">
						<tr>
							<td>
								${fns:getDictLabel(schTechResource.strTypeCode, 'TECH_RESOURCE_TYPE', '')}
							</td>
							<td>
								${schTechResource.strName}
							</td>
							<td>
								${schTechResource.strUnit}
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
			<div id='wrap'>
<!-- 
				<div id='external-events'>
					<h4>预约时间段</h4>
					<div class='fc-event'>8:00~12:00</div>
					<div class='fc-event'>12:00~14:20</div>
					<div class='fc-event'>14:20~18:00</div>
					<div class='fc-event'>18:00~22:00</div>
					<br/>
					<h4>图示说明</h4>
					<div class='fc-event-free'>空闲</div>
					<div class='fc-event-other'>已被预定</div>
					<div class='fc-event-my'>我的预定</div>
					<div class='fc-event-apply'>申请中</div>
					
					<p>
						<label id="apply" class="btn btn-primary">预约</label>
					</p>
				</div>
		 -->
				<div id='calendar'></div>

			</div>
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
			frameObj.height(strs[0] - 117);
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