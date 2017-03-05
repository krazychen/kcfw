<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true"%>
<%@ attribute name="url" type="java.lang.String" required="true"%>
<%@ attribute name="title" type="java.lang.String" required="true"%>
<%@ attribute name="width" type="java.lang.String" required="false"%>
<%@ attribute name="height" type="java.lang.String" required="false"%>
<%@ attribute name="target" type="java.lang.String" required="false"%>
<%@ attribute name="label" type="java.lang.String" required="false"%>
<%@ attribute name="closed" type="java.lang.String" required="false"%>
<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="submit()" title="提交"><i class="fa fa-check"></i> ${label==null?'提交':label}</button>
<%-- 使用方法： 1.将本tag写在查询的form之前；2.传入table的id和controller的url --%>
<script type="text/javascript">
$(document).ready(function() {
    $('#${id} thead tr th input.i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
    	  $('#${id} tbody tr td input.i-checks').iCheck('check');
    	});

    $('#${id} thead tr th input.i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
    	  $('#${id} tbody tr td input.i-checks').iCheck('uncheck');
    	});
    
});

	function submit(){
		
		var size = $("#${id} tbody tr td input.i-checks:checked").size();
		  if(size == 0 ){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return;
			  }

		  if(size > 1 ){
				top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
				return;
			  }
		    var id =  $("#${id} tbody tr td input.i-checks:checkbox:checked").attr("id");
		 var status=  $("#${id} tbody tr td input.i-checks:checkbox:checked").attr("status"); 
		 if(status!="1" ){
			top.layer.alert('只能选择待新创建的数据进行提交!', {icon: 0, title:'警告'});
				return;
		 }
		if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
			width='auto';
			height='auto';
		}else{//如果是PC端，根据用户设置的width和height显示。
		
		}
		
		top.layer.open({
		    type: 2,  
		    area: ["${width==null?'800px':width}", "${height==null?'500px':height}"],
		    title: "提交"+'${title}',
	        maxmin: true, //开启最大化最小化按钮
		    content: "${url}?id="+id+"&urlType=form",
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	 var body = top.layer.getChildFrame('body', index);
		         var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
		         var inputForm = body.find('#inputForm');
		         var flag=inputForm.find('#flag');
		         flag.val('yes');
		         var top_iframe;
		         if("${target}"!=""){
		        	 top_iframe = target;//如果指定了iframe，则在改frame中跳转
		         }else{
		        	 top_iframe = top.getActiveTab().attr("name");//获取当前active的tab的iframe 
		         }
		         if("${closed}"!="true"){
		        	 inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
		         
		         	if(iframeWin.contentWindow.doSubmit() ){
		         		// top.layer.close(index);//关闭对话框。
		         		setTimeout(function(){top.layer.close(index)}, 100);//延时0.1秒，对应360 7.1版本bug
		         	}
		    	}else{
		    		iframeWin.contentWindow.doSubmit();
		    	}
				
			  },
			  cancel: function(index){ 
		       }
		}); 	
	
	}
</script>