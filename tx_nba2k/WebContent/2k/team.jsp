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
  		var app=  angular.module('teamApp',[]);
  		app.controller('teamCtrl', function($scope,$http) {
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
  			/* 读取队伍和球员集合  */
  			$scope.getTeamList = function(gid){
  				$http({
  					method: "post",
  					url: "Team/queryList.do",
  					params: {"gid":gid}
  				}).then(function(resp) {
  					console.log(resp);
  					$scope.ts = resp.data.ts;
  				});
  			};
  			/* 点击队伍查询球员 */
  			$scope.queryPlayer= function(gid,tid){
  				$http({
  					method: "post",
  					url: "Team/queryPlayer.do",
  					params: {
  						"gid":gid,
  						"id":tid
  					}
  				}).then(function(resp) {
  					console.log(resp);
  					$scope.ps = resp.data;
  					$scope.first = 0;
  					$scope.second = 0;
  					$scope.third=  0;
  					$scope.fourth  = 0;
  					$scope.sum = 0;
  					$scope.one=  0;
  					$scope.two=0;
  					$scope.three=0;
  					$scope.four=0;
  					for(var i = 0;i<$scope.ps.length;i++){
  						switch ($scope.ps[i].round) {
  						case "第一轮":
  							$scope.first += $scope.ps[i].price;
  							$scope.one++;
  							break;
  						case "第二轮":
  							$scope.second += $scope.ps[i].price;
  							$scope.two++;
  							break;
  						case "第三轮":
  							$scope.third += $scope.ps[i].price;
  							$scope.three++;
  							break;
  						case "第四轮":
  							$scope.fourth += $scope.ps[i].price;
  							$scope.four++;
  							break;
  						};
  						$scope.sum += $scope.ps[i].price;
  					};
  					$scope.second += $scope.first;
  					$scope.third += $scope.second;
  					$scope.fourth += $scope.third;
  					$scope.two += $scope.one;
  					$scope.three += $scope.two;
  					$scope.four += $scope.three;
  				});
  			};
  			
  			
  			/* 根据届数查询经理名 */
  			$scope.queryManager = function(gid){
  				$http({
  					method: "post",
  					url: "Team/queryManager.do",
  					params: {"gid":gid}
  				}).then(function(resp) {
  					$scope.ds = resp.data;
  				});
  			};
  			
  			/* 页面加载时获取当前最大届数 */
  			$scope.maxGrade = function(){
  				$http.get("Draft/queryMaxGrade.do")
  				.then(function(obj) {
  					$scope.getTeamList(obj.data.id);
  				});
  			};
  			$scope.maxGrade();
  			
  			/* 改变届数时调用 */
  			$("#selGrade").change(function(){
  				$scope.getTeamList($(this).val());
  			});
  			
  		}); 		
  	</script>
  	
  </head>
  <body>
  	<div  ng-app="teamApp" ng-controller="teamCtrl" ng-cloak>
		<div id="navDiv"></div>
		<div class="form-group">
		<select  id="selGrade" class='form-control' style="margin:auto; width:250px;height:50px;font: bold 20px '微软雅黑'">
		</select>
		</div>
		<div class="col-sm-2 text-center" style="margin-bottom: 50px" ng-repeat="t in ts"><span style="color: red;font-size: 24px">{{t.tcname}}</span><p>({{t.tename}})</p><img ng-src="{{t.pic}}" style="cursor:pointer;width:100px;height: 100px" ng-click="queryPlayer(t.grade.id,t.id)" data-target="#player{{t.id}}" data-toggle="modal"></div>
	
		<!-- 球队信息模态框（Modal） -->
		 <div ng-repeat="t in ts" class="modal fade" id="player{{t.id}}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog" style="width:80%" >
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title text-center" id="myModalLabel">
							{{t.tcname }}
							<!-- <span style="font:bold;color:red" ng-if="d.team.id == t.id">({{d.u.pname }})</span> -->
						</h4>
						<div>球队经理：{{t.user.pname}}</div>
					</div>
					<div class="modal-body">
						<table class='table table-striped'>
							<thead><tr>
								<th>英文名称</th>
								<th>中文名称</th>	
								<th>位置</th>
								<th>能力值</th>
								<th>轮次</th>
								<th>徽章</th>
								<th>价格</th>
								<th>原球队</th>
							</tr></thead>
							<tbody>
								<tr ng-repeat="p in ps">
								<td>{{p.ename }}</td>
								<td>{{p.cname }}</td>
								<td>{{p.position }}</td>
								<td>{{p.ability }}</td>
								<td>{{p.round }}</td>
								<td>{{p.badges }}</td>
								<td>{{p.price }}</td>
								<td>{{p.tname }}</td>						
								</tr>
							</tbody>
							<tfoot>
							<tr>
							 <td colspan="8"><strong>球员数量：</strong></td>
							 </tr>
							 <tr>
							 <td colspan="8" class='text-center' style="margin-top: 111px">前一轮：{{one}}&nbsp;前二轮：{{two}}&nbsp;前三轮：{{three}}&nbsp;前四轮：{{four}}</td>
							 </tr>
							<tr>
							<td colspan="8"><strong>价值：</strong></td>
							</tr>
							<tr>
							<td colspan="8" class='text-center' style="margin-top: 111px">
							 前一轮：{{first}}&nbsp;前二轮：{{second}}&nbsp;前三轮：{{third}}&nbsp;前四轮：{{fourth}}&nbsp;总价值：{{sum}}
							 </td>
							 </tr>
							</tfoot>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" 
								data-dismiss="modal">关闭
						</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal --> 
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