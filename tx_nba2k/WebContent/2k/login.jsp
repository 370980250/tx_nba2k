<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">	
	
  </head>
  <body>
  		<!-- 登录 模态框 -->
		<div class="modal fade" id="myModalLogin" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabelLogin" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content" style="background-image: url('img/19255776f7d29cefaf5a1ba8186e4536.jpg');background-size:100% 100%">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title text-center" id="myModalLabelLogin">登录</h4>
					</div>
					<div class="modal-body" align='center'>
							<div class='input-group'>
								<p style="color: red">{{errorMess}}</p>
							</div>
						<div class='input-group login_input'>
							<input type='text' class='form-control' style="margin: 5px"
								placeholder='用户名' name='uname' id="uname" />
						</div>
						<div class='input-group login_input'>
							<input type='password' class='form-control' style="margin: 5px"
								placeholder="密码" name='pwd' id="pwd" />
						</div>
						<div class='btn-group login_input'>
							<input type='input' class='btn btn-default' value="登录"
								style="width: 200px; margin: 5px" ng-click="login()" />
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
	<!-- /.modal -->
  </body>
</html>