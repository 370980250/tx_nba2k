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
  		var app=  angular.module('tradeApp',[]);
  		app.directive('onFinishRenderFilters', function ($timeout) {
  		  return {
  		    restrict: 'A',
  		    link: function(scope, element, attr) {
  		      if (scope.$last === true) {
  		        $timeout(function() {
  		          scope.$emit('ngRepeatFinished');
  		        });
  		      }
  		    }
  		  };
  		});
  		
  		app.controller('tradeCtrl', function($scope,$http,$compile) {
  			denglu($scope, $http);
  			zhuxiao($scope, $http);
  			zhuce($scope,$http);
  			//页面加载
  			$scope.tradeAjax = function(gid){
  				$http({
  					url:"Trade/queryTradeList.do",
  					params: {"gid":gid}
  				})
  				.then(function(resp) {
  					console.log(resp);
  					$scope.ts = resp.data.ts;
  					$scope.teams= resp.data.teams;
  					$scope.tos = resp.data.tos; 
  					$scope.myteam = resp.data.myteam;
  					alert($scope.myteam);
  					$scope.myps = resp.data.myps;
  					for(p in $scope.myps){
  						for(t in $scope.tos){
  							if($scope.myps[p].id==$scope.tos[t].player.id){
  								alert("#guapai"+$scope.tos[t].player.id);
  								$("#guapai"+$scope.myps[p].id).hide();
  							}
  						}
  					}
  				});
  			};
  			/*管理员通过交易  */
  			$scope.passTrade = function(tid){
  				$http({
  					url: "Trade/passTrade.do",
  					params: {"tid":tid}
  				}).then(function(resp) {
  					alert(resp.data.meg);
  					$scope.tradeAjax($("#selGrade").val());
  				});
  			};
  			/*管理员驳回交易  */
  			$scope.rejectTrade = function(tid){
  				$http({
  					url:"Trade/rejectTrade.do",
  					params: {"tid":tid}
  				}).then(function(resp) {
  					alert(resp.data.meg);
  					$scope.tradeAjax($("#selGrade").val());
  				});
  			};
  			
  			/* 查看交易详情 */
  			$scope.viewPlayer = function(){
  				for(var j = 0; j<$scope.ts.length;j++){
  				$("#viewPlayerBody"+$scope.ts[j].id).children().remove();
					for(var i = 0;i<$scope.ts[j].ps1.length;i++){
						
  						var html = "<tr><td>"+$scope.ts[j].ps1[i].cname+"<small style='color:red;'></small></td><td>"+$scope.ts[j].ps1[i].price+"<small>("+$scope.ts[j].ps1[i].round+")</small></td><td>"+$scope.ts[j].ps2[i].price+"<small>("+$scope.ts[j].ps1[i].round+")</small></td><td>"+$scope.ts[j].ps2[i].cname+"<small style='color:red;'></small></td></tr>";
  						$("#viewPlayerBody"+$scope.ts[j].id).append(html);
 						}
				}
  			};
  			
  			/* 页面加载时获取当前最大届数 */
  			$scope.maxGrade = function(){
  				$http.get("Draft/queryMaxGrade.do")
  				.then(function(obj) {
  					console.log(obj);
  					$scope.grade = obj.data;
  					$scope.tradeAjax(obj.data.id);
  				});
  			};
  			$scope.maxGrade();
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
  			//页面加载禁用添加按钮
  			$("#addPlayer").attr("disabled",true);
  			//选择球队
  			$scope.sel = [1,2];
  			var tid1 = 0;
  			var tid2 = 0;
  			$scope.TcnameToInput = function(tcname,s,tid){
  				$("#xz"+s).hide();
  				$("#tradePlayer").children().remove();
  				$("#selTeam"+s).text(tcname);
  				$("#teamid"+s).val(tid);
  				if($("#teamSum"+s).length>0){
  					$("#teamSum"+s).attr("id","teamSum"+tid);
  					if(s==1){
  						tid1 = tid;
  					}else{
  						tid2 = tid;
  					}
  				}else{
  					if(s==1){
  						$("#teamSum"+tid1).attr("id","teamSum"+tid);
  						tid1 = tid;
  					}else{
  						$("#teamSum"+tid2).attr("id","teamSum"+tid);
  						tid2 = tid;
  					}
  				}
  				if($("#selTeam1").text()!=''&&$("#selTeam2").text()!=''){
  					$("#addPlayer").attr("disabled",false);
  				}
  				
  			};
  			//选择加载球员
  			$scope.playerAjax = function(tid){
	  				$http({
	  					method: "post",
	  					url: "Team/queryPlayer.do",
	  					params: {
	  						"gid":$("#selGrade").val(),
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
  			
			/* 发起交易 */
  			$scope.publishTrade = function(){
  				var pids1 = [];
  				var pids2 = [];
  				for(var i = 1; i<=pos1;i++){
  					if($("#hidden"+$("#teamid1").val()+i).val()!=''&&$("#hidden"+$("#teamid1").val()+i).val()!=null){
		  				pids1.push($("#hidden"+$("#teamid1").val()+i).val());
  					}
  					if($("#hidden"+$("#teamid2").val()+i).val()!=''&&$("#hidden"+$("#teamid2").val()+i).val()!=null){
	  					pids2.push($("#hidden"+$("#teamid2").val()+i).val());
  					}
  				}
  				 $http({
  					url: "Trade/publishTrade.do",
  					method: "post",
  					params: {
  						"ps1":pids1,
  						"ps2":pids2,
  						"t1":$("#teamid1").val(),
  						"t2":$("#teamid2").val(),
  						"price1":$("#teamSum"+$("#teamid1").val()).text(),
  						"price2":$("#teamSum"+$("#teamid2").val()).text(),
  						"gid":$("#selGrade").val()
  					}
  				}).then(function(resp) {
  					alert(resp.data.meg);
  				},function(reason){
  					console.log(reason);
  				 }); 
  			};
  			
  			//添加球员栏
  			var pos1 = 1;
  			var pos2 = 1;
  			$("#addPlayer").click(function(){
  				var html = "<tr><td><input name='hiddenPlayerId' type='hidden' id='hidden"+$("#teamid1").val()+pos1+"'/><span id='span"+$("#teamid1").val()+pos1+"'></span><a id='pos"+$("#teamid1").val()+pos1+"' ng-click='playerAjax("+$("#teamid1").val()+")' data-target='#player"+$("#teamid1").val()+"' data-toggle='modal'>选择</a></td><td id='price"+$("#teamid1").val()+pos1+++"'></td><td id='price"+$("#teamid2").val()+pos2+"'></td><td><span id='span"+$("#teamid2").val()+pos2+"'></span><input type='hidden' name='hiddenPlayerId' id='hidden"+$("#teamid2").val()+pos2+"'/><a data-target='#player"+$("#teamid2").val()+"' data-toggle='modal' ng-click='playerAjax("+$("#teamid2").val()+")' id='pos"+$("#teamid2").val()+pos2+++"'>选择</a></td></tr>";
  				var $html = $compile(html)($scope);
  				$("#tradePlayer").append($html);
  			});
  			//添加球员到交易栏
  			$scope.addPlayerToTrade= function(cname,tid,price,pid){
  				for(x in $("input[name='hiddenPlayerId']")){
  					if(pid == $("input[name='hiddenPlayerId']").eq(x).val()){
  						alert("请勿添加重复球员");
  						return;
  					}
  				}
  				var sum = $("#teamSum"+tid).text();
  				if(sum==''){
  					sum = 0;
  				}
  				sum = parseInt(sum) + parseInt(price);
  				$("#teamSum"+tid).text(sum);
  				alert("tid"+tid);
  				for(var i = 1;i<=pos1;i++){
  					if($("#span"+tid+i).length>0&&$("#span"+tid+i).text()==''){
  						$("#span"+tid+i).text(cname);
  						$("#price"+tid+i).text(price);
  						$("#hidden"+tid+i).val(pid);
  		  				$("#pos"+tid+i).remove();
  		  				break;
  					}
  				}
  			};
  			$scope.addTradeOn = function(tid,pid){
  				$http({
  					url: "Trade/TradeOnPlayer.do",
  					params: {
  						"tid":tid,
  						"pid":pid,
  						"tradeContext":$("#tradeContext"+pid).val(),
  						"gid":$("#selGrade").val()
  					}
  				}).then(function(value) {
  					$scope.tradeAjax($("#selGrade").val());
  				}, function(reason) {
  					alert("挂牌失败");
  				});
  			};
  			
  			
  			/* 改变届数时调用 */
  			$("#selGrade").change(function(){
  				$scope.tradeAjax($(this).val());
  				$("#tradePlayer").children().remove();
  				$("span[name='priceName']").text("");
  				$("#addPlayer").attr("disabled",true);
  				for(s in $scope.sel){
  					$("#xz"+$scope.sel[s]).show();
  					$("#selTeam"+$scope.sel[s]).text("");
  				}
  			});
  		}); 		
  	</script>
  </head>
  <body>
  	<div  ng-app="tradeApp" ng-controller="tradeCtrl">
	<div id="navDiv">
	</div>
	<div class="row-fluid">
		<div class="col-sm-12">
			<div class="tabbable tabs-left" id="tabs-1">
				<ul class="nav nav-tabs">
					<li class="active">
						<a href="#panel-1" data-toggle="tab">交易信息</a> 
					</li>
					<li>
						<a href="#panel-2" data-toggle="tab" ng-if="myteam!=null">交易挂牌</a>
					</li>
					<c:if test="${u.power.id>=2 }">
					<li>
						<a href="#panel-3" data-toggle="tab">交易发起</a> 
					</li>
					</c:if>
					<li>
							<select  id="selGrade" class='form-control' style="width:250px;height:50px;font: bold 20px '微软雅黑'">
							</select>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div  class="tab-content" id="panel">
		<!-- 交易模块 -->
		<div class="col-sm-10 col-sm-offset-1 tab-pane active" id="panel-1">
			<p></p>
			<table class="table table-bordered">
				<thead>
					<tr>
						<td class="col-sm-2">球队</td>
						<td class="col-sm-2">交易价格</td>
						<td class="col-sm-2">球队</td>
						<td class="col-sm-2">交易状态</td>
						<td class="col-sm-2">交易时间</td>
						<td class="col-sm-2">操作</td>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="t in ts">
						<td class="col-sm-2">{{t.ts[0].tcname}}</td>			
						<td class="col-sm-2">{{t.tradePrice}}</td>	
						<td class="col-sm-2">{{t.ts[1].tcname}}</td>	
						<td class="col-sm-2">
							<span ng-if="t.state==2" class="label label-danger">已拒绝</span>
							<span ng-if="t.state==1" class="label label-success">交易完成</span>
							<span ng-if="t.state==0" class="label label-warning">待审核</span>
						</td>	
						<td class="col-sm-2">{{t.tradeDate | date:"yyyy-MM-dd HH:mm:ss"}}</td>		
						<td class="col-sm-2">
						<div class="btn-group btn-group-xs">
						<button class="btn btn-xs btn-default" data-target="#viewTrade{{t.id}}" data-toggle="modal" ng-click="viewPlayer()">查看</button>
						<c:if test="${u.power.id>=3}">
						<button ng-if="t.state==0" class="btn btn-xs btn-default" ng-click="passTrade(t.id)">通过</button>
						<button ng-if="t.state==0" class="btn btn-xs btn-default" ng-click="rejectTrade(t.id)">驳回</button></td>
						</c:if>	
						</div>
					</tr>
				</tbody>
			</table>
		</div>
	<!-- 2号版面  交易挂牌-->
		<div id="panel-2" class="tab-pane col-sm-10 col-sm-offset-1" >
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="col-sm-2">经理</th>
						<th class="col-sm-2">球队</th>
						<th class="col-sm-2">挂牌球员</th>
						<th class="col-sm-4">挂牌描述</th>
						<th class="col-sm-2">挂牌时间</th>
					</th>
				</thead>
				<tbody>
					<tr ng-repeat="t in tos">
						<td>{{t.user.pname}}</td>
						<td>{{t.team.tcname}}</td>
						<td>{{t.player.cname}}</td>
						<td>{{t.tradeContext}}</td>
						<td>{{t.tradeOnDate | date:'yyyy-MM-dd HH:mm:ss'}}</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5">
						<button class="btn btn-primary btn-lg btn-block center-block" style="margin: auto" data-target="#addTradeOn" data-toggle="modal">球员挂牌</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<!-- 添加挂牌交易 模态框 -->
		<div  class="modal fade" id="addTradeOn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog" style="width:80%" >
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title text-center" id="myModalLabel">
							{{myteam.tcname }}
							<!-- <span style="font:bold;color:red" ng-if="d.team.id == t.id">({{d.u.pname }})</span> -->
						</h4>
					</div>
					<div class="modal-body">
						<table class='table table-striped'>
							<thead><tr>
								<th class="col-sm-2">英文名称</th>
								<th class="col-sm-1">中文名称</th>	
								<th class="col-sm-1">位置</th>
								<th class="col-sm-1">能力值</th>
								<th class="col-sm-1">轮次</th>
								<th class="col-sm-1">徽章</th>
								<th class="col-sm-1">价格</th>
								<th class="col-sm-1">原球队</th>
								<th class="col-sm-2">描述</th>
								<th class="col-sm-1">操作</th>
							</tr></thead>
							<tbody>
								<tr ng-repeat="p in myps">
								<td><div style="overflow: hidden;height: 25px">{{p.ename }}</div></td>
								<td><div style="overflow: hidden;height: 25px">{{p.cname }}</div></td>
								<td>{{p.position }}</td>
								<td>{{p.ability }}</td>
								<td>{{p.round }}</td>
								<td>{{p.badges }}</td>
								<td>{{p.price }}</td>
								<td>{{p.tname }}</td>
								<td><input type="text" class="form-Control" id="tradeContext{{p.id}}" /></td>
								<td><a ng-click="addTradeOn(myteam.id,p.id)" data-dismiss="modal" id="guapai{{p.id}}">挂牌</a></td>						
								</tr>
							</tbody>
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
		
		
		
		<div id="panel-3" class="tab-pane col-sm-8 col-sm-offset-2" >
		<br/>
			<table class="table table-bordered text-center">
				<thead>
				<tr>
					<td colspan="2" >球队A：<input type="hidden" id="teamid1"/><span id="selTeam1" style="margin-right: 20px"></span><a data-toggle="modal" data-target="#team1" id="xz1">选择</a></td>
					<td colspan="2" >球队B：<input type="hidden" id="teamid2"/><span id="selTeam2" style="margin-right: 20px"></span><a data-toggle="modal" data-target="#team2" id="xz2">选择</a></td>
				</tr>
				<tr>
					<td>球员</td>
					<td>价值</td>
					<td>价值</td>
					<td>球员</td>
				</tr>
				</thead>
				<tbody  id="tradePlayer">
				
				</tbody>
				<tfoot>
					<tr>
						<td style="col-sm-3">总价值：<span id="teamSum1" name="priceName"></span></td>
						<td style="col-sm-3"><button class="btn btn-default" style="width:100px; " id="addPlayer">添加</button></td>
						<td style="col-sm-3"><button class="btn btn-default" style="width:100px;"  ng-click="publishTrade()">提交</button></td>
						<td style="col-sm-3">总价值：<span id="teamSum2"  name="priceName"></span></td>
					</tr>
				</tfoot>
			</table>
			<p style="color: red">注:必须先选择球队才能够添加球员栏</p>
		</div>
		
		<!-- 添加 模态框 -->
		<div ng-repeat="s in sel" class="modal fade" name='myModalAdddiv' id='team{{s}}' tabindex="-1" role="dialog"
			aria-labelledby="updateTeamLaber" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title text-center" id="updateTeamLaber">添加至球队</h4>
					</div>
					<div class="modal-body" align='center'>
						<button name="buttonTeam" class='btn btn-default' style="margin: 10px" ng-repeat="t in teams" ng-click="TcnameToInput(t.tcname,s,t.id)" data-dismiss="modal">
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
		
		<!-- 添加球员至交易栏 模态框 -->
		<div ng-repeat="t in teams" class="modal fade" id="player{{t.id}}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog" style="width:80%" >
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title text-center" id="myModalLabel">
							{{t.tcname }}
							<!-- <span style="font:bold;color:red" ng-if="d.team.id == t.id">({{d.u.pname }})</span> -->
						</h4>
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
								<th>操作</th>
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
								<td><a ng-click="addPlayerToTrade(p.cname,t.id,p.price,p.id)" data-dismiss="modal">选择</a></td>						
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
		
		<div ng-repeat="t in ts" class="modal fade" id="viewTrade{{t.id}}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog" style="width:80%" >
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title text-center" id="myModalLabel">
							交易详情
							<!-- <span style="font:bold;color:red" ng-if="d.team.id == t.id">({{d.u.pname }})</span> -->
						</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered text-center">
							<thead>
							<tr>
								<td colspan="2" ><span  style="margin-right: 20px">{{t.ts[0].tcname}}</span></td>
								<td colspan="2" ><span  style="margin-right: 20px">{{t.ts[1].tcname}}</span></td>
							</tr>
							<tr>
								<td>球员</td>
								<td>价值(轮数)</td>
								<td>价值(轮数)</td>
								<td>球员</td>
							</tr>
							</thead>
							<tbody id="viewPlayerBody{{t.id}}">
								
							</tbody>
							<tfoot>
								
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