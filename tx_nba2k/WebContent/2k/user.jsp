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
	<script
	  src="http://code.jquery.com/jquery-3.2.1.min.js"
	  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	  crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  	<script src="https://cdn.bootcss.com/angular.js/1.5.8/angular.min.js"></script>
  	<script type="text/javascript" src="<%=basePath %>js/public.js"></script>
  	<script type="text/javascript">
  		var app=  angular.module('userApp',[]);
		app.controller('userCtrl', function($scope,$http) {
			denglu($scope, $http);
			zhuxiao($scope, $http);
			zhuce($scope,$http);
			regUser($scope,$http);
			$scope.regPname1 = function(){
				$("#pnameDiv").removeClass("has-success has-error");
				$("#pnameLaber").text("昵称");
				if($("#pname").val()!=''){
				$http({
	 				url: "User/RegPname.do",
	 				params: {"pname":$("#pname").val()}
	 			}).then(function(resp) {
	 				if(resp.data.meg){
	 					$("#pnameDiv").addClass("has-success");
	 					$("#pnameLaber").text("昵称可用");
	 				}else{
	 					$("#pnameDiv").addClass("has-error");
	 					$("#pnameLaber").text("昵称重复");
	 				}
	 			});
				}
			};
			
			$scope.regPwd1 = function(){
				$("#pwdDiv").removeClass("has-success has-error");
				$("#pwdLaber").text("修改密码");
				if($("#pwd").val().length<6){
					$("#pwdDiv").addClass("has-error");
 					$("#pwdLaber").text("密码不低于6位");
				}else{
					$("#pwdDiv").addClass("has-success");
				}
				$scope.regQpwd1();
			};
			
			$scope.regQpwd1 = function(){
				$("#qpwdDiv").removeClass("has-success has-error");
				$("#qpwdLaber").text("确认密码");
				if($("#qpwd").val().length>=6&&$("#qpwd").val()==$("#pwd").val()){
 					$("#qpwdDiv").addClass("has-success");
				}else{
					$("#qpwdDiv").addClass("has-error");
 					$("#qpwdLaber").text("密码不一致");
				}
			}
			
			$scope.alterUser = function(){
				$http({
					url: "User/alterUser.do",
					params: {"pwd":$("#pwd").val(),"pname":$("#pname").val()}
				}).then(function(resp) {
					if(resp.data.meg){
						alert("修改成功");
						location.href="2k/main.jsp";
					}else{
						alert("修改失败");
					}
				});
			}
		}); 	
  	</script>
  </head>
  <body>
  	<div  ng-app="userApp" ng-controller="userCtrl">
	<div id="navDiv">
	</div>
	<div class="col-sm-8 col-sm-offset-2" >
		<form action="" class="form-horizontal" role="form">
			<div class="form-group">
				<label class="col-sm-2 control-label" for="uname">用户名</label>
				<div class="col-sm-10">
			      <input type="text" class="form-control" id="uname" value="${u.uname }" readonly="readonly"/>
			    </div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="uname">权限</label>
				<div class="col-sm-10">
			      <input type="text" class="form-control" id="uname" value="${u.power.pname }" readonly="readonly"/>
			    </div>
			</div>
			<div class="form-group" id="pwdDiv">
				<label class="col-sm-2 control-label" for="pwd" id="pwdLaber">修改密码</label>
				<div class="col-sm-10">
			      <input type="password" class="form-control" id="pwd" ng-blur="regPwd1()"/>
			    </div>
			</div>
			<div class="form-group" id="qpwdDiv">
				<label class="col-sm-2 control-label" for="qpwd" id="qpwdLaber">确认密码</label>
				<div class="col-sm-10">
			      <input type="password" class="form-control" id="qpwd" ng-blur="regQpwd1()"/>
			    </div>
			</div>
			<div class="form-group" id="pnameDiv">
				<label class="col-sm-2 control-label" for="pname" id="pnameLaber">昵称</label>
				<div class="col-sm-10">
			      <input type="text" class="form-control" id="pname" ng-blur="regPname1()"/>
			    </div>
			</div>
			<div class="form-group">
				<div class="col-sm-10 col-sm-offset-2">
				<button id="submit" class="btn btn-primary form-control" ng-click="alterUser()">修改</button>
				</div>
			</div>
		</form>
	</div>
	<div id="loginDiv"></div>
	<div id="registerDiv"></div>
	<script>
	$("#loginDiv").load("2k/login.jsp");
	$("#registerDiv").load("2k/register.jsp");
	$("#navDiv").load("2k/nav.jsp");
	</script>
  </body>
</html>