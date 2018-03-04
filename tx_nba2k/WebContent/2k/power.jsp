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
  		var app=  angular.module('powerApp',[]);
  		app.controller('powerCtrl', function($scope,$http) {
  			denglu($scope, $http);
  			zhuxiao($scope, $http);
  			zhuce($scope,$http);
  			regUser($scope,$http);
  			
  			$scope.ajaxPower = function(cpage){
  				$http({
  					url: "Power/queryList.do",
  					params: {"cpage":cpage}
  				})
  				.then(function(resp) {
  					$scope.us = resp.data.us;
  					$scope.ps = resp.data.ps;
  					$scope.partion = resp.data.partion;
  				});
  			};
  			$scope.ajaxPower(1);
  			
  			$scope.prev = function(){
  				$scope.ajaxPower($scope.partion.cpage-1);
  			};
  			$scope.next = function(){
  				$scope.ajaxPower($scope.partion.cpage+1);
  			};
  			$scope.alterPower= function(uid){
  				$http({
  					url: "Power/updatePower.do",
  					params:{"uid":uid,"pid":$("#select"+uid).val()}
  				}).then(function(resp) {
  					if(resp.data.meg){
  						alert("修改成功");
  					}else{
  						alert("修改失败了");
  					}
  				});
  			}
  		}); 		
  		
  	</script>
  </head>
  <body>
  	<div  ng-app="powerApp" ng-controller="powerCtrl">
		<div id="navDiv">
		</div>
		<div class="col-sm-8 col-sm-offset-2">
			<table class="table table-bordered">
				<thead>
					<tr>
						<td>用户名</td>
						<td>经理名</td>
						<td>权限</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="u in us">
						<td>{{u.uname}}</td>
						<td>{{u.pname}}</td>
						<td>{{u.power.pname}}</td>
						<td>
							<select id="select{{u.id}}">
							<option  ng-repeat="p in ps" value="{{p.id}}">{{p.pname}}</option>
							</select>
							<a ng-click="alterPower(u.id)">修改</a>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
					<td colspan="4">
					<div class="row clearfix">
							<div class="col-md-12 column">
								<ul class="pager">
									<li>
										 <a ng-click='prev()' ng-if="partion.cpage!=1" style="cursor: pointer;">Prev</a>
									</li>
									<li>
									&nbsp;<strong>{{partion.cpage}}</strong>&nbsp;
									</li>
									<li>
										 <a ng-click='next()' ng-if="partion.cpage!=partion.apage" style="cursor: pointer;">Next</a>
									</li>
									<li>
									&nbsp;<small>总页数：{{partion.apage}}</small>&nbsp;
									</li>
								</ul>
							</div>
						</div>
						</td>
						</tr>
				</tfoot>
			</table>
		</div>
	  	<div id="loginDiv"></div>
		<div id="registerDiv"></div>
		<script>
		$("#loginDiv").load("2k/login.jsp");
		$("#registerDiv").load("2k/register.jsp");
		$("#navDiv").load("2k/nav.jsp");
		</script>
	</div>	
  </body>
</html>