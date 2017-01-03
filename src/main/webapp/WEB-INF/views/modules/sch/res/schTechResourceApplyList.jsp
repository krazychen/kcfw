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
			width: 710px;
			padding-right:25px;
			padding-bottom:10px;
		}
		.back {
		    background-color: #51b2f6;
		}
	</style>
	<script type="text/javascript">
		var clickcell=null;
		var resId=null;
		$(document).ready(function() {
			
			$("#contentTable").each(function() {  
				var self = this; 
				$("tr", $(self)).click(function (){ 
					var trThis = this; 
					clickcell=this;
					resId=$($(clickcell).find("td")[0]).html();
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
					 $('#calendar').fullCalendar('removeEvents');
					 $('#calendar').fullCalendar('refetchEvents');
				}); 
			});
			

			/* initialize the calendar
			-----------------------------------------------------------------*/
	
			$('#calendar').fullCalendar({
				header: {//设置日历头部信息 
		            left: 'prev,next today', 
		            center: 'title', 
		            right: 'month' 
		        },
		        events: {
			        url:  '${ctx}/sch/res/schTechResourceApply/getApply',
			        type: 'POST',
			        dataType:"JSON",
			        data: function() { // a function that returns an object
			            return {
			            	monthStart:$('#calendar').fullCalendar('getView').start.format(),
			            	monthEnd:$('#calendar').fullCalendar('getView').end.format(),
			           		scaSchId:resId
			            };
			        },
			        error: function() {
			            alert('there was an error while fetching events!');
			        }
			    },
		        locale: 'zh-cn',
		        height: getWindowSize().toString().split(",")[0]-200,
		        dayClick: function(date, jsEvent, view) {
		        	if(clickcell==null){
						alert("请先选择要预约的科研资源！");
						return false;
					}
		        	var todaysEvents = $('#calendar').fullCalendar('clientEvents', function(event) {
						 return event.start >= date && event.start <= date;
					});
		        	var html1  ="<br/>"+
					"<form class='msg-div form-horizontal'>"+
						"<div class='row'> <div class='span6'>   "+
							"<div class='control-group'>"+
								"<label class='control-label' style='width:110px'>预约时间：</label>"+
								"<div class='controls' style='margin-left:100px'>"+
									"<select id='applyTime' style='width:160px' multiple='multiple' size='4'>";
					var html2="<option value='8:00~12:00'>8:00~12:00</option>";
					var html3="<option value='12:00~14:20'>12:00~14:20</option>";
					var html4="<option value='14:20~18:00'>14:20~18:00</option>";
					var html5="<option value='18:00~22:00'>18:00~22:00</option>";
					for(var i=0;i<todaysEvents.length;i++){
						if(todaysEvents[i].title=="8:00~12:00"){
							html2="<option disabled='disabled' value='8:00~12:00'>8:00~12:00 已被预约</option>";
						}else if(todaysEvents[i].title=="12:00~14:20"){
							html3="<option disabled='disabled' value='12:00~14:20'>12:00~14:20 已被预约</option>";
						}else if(todaysEvents[i].title=="14:20~18:00"){
							html4="<option disabled='disabled' value='14:20~18:00'>14:20~18:00 已被预约</option>";
						}else if(todaysEvents[i].title=="18:00~22:00"){
							html5="<option disabled='disabled' value='18:00~22:00'>18:00~22:00 已被预约</option>";
						}
					}
										
										
										
										
					var html=html1+html2+html3+html4+html5+
									"</select></div>"+
							"</div>"+
						"</div></div>"+
					"</form>";
		            
					var submit = function (v, h, f) {
						if(v==0){
							return true;
						}
						var applyTimeS= h.find("#applyTime");
						//alert(applyTimeS.val());
						var resId=$($(clickcell).find("td")[0]).html();
						//alert('Clicked on: ' + date.format());
						//alert(resId);
						if(applyTimeS.val()==null){
							alert("请先选择要预约的时间段");
							return false;
						}
						$.ajax({
							type: "POST",
							url: "${ctx}/sch/res/schTechResourceApply/saveApply",
							data: { //发送给数据库的数据
								scaApplyDates:applyTimeS.val().toString(),
								scaApplyDate:date.format(),
								scaSchId:resId,
							},
							dataType: 'json',
							success: function(data) {
								$.jBox.tip(data.message);	
								//重新刷新日历
								$('#calendar').fullCalendar('removeEvents');
								$('#calendar').fullCalendar('refetchEvents');
							}
						})
					    return true;
					};

					top.$.jBox.open(html,"预约",370,200,{
						buttons:{'确认预约':1,'取消': 0},
						submit: submit});

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
	<form:form id="searchForm" modelAttribute="schTechResource" action="${ctx}/sch/res/schTechResourceApply/" method="post" class="breadcrumb form-search">
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
							<th style="display:none">id</th>
							<th>资产分类代码</th>
							<th>资产名称</th>
							<th>品牌/规格型号</th>
							<th>所属部门</th>
							<th>负责人</th>
							<th>费用</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="schTechResource">
						<tr>
							<td style="display:none">
								${schTechResource.id }
							</td>
							<td>
								${fns:getDictLabel(schTechResource.strTypeCode, 'TECH_RESOURCE_TYPE', '')}
							</td>
							<td>
								${schTechResource.strName}
							</td>
							<td>
								${schTechResource.strBrand}
							</td>				
							<td>
								${schTechResource.strOfficeName}
							</td>
							<td>
								${schTechResource.strUserName}
							</td>
							<td>
								${schTechResource.strCosts}
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
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -25);
			$("#middlecol").width(leftWidth);
			$("#middlecol").height("100%");
			$("#left").css({"overflow":"scroll"});
		}
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>