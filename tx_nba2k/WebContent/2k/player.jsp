<%@page import="com.tx.pojo.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  		var app=  angular.module('playerApp',[]);
  		app.controller('playerCtrl', function($scope,$http) {
  			denglu($scope, $http);
  			zhuxiao($scope, $http);
  			zhuce($scope,$http);
  			//键盘监听按下enter查询
  			$("#qname").keypress(function(event){
  				if(event.keyCode == 13){
  					$scope.getPlayerList($scope.grade.id,1);
  				}
  			});
  			
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
  			var current = true;
  			/* 加载当前届的球员列表 */
  			$scope.getPlayerList = function(gid,cpage){
  				$http({
  					method: "post",
  					url: "Player/queryPlayerList.do",
  					params: {
  						"gid":gid,
  						"qname":$("#qname").val(),
  						"cpage":cpage
  					}
  				}).then(function(resp) {
  					console.log(resp);
  					$scope.ts = resp.data.ts;
  					$scope.ps = resp.data.ps;
  					$scope.partion = resp.data.partion;
  					$scope.url = resp.data.url;
  					
  					if(current){
						ws.connect($scope);
  					}
  				});
  			};
  			
  			
  			$scope.prev = function(){
  				$scope.getPlayerList($scope.grade.id, $scope.partion.cpage-1);
  			};
  			$scope.next = function(){
  				$scope.getPlayerList($scope.grade.id, $scope.partion.cpage+1);
  			};
  			/* 页面加载时获取当前最大届数 */
  			$scope.maxGrade = function(){
  				$http.get("Draft/queryMaxGrade.do")
  				.then(function(obj) {
  					$scope.grade = obj.data;
  					$scope.getPlayerList(obj.data.id,1);
  				});
  			};
  			$scope.maxGrade();
  			/*查询选择的届数  */
  			$scope.queryGrade = function(id){
  				$http({
  					url: "Draft/queryGradeById.do",
  					params: {"id":id}
  				}).then(function(resp) {
  					$scope.grade = resp.data;
  				});
  			};
  			
  			/* 添加球员至该球队 */
  			$scope.addPlayerToTeam = function(tid,pid){
  				$http({
  					url: "Player/updatePlayerToTeam.do",
  					params: {"id":pid,"tid":tid}
  				}).then(function(resp) {
  					 if(resp.data.meg){
  						/* $scope.getPlayerList($scope.grade.id, $scope.partion.cpage);   */
  						$(".modal-backdrop").hide();
  						$("body").css("overflow","auto");
  						ws.sendMeg("temp");
  					}else{
  						alert("添加失败");
  					} 
  				});
  			};
  			
  			/* 改变届数时调用 */
  			$("#selGrade").change(function(){
  				$scope.queryGrade($("#selGrade").val());
				$scope.getPlayerList($("#selGrade").val(),1);
  			});
  			var ws = {};
  			ws.webSocket = null;
  			ws.connect = function($scope){
	  			current = false;
	  			if('WebSocket' in window){
	  				ws.webSocket = new WebSocket("ws://"+$scope.url+":8080/tx_nba2k/push");
	  			}else{
	  				alert("当前浏览器不支持WebSocket");
	  			}
				ws.webSocket.onopen = function(){
					ws.webSocket.send("temp");
				};
	  			ws.webSocket.onmessage=function(msg){
	  				console.log(msg);
	  				if(msg.data=="temp"){
	  					$scope.getPlayerList($("#selGrade").val(), $scope.partion.cpage);
	  				}
	  			};
	  			ws.webSocket.onerror=function(event){
	  			};
  			};
  			ws.sendMeg = function(meg){
				ws.webSocket.send(meg);
			};
			
  			window.onbeforeunload = function() {  
	  			ws.webSocket.close();  
  		    };  
  		});
  	</script>
  </head>
  <body>
	 <div  ng-app="playerApp" ng-controller="playerCtrl" ng-cloak>
		<div id="navDiv">
		</div>
		<select  id="selGrade" class='form-control' style="margin:auto; width:250px;height:50px;">
		</select>
		<!-- 球员列表 -->
		<div>
			<div class='input-group col-xs-10 col-lg-6'
				style=" margin: auto; margin-top: 10px;">
				<input type='text' id="qname" class='form-control' placeholder='请输入中文名或英文名'
					name='qname' value="{{partion.query.qname}}"><span
					class='input-group-btn'><button class='btn btn-default' ng-click="getPlayerList(grade.id,1)">查询</button></span>
			</div>
			<table class='table table-striped  table-responsive'>
				<thead>
					<tr>
						<th class="col-sm-2">英文名称</th>
						<th class="col-sm-2">中文名称</th>
						<th class="col-sm-1">位置</th>
						<th class="col-sm-1">能力值</th>
						<th class="col-sm-1">轮次</th>
						<th class="col-sm-1">徽章</th>
						<th class="col-sm-1">价格</th>
						<th class="col-sm-1">原球队</th>
						<th class="col-sm-1">现球队</th>
						<c:if test="${u.power.id>=3 }">
							<th class="col-sm-1">操作</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="player in ps">
						<td class="col-sm-2">{{player.ename }}</td>
						<td class="col-sm-2">{{player.cname }}</td>
						<td class="col-sm-1">{{player.position }}</td>
						<td class="col-sm-1">{{player.ability }}</td>
						<td class="col-sm-1">{{player.round }}</td>
						<td class="col-sm-1">{{player.badges }}</td>
						<td class="col-sm-1">{{player.price }}</td>
						<td class="col-sm-1">{{player.tname }}</td>
						<td class="col-sm-1">{{player.team.tcname}}</td>
						<c:if test="${u.power.id>=3 }">
							<td class="col-sm-1">
									<a data-toggle="modal"
									data-target="#updateTeam{{player.id}}" style="cursor: url('<%=basePath%>img/nba.ico'),default;">添加</a>
								</td>
						</c:if>
					</tr>
				</tbody>
				<tfoot>
					<tr>
					<td colspan="9">
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
		<!-- 添加 模态框 -->
		<div ng-repeat="p in ps" class="modal fade" name='myModalAdddiv' id='updateTeam{{p.id}}' tabindex="-1" role="dialog"
			aria-labelledby="updateTeamLaber" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title text-center" id="updateTeamLaber">添加至球队</h4>
					</div>
					<div class="modal-body" align='center'>
						<button name="buttonTeam" class='btn btn-default' style="margin: 10px" ng-repeat="t in ts" ng-click="addPlayerToTeam(t.id,p.id)" data-dismiss="modal">
							{{t.tcname}}
						</button>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default"
							data-dismiss="modal">关闭</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		
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