<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首页</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		     WinMove();
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
   <div class="row  border-bottom white-bg dashboard-header">
        <div class="col-sm-12">
            <blockquote class="text-info" style="font-size:14px">
            </blockquote>

            <hr>
        </div>
    </div>
      
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-4">

                <div class="ibox float-e-margins">
                     <div class="ibox-title">
                        <h5>Krazy 技术特点</h5> 
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="index.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="index.html#">选项1</a>
                                </li>
                                <li><a href="index.html#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        
                    </div>
                </div>
              
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                     <div class="ibox-title">
                        <h5>升级日志</h5> <span class="label label-primary">K+</span>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="index.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="index.html#">选项1</a>
                                </li>
                                <li><a href="index.html#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="panel-body">
                            <div class="panel-group" id="version">
                            
                            	<div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v2.5">v2.5</a><code class="pull-right">2016.10.8更新</code>
                                            </h5>
                                    </div>
                                    <div id="v2.5" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <ol>
                                            	<li>升级代码生成器，生成的代码增加表单校验功能。</li>
                                            	<li>修复代码生成器v2.3版本的bug，修复乱码功能。</li>
                                            	<li>优化代码生成器体验，增加错误校验等。</li>
                                                <li>去除dialog的竖向滚动条</li>
                                                <li>修复升级layer2.3的bug。</li>
                                            	<li>升级layim1.0到layim2.0。</li>
                                            	<li>支持自定义签名。</li>
                                                <li>支持表情，文件，群聊，群聊聊天记录。</li>
                                                <li>支持自定义聊天群组，添加移除群组人员。</li>
                                                <li>支持离线消息。</li>
                                                <li>....</li>
                                                <li>layim1.0是免费插件，layim2.0是商业授权，你仍可选择免费使用layim1.0，如果需要使用layim2.0，你需要购买一个授权，价格不贵，希望大家尊重知识版权，给开源作者一点点鼓励，才能持续给大家提供优秀的开源软件,<a href="http://layim.layui.com/?from=layer" target="_blank">layIM官网</a>。</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            
                        
                               
                			</div>
            			</div>
            		</div>
           	 	</div>
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                   
                </div>
                <div class="ibox float-e-margins">
                    
                </div>
            </div>
        </div>
    </div>
	</div>
</body>
</html>