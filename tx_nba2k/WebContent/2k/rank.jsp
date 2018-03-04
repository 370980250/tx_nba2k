<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  		var app=  angular.module('rankApp',[]);
  		app.controller('rankCtrl', function($scope,$http,$compile) {
  			denglu($scope, $http);
  			zhuxiao($scope, $http);
  			zhuce($scope,$http);
  		//加载届数Ajax
  	 		$scope.gradeAjax = function(){
  				$http.get("Draft/queryGradeList.do")
  				.then(function(obj) {
  					$scope.gs = obj.data;
  					for ( var i in $scope.gs) {
  						$("#selGrade").append("<option  value='"+$scope.gs[i].id+"'>"+$scope.gs[i].gname+"</option>");
  				}
  					$("#selGrade option:last").prop("selected",true);
  				});
  			};
  			$scope.gradeAjax();
  			$scope.win = [];
  			$scope.lose = [];
  			/* 加载战绩信息 */
  			$scope.rankAjax = function(gid){
  				$http({
  					url: "Rank/queryRank.do",
  					params: {"gid":gid}
  				}).then(function(resp) {
  					$scope.ts=resp.data.ts;
  					$scope.pts = resp.data.pts;
  					var rank = 1;
  					var prank = 1;
  					for(x in resp.data.ts){
  						$scope.win.push(resp.data.ts[x].win);
  						$scope.lose.push(resp.data.ts[x].lose);
  						$scope.ts[x].rank = rank++;
  					}
  					for(x in resp.data.pts){
  						$scope.pts[x].rank = prank++;
  					}
  				});
  			};
  			/* 页面加载时获取当前最大届数 */
  			$scope.maxGrade = function(){
  				$http.get("Draft/queryMaxGrade.do")
  				.then(function(obj) {
  					$scope.rankAjax(obj.data.id);
  				});
  			};
  			$scope.maxGrade();
  			
  			/* 改变届数时调用 */
  			$("#selGrade").change(function(){
  				$scope.rankAjax($(this).val());
  			});
  			/*修改胜场  */
  			$scope.alterWin= function(){
  				$("#alterLose").hide();
  				$("#alterWin").hide();
  				$("#saveWin").removeClass("hide");
  				for(x in $scope.ts){
  					var html = "<input type='text' id='winInput"+$scope.ts[x].id+"' class='form-control' style='width:50px;height:25px;margin-top:0px' />";
  					$("#win"+$scope.ts[x].id).text("");
  					var $html = $compile(html)($scope);
	  				$("#win"+$scope.ts[x].id).append($html);
	  				$("#winInput"+$scope.ts[x].id).val($scope.ts[x].win);
  				}
  				
  			};
  			var wins = [];
			var stcnames = [];
  			/*保存胜场  */
  			$scope.saveWin = function(){
  				$("#alterLose").show();
  				$("#saveWin").addClass("hide");
  				$("#alterWin").show();
  				for(var x = 0 ;x<  $scope.ts.length;x++){
  					stcnames.push($("#tcname"+$scope.ts[x].id).text());
  					wins.push($("#winInput"+$scope.ts[x].id).val());
  				}
  				$http({
  					url: "Rank/saveWin.do",
  					params:{
  						"wins":wins,
  						"tcnames":stcnames,
  						"gid":$("#selGrade").val()
  					} 
  				}).then(function(resp) {
  					$scope.rankAjax($("#selGrade").val());
  					wins  = [];
  				}, function(reason) {
  					alert("修改失败");
  				});
  			};
  			
  			/*修改负场  */
  			$scope.alterLose= function(){
  				$("#alterWin").hide();
  				$("#alterLose").hide();
  				$("#saveLose").removeClass("hide");
  				for(x in $scope.ts){
  					var html = "<input type='text' id='loseInput"+$scope.ts[x].id+"' class='form-control' style='width:50px;height:25px;margin-top:0px' />";
  					var $html = $compile(html)($scope);
  					$("#lose"+$scope.ts[x].id).text("");
	  				$("#lose"+$scope.ts[x].id).append($html);
	  				$("#loseInput"+$scope.ts[x].id).val($scope.lose[x]);
  				}
  				
  			};
  			var loses = [];
  			var ftcnames=  [];
  			/*保存负场  */
  			$scope.saveLose = function(){
  				$("#saveLose").addClass("hide");
  				$("#alterLose").show();
  				$("#alterWin").show();
  				for(var x = 0 ;x<$scope.ts.length;x++){
  					ftcnames.push($("#tcname"+$scope.ts[x].id).text());
  					loses.push($("#loseInput"+$scope.ts[x].id).val());
  				}
  				$http({
  					url: "Rank/saveLose.do",
  					params:{
  						"loses":loses,
  						"tcnames":ftcnames,
  						"gid":$("#selGrade").val()
  					} 
  				}).then(function(resp) {
  					$scope.rankAjax($("#selGrade").val());
  					loses = [];
  				}, function(reason) {
  					alert("修改失败");
  				})
  			};
  		});
  	</script>
  </head>
  <body>
  <div ng-app="rankApp" ng-controller="rankCtrl" ng-cloak>
	<div id="navDiv">
	</div>
	<div class="row-fluid">
		<div class="col-sm-12">
			<div class="tabbable tabs-left" id="tabs-1">
				<ul class="nav nav-tabs">
					<li class="active">
						<a href="#panel-1" data-toggle="tab">排名</a> 
					</li>
					<li>
						<a href="#panel-2" data-toggle="tab">Playoff</a> 
					</li>
					<c:if test="${u.power.id>=3 }">
					<li>
						<a href="#panel-3" data-toggle="tab">战绩录入</a> 
					</li>
					</c:if>
					<li>
							<select  id="selGrade" class='form-control' style="width:250px;height:50px;font: bold 20px '微软雅黑'">
							</select>
					</li>
				</ul>
				
				<div  class="tab-content" id="panel">
					<!-- 战绩信息-->
					<div class="tab-pane active" id="panel-1" style=" margin: auto">
						<table class="table table-bordered table-condensed">
							<thead>
								<tr>
									<td class="col-sm-1">排名</td>
									<td class="col-sm-1">经理</td>
									<td class="col-sm-1">球队名</td>
									<td class="col-sm-1">总场次</td>
									<td class="col-sm-1">胜场</td>
									<td class="col-sm-1">负场</td>
									<td class="col-sm-1">胜率</td>
									<td class="col-sm-1">积分</td>
									<td class="col-sm-1">更新时间</td>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="t in ts">
									<td>{{t.rank}}</td>
									<td>{{t.user.pname}}</td>
									<td>{{t.tcname}}</td>
									<td>{{t.win+t.lose}}</td>
									<td>{{t.win}}</td>
									<td>{{t.lose}}</td>
									<td>{{(t.win/(t.win+t.lose))*100 | number:2}}%</td>
									<td>{{t.win*2+t.lose}}</td>
									<td>{{t.updateDate | date:"yyyy-MM-dd HH:mm:ss"}}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 季后赛信息-->
					<div class="tab-pane" id="panel-2" style=" margin: auto">
						<table class="table table-bordered table-condensed">
							<thead>
								<tr>
									<td class="col-sm-1">排名</td>
									<td class="col-sm-1">经理</td>
									<td class="col-sm-1">球队名</td>
									<td class="col-sm-1">总场次</td>
									<td class="col-sm-1">胜场</td>
									<td class="col-sm-1">负场</td>
									<td class="col-sm-1">胜率</td>
									<td class="col-sm-1">积分</td>
									<td class="col-sm-1">更新时间</td>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="t in pts">
									<td>{{t.rank}}</td>
									<td>{{t.user.pname}}</td>
									<td>{{t.tcname}}</td>
									<td>{{t.win+t.lose}}</td>
									<td>{{t.win}}</td>
									<td>{{t.lose}}</td>
									<td>{{(t.win/(t.win+t.lose))*100 | number:2}}%</td>
									<td>{{t.win*2+t.lose}}</td>
									<td>{{t.updateDate | date:"yyyy-MM-dd HH:mm:ss"}}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--战绩录入  -->
					<div class="tab-pane" id="panel-3" style=" margin: auto">
						<table class="table table-bordered table-condensed">
							<thead>
								<tr>
									<td class="col-sm-1">排名</td>
									<td class="col-sm-1">经理</td>
									<td class="col-sm-1">球队名</td>
									<td class="col-sm-1">总场次</td>
									<td class="col-sm-1">胜场<button class="btn btn-default" id="alterWin" ng-click="alterWin()">修改</button><button class="btn btn-default hide" id="saveWin" ng-click="saveWin()">保存</button></td>
									<td class="col-sm-1">负场<button class="btn btn-default" id="alterLose" ng-click="alterLose()">修改</button><button class="btn btn-default hide" id="saveLose" ng-click="saveLose()">保存</button></td>
									<td class="col-sm-1">胜率</td>
									<td class="col-sm-1">积分</td>
									<td class="col-sm-1">更新时间</td>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="t in ts">
									<td>{{t.rank}}</td>
									<td>{{t.user.pname}}</td>
									<td id="tcname{{t.id}}">{{t.tcname}}</td>
									<td>{{t.win+t.lose}}</td>
									<td id="win{{t.id}}">{{t.win}}</td>
									<td id="lose{{t.id}}">{{t.lose}}</td>
									<td>{{(t.win/(t.win+t.lose))*100 | number:2}}%</td>
									<td>{{t.win*2+t.lose}}</td>
									<td>{{t.updateDate | date:"yyyy-MM-dd HH:mm:ss"}}</td>
								</tr>
							</tbody>
						</table>
					
					</div>
					
				</div>
			</div>
		</div>
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