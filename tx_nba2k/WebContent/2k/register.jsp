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
  		<!-- 注册 模态框 -->
		<div class="modal fade" id="myModalRegister" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabelRegister"
			aria-hidden="false">
			<div class="modal-dialog" >
				<div class="modal-content" style="background-image: url('img/8394b13fa1f2af79d9a7523001a813dc.jpg');background-size:100% 100%">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title text-center" id="myModalLabelRegister">注册</h4>
					</div>
					<div class="modal-body" align='center'>
						<div class='input-group'>
							<p style="color: red">{{mess}}</p>
						</div>
						<div class='input-group login_input'>
							<input type='text' class='form-control' style="margin: 5px;border: 1px solid #ccc;"
								placeholder='请输入用户名' name='runame' id='runame' ng-blur="regUser()"/>
						</div>
						<div clas="input-group login_input" id="runameSpan"></div>
						<div class='input-group login_input'>
							<input type='password' class='form-control' style="margin: 5px;border: 1px solid #ccc;"
								placeholder="请输入密码" name='rpwd' id='rpwd' ng-blur="regPwd()" />
						</div>
						<div clas="input-group login_input" id="rpwdSpan"></div>
						<div class='input-group login_input'>
							<input type='password' class='form-control' style="margin: 5px;border: 1px solid #ccc;"
								placeholder="确认密码" name='qpwd' id='qpwd' ng-blur="regQpwd()"/>
						</div>
						<div clas="input-group login_input" id="qpwdSpan"></div>
						<div class='input-group login_input'>
							<input type='text' class='form-control' style="margin: 5px;border: 1px solid #ccc;"
								placeholder='请输入昵称' name='rpname' id='rpname' ng-blur="regPname()"/>
						</div>
						<div clas="input-group login_input" id="rpnameSpan"></div>
						<div class='btn-group login_input'>
							<input type='button' class='btn btn-default' value="注册"
								style="width: 200px; margin: 5px" id='register' ng-click="reg()" data-dismiss="modal" />
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