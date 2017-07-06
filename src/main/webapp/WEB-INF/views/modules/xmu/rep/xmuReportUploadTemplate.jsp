<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上传下载模版</title>
	<meta name="decorator" content="default"/>
</head>
<body>
      <form:form id="inputForm" modelAttribute="xmuReportMnt" action="${ctx}/xmu/rep/xmuReportMnt/uploadTemplate" method="post" class="form-horizontal">
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">下载模版：</label></td>
					<td colspan="5">
						<form:hidden id="xrmTemplate" path="xrmTemplate" htmlEscape="false" maxlength="1000" class="input-large"/>
						<sys:ckfinder input="xrmTemplate" type="files" uploadPath="/xrmTemplate" selectMultiple="false"/>
					</td>
		  		</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>