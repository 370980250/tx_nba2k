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
  	<style type="text/css">
  	#panel li{
  		list-style: none;
  	}
  	</style>
  	<script type="text/javascript">
  		var app=  angular.module('draftApp',[]);
  		app.controller('draftCtrl', function($scope,$http) {
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
  			/* 读取队伍 */
			$scope.loadTeamVal = function(){
  				for(var i =0;i<$scope.ps.length;i++){
  					for(var j = 0;j<$scope.ts.length;j++){
  						if($scope.ts[j].pickid == $scope.ps[i].pick){
  	  						$("#input"+$scope.ps[i].pick).val($scope.ts[j].tcname);
  	  					}
  					}
  				}
  			}
  			
  			/* 加载选秀栏 */
  			$scope.draftAjax = function(id){
  				$http({
  					url: "Draft/queryDraftList.do",
  					params: {"gid":id}
  				}).then(function(resp) {
  					console.log(resp);
  					$scope.ds= resp.data.ds;
  					$scope.ps = resp.data.ps;
  					$scope.ts = resp.data.ts;
  					$scope.loadTeamVal();
  				});
  			};
  			
  			
  			/*查看是否可报名*/
  			$scope.isJoin = function(id){
  				$http({
  					url: "Draft/queryGradeById.do",
  					params: {"id":id}
  				}).then(function(resp) {
  					console.log(resp);
  					$scope.grade = resp.data;
  					$("input[name='join'][value='"+$scope.grade.state+"']").prop("checked",true);
  					$("input[name='draw'][value='"+$scope.grade.allowDraw+"']").prop("checked",true);
  					if(resp.data.state==0){
  	  					$("#join").attr("disabled",true);
  	  				}else{
  	  					$("#join").attr("disabled",false);
  	  				}
  					if(resp.data.allowDraw==0){
  						$("#draw").attr("disabled",true);
  	  				}else{
  	  					$("#draw").attr("disabled",false);
  	  				}
  				});
  			};
  			
  			/* 管理员通过审核 */
  			$scope.passJoin = function(id){
  				$http({
  					url: "Draft/passJoin.do",
  					params: {"id":id,"gid":$("#selGrade").val()}
  				}).then(function(resp) {
  					console.log(resp);
  					$scope.draftAjax($("#selGrade").val());
  				});
  			}
  			
  			/*抽签*/
  			$scope.drawInTonight = function(){
  				if($("#draw").attr("disabled")!="disabled"){
	  				$http({
	  					url: "Draft/drawInTonight.do",
	  					params: {"gid":$("#selGrade").val()}
	  				}).then(function(resp) {
	  					console.log(resp);
	  					alert(resp.data.meg);
	  					$scope.draftAjax($("#selGrade").val());
	  				});
  				}
  			}
  			
  			/*改变届数时保证但联赛默认按钮选择不能*/
  			function baozheng(){
  				$("#noDan").prop("checked",true);
  			}
  			
  			
  			/* 创建联赛 */
  			 $scope.createLeague = function(){
  				 var fd = new FormData();
  				 var file = document.querySelector("input[type='file']").files[0];
  				 fd.append("PlayerFileUp",file);
  				alert(fd.length);
  				$http({
  					method: "post",
  					url: "Draft/createLeague.do",
  					params: {"gname":$("#gname").val(),
  						"drawTitle":$("#drawTitle").val(),
  						"drawContext":$("#drawContext").val(),
  						"joinTitle":$("#joinTitle").val(),
  						"joinContext":$("#joinContext").val()
  					}, 
  					data: fd,
  					headers:{'Content-Type':undefined},
  					transformRequest: angular.identity 
  				}).then(function(resp) {
  					console.log(resp);
  					alert(resp.data.meg);
  					location.href="2k/draft.jsp";
  				}); 
  			} ;
  			
  			/* 修改联赛 */
  			$scope.updateGrade = function(){
  				$http({
  					method: "post",
  					url: "Draft/updateGrade.do",
					params: {
						"gname":$("#mgname").val(),
  						"drawTitle":$("#mdrawTitle").val(),
  						"drawContext":$("#mdrawContext").val(),
  						"joinTitle":$("#mjoinTitle").val(),
  						"joinContext":$("#mjoinContext").val(),
  						"allowDraw":$("input[name='draw']:checked").val(),
  						"state":$("input[name='join']:checked").val(),
  						"id":$scope.grade.id
  					}
  				}).then(function(resp) {
  					console.log(resp);
  					alert(resp.data.meg);
  					$scope.maxGrade();
  				});
  			};
  			/* 修改顺位后保存设置 */
  			$scope.updateTeamBtn = function(){
  				var tname =[];
  				var pick = [];
  				for(var i = 0 ;i<$("input[name='inputTeam']").length;i++){
  					if($("input[name='inputTeam']").eq(i).val()!=null&&$("input[name='inputTeam']").eq(i).val()!=''){
  						tname.push($("input[name='inputTeam']").eq(i).val());
  						pick.push($("input[name='inputPick']").eq(i).val());
  					} 
  				}
				if(tname.length>0&&pick.length>0&&tname.length==pick.length){
					$http({
						method:"post",
	  					url: "Draft/updateTeamAndPick.do",
	  					params: {
	  						"tname":tname,
	  						"pick":pick,
	  						"gid":$scope.grade.id
	  					}
	  				}).then(function(resp) {
	  					console.log(resp);
	  					alert(resp.data.meg);
	  					$scope.maxGrade();
	  				});
				}
					

  			}
  			
  			/* 传球队名字给输入框 */
  			$scope.TcnameToInput = function(tcname,pick){
  				$("#input"+pick).val(tcname);
  			};
  			
  			
  			/* 改变届数时调用 */
  			$("#selGrade").change(function(){
  				//加载选秀栏
  				$scope.draftAjax($(this).val());
  				//查看是否可报名
  				$scope.isJoin($(this).val());
  				//改变届数默认不能
  				baozheng();
  			});
  			
  			/* 报名 */
  			$("#join").click(function(){
  				if($(this).attr("disabled")!="disabled"){
	  				$http({
	  					method: "post",
	  					url: "Draft/join.do",
	  					params: {"gid":$("#selGrade").val(),"yesDan":$("input[name='promise']:checked").val()}
	  				}).then(function(resp) {
	  					console.log(resp);
	  					if(resp.data.meg==true){
	  						alert("报名成功");
	  					}else{
	  						alert("报名失败");
	  					}
	  				});
  				}
  			});
  			
  			/* 修改球队归属及公告 */
  			$scope.updateDraft = function(id){
  				$http({
  					method: "post",
  					url:"Draft/updateDraft.do",
  					params: {
  						"id":id,
  						"pname":$("#pname"+id).val(),
  						"draftTitle":$("#draftTitle"+id).val(),
  						"draftContext":$("#draftContext"+id).val()
  					}
  				}).then(function(resp) {
  					console.log(resp);
  					location.href="2k/draft.jsp";
  				})
  			};
  			
  			/* 页面加载时获取当前最大届数 */
  			$scope.maxGrade = function(){
  				$http.get("Draft/queryMaxGrade.do")
  				.then(function(obj) {
  					$scope.draftAjax(obj.data.id);
  					$scope.isJoin(obj.data.id);
  					baozheng();
  				});
  			};
  			$scope.maxGrade();
  			
  			
  		});	
  		
  	</script>
  </head>
  <body>
  	<div ng-app="draftApp" ng-controller="draftCtrl" ng-cloak>
	  	<div id="navDiv">
		</div>
		<!-- draft页面 -->
		<div class="row-fluid">
			<div class="col-sm-12">
				<div class="tabbable tabs-left" id="tabs-1">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#panel-1" data-toggle="tab">选秀栏</a> 
						</li>
						<li>
							<a href="#panel-2" data-toggle="tab">联赛报名</a> 
						</li>
						<li>
							<a href="#panel-3" data-toggle="tab">参加选秀</a> 
						</li>
						<li>
							<a href="#panel-4" data-toggle="tab">选秀信息</a> 
						</li>
						<c:if test="${u.power.id>=3}">
						<li>
							<a href="#panel-5" data-toggle="tab">报名审核</a> 
						</li>
						</c:if>
						<c:if test="${u.power.id>=4}">
						<li>
							<a href="#panel-6" data-toggle="tab">创建联赛</a> 
						</li>
						<li>
							<a href="#panel-7" data-toggle="tab">联赛管理</a>
						</li>
						</c:if>
						<li>
							<select  id="selGrade" class='form-control' style="width:250px;height:50px;">
							</select>
						</li>
					</ul>
					
					<div  class="tab-content" id="panel">
						<!-- 选秀栏 -->
						<div class="tab-pane active" id="panel-1" style=" margin: auto">
							<li class="col-sm-4" ng-repeat="d in ds" >
								<div class="thumbnail" >
									<img  src="<%=basePath %>img/e1ced8404fb703cbfe52489384405b8d.jpg" />
									<div class="caption">
										<h3>
											{{d.draftTitle}}
										</h3>
										<p>
											{{d.draftContext}}
										</p>
										<c:if test="${u.power.id>=3}">
										<p>
											<a class="btn btn-primary"  data-toggle="modal" data-target="#updateDraft{{d.id}}">修改</a>
										</p>
										</c:if>
									</div>
								</div>
							</li>
						</div>

						<!-- 修改draft 模态框 -->
						<div ng-repeat="d in ds" class="modal fade" name='myModalUpdatediv' id='updateDraft{{d.id}}' tabindex="-1" role="dialog"
							aria-labelledby="updateDraftLaber" aria-hidden="false">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="true"></button>
										<h4 class="modal-title text-center" id="updateDraftLaber">修改<big style="color: red">{{d.u.pname}}</big></h4>
									</div>
									<div class="modal-body" align='center'>
										<form class="form-horizontal">
											<div class="form-group">
											    <label for="pname" class="col-sm-3 control-label">昵称:</label>
											     <input style="width:300px" type="text" class="form-control" name="pname" id="pname{{d.id}}" placeholder="请输入昵称" value="{{d.u.pname}}" readonly="readonly">
								  			</div>
								  			<div class="form-group">
											    <label for="draftTitle" class="col-sm-3 control-label">报名公告名:</label>
											     <input style="width:300px" type="text" class="form-control" name="draftTitle" id="draftTitle{{d.id}}" placeholder="请输入公告名" value="{{d.draftTitle}}">
								  			</div>
								  			<div class="form-group">
											    <label for="draftContext" class="col-sm-3 control-label">报名内容:</label>
								  				<textarea style="width: 300px" rows="4" id="draftContext{{d.id}}">{{d.draftContext}}</textarea>
								  			</div>
								  			<div class="form-group" style="margin: auto">
								  			<button type="button" class="btn btn-default" style="display: block;margin: auto" ng-click="updateDraft(d.id)" data-dismiss="modal" >修改</button>
											</div>
										</form>
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
					
						<!-- 联赛报名  -->
						<div class="tab-pane text-center" id="panel-2" style=" margin: auto">
							<div class="thumbnail col-sm-12 col-lg-6 col-lg-offset-3">
								<img  src="<%=basePath %>img/e1ced8404fb703cbfe52489384405b8d.jpg" />
								<div class="caption">
									<h3>
										{{grade.joinTitle}}
									</h3>
									<p>
										{{grade.joinContext}}
									</p>
									<p>
										保证单联赛：
										<input type="radio" id="yesDan" name="promise" value="1">能
										<input type="radio" id="noDan" name="promise" value="0">不能
									</p>
									<p>
									<span ng-if="grade.state==1" class="label label-success">可报名</span>
									<span ng-if="grade.state==0" class="label label-danger">不可报名</span>
									</p>
									<a class="btn btn-primary" id="join">报名</a>
								</div>
							</div>
						</div>
						<!-- 参加选秀 -->
						<div class="tab-pane" id="panel-3" style=" margin: auto">
							<div class="thumbnail col-sm-6 text-center col-sm-offset-3">
								<img  src="<%=basePath %>img/e1ced8404fb703cbfe52489384405b8d.jpg" />
								<div class="caption">
									<h3>
										{{grade.drawTitle}}
									</h3>
									<p>
										{{grade.drawContext}}
									</p>
									
									<a class="btn btn-primary" ng-click="drawInTonight()" id="draw">开始选秀</a>
								</div>
							</div>
						</div>
						
						<!-- 选秀信息 -->
						<div class="tab-pane" id="panel-4" style="margin: 0px">
							<table class="table table-striped ">
								<thead>
									<tr>
										<th>选秀顺位</th>
										<th>经理名</th>
										<th>球队名</th>
										<th>抽签时间</th>	
									</tr>
								</thead>
								<tbody>
									 <tr ng-if="d.state==1" ng-repeat="d in ds">
										<td>{{d.pickid==0?"":d.pickid}}</td>
										<td>{{d.u.pname}}</td>
										<td>{{d.team.tcname}}</td>
										<td>{{d.drawDate | date:"yyyy-MM-dd HH:mm:ss"}}</td>
									</tr> 
								</tbody>
							</table>
						</div>
						<!-- 报名审核  -->
						<div class="tab-pane" id="panel-5" style="margin: 0px">
							<table class="table table-striped ">
								<thead>
									<tr>
										<th>经理名</th>
										<th>管理员</th>
										<th>联赛名</th>
										<th>报名时间</th>
										<th>通过时间</th>	
										<th>报名状态</th>	
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<<tr ng-repeat="d in ds" >
										<td>{{d.u.pname}}</td>
										<td>{{d.admin.pname}}</td>
										<td>{{d.grade.gname}}</td>
										<td>{{d.joinDate | date:"yyyy-MM-dd hh:mm:ss"}}</td>
										<td>{{d.passDate | date:"yyyy-MM-dd hh:mm:ss"}}</td>
										<td>
										<span ng-if="d.state==1" class="label label-success">已通过</span>
										<span ng-if="d.state==0" class="label label-danger">未通过</span>
										</td>
										<td><button ng-if="d.state==0" class="btn btn-default" ng-click="passJoin(d.u.id)">通过</button></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- 创建联赛 -->
						<div class="tab-pane" id="panel-6" style="margin:0px">
							<div class="thumbnail col-sm-12 col-lg-4 col-lg-offset-4">
								<div class="caption" >
									<form class="form-horizontal" id="createLeague" enctype= multipart/form-data>
										<div class="form-group">
										    <label for="gname" class="col-sm-2 control-label">联赛名称:</label>
										     <input style="width:300px" type="text" class="form-control" name="gname" id="gname" placeholder="请输入联赛名称">
							  			</div>
							  			<div class="form-group">
										    <label for="joinTitle" class="col-sm-2 control-label">报名公告名:</label>
										     <input style="width:300px" type="text" class="form-control" name="joinTitle" id="joinTitle" placeholder="请输入报名公告名">
							  			</div>
							  			<div class="form-group">
										    <label for="joinContext" class="col-sm-2 control-label">报名内容:</label>
							  				<textarea style="width: 300px" rows="4" id="joinContext"></textarea>
							  			</div>
							  			<div class="form-group">
										    <label for="drawTitle" class="col-sm-2 control-label">选秀公告名:</label>
										     <input style="width:300px" type="text" class="form-control" name="drawTitle" id="drawTitle" placeholder="请输入抽签公告名">
							  			</div>
							  			<div class="form-group">
										    <label for="drawContext" class="col-sm-2 control-label">选秀内容:</label>
							  				<textarea style="width:300px" rows="4" id="drawContext"></textarea>
							  			</div>
										 <div class="form-group">
										    <label class="col-sm-2 control-label" for="PlayerFileUp">请上传球员名单:</label>
										 	 <input type="file" id="PlayerFileUp" name="PlayerFileUp"  multiple="multiple">
							  			</div>
							  			<div class="form-group" style="margin: auto">
							  			<button type="button" class="btn btn-default" style="display: block;margin: auto" ng-click="createLeague()">创建联赛</button>
										</div>
									</form>
								</div>
							</div>
						</div>
						
						<!-- 联赛管理 -->
						<div class="tab-pane" id="panel-7" style="margin:0px">
							<div class="thumbnail col-sm-5">
								<div class="caption">
									<form class="form-horizontal">
										<div class="form-group">
										    <label for="mgname" class="col-sm-2 control-label">联赛名称:</label>
										     <input style="width:300px" type="text" class="form-control" name="mgname" id="mgname" placeholder="请输入联赛名称" value="{{grade.gname}}">
							  			</div>
							  			<div class="form-group">
										    <label for="mjoinTitle" class="col-sm-2 control-label">报名公告名:</label>
										     <input style="width:300px" type="text" class="form-control" name="mjoinTitle" id="mjoinTitle" placeholder="请输入报名公告名" value="{{grade.joinTitle}}">
							  			</div>
							  			<div class="form-group">
										    <label for="mjoinContext" class="col-sm-2 control-label">报名内容:</label>
							  				<textarea style="width: 300px" rows="4" id="mjoinContext">{{grade.joinContext}}</textarea>
							  			</div>
							  			<div class="form-group">
										    <label for="mdrawTitle" class="col-sm-2 control-label">选秀公告名:</label>
										     <input style="width:300px" type="text" class="form-control" name="mdrawTitle" id="mdrawTitle" placeholder="请输入抽签公告名" value="{{grade.drawTitle}}">
							  			</div>
							  			<div class="form-group">
										    <label for="mdrawContext" class="col-sm-2 control-label">选秀内容:</label>
							  				<textarea style="width:300px" rows="4" id="mdrawContext">{{grade.drawContext}}</textarea>
							  			</div>
							  			<div class="form-group">
							  				报名开启：
							  				<input type="radio" value="1" name="join"  /> <span class="glyphicon glyphicon-ok"></span>
							  				<input type="radio" value="0" name="join"  /> <span class="glyphicon glyphicon-remove"></span>
							  			</div>
							  			<div class="form-group">
							  				抽签开启：
							  				<input type="radio" value="1" name="draw"  /> <span class="glyphicon glyphicon-ok"></span>
							  				<input type="radio" value="0" name="draw"  /> <span class="glyphicon glyphicon-remove"></span>
							  			</div>
							  			<div class="form-group" style="margin: auto">
							  			<button type="button" class="btn btn-default" style="display: block;margin: auto" ng-click="updateGrade()">修改联赛</button>
										</div>
									</form>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="col-sm-4">
									<ul>
										<li  ng-repeat="p in ps" ng-if="p.pick<=10">第{{p.pick}}顺位:<input type="hidden" value="{{p.pick}}" name="inputPick"><input type="text" style="width:100px" name="inputTeam" id="input{{p.pick}}" readonly="readonly" /><p><a data-target="#updateTeam{{p.pick}}" data-toggle="modal">修改</a></p></li>
									</ul>
								</div>
								<div class="col-sm-4">
									<ul>
										<li ng-if="p.pick<=20 && p.pick>10" ng-repeat="p in ps">第{{p.pick}}顺位:<input type="hidden" value="{{p.pick}}" name="inputPick"><input type="text" style="width:100px" name="inputTeam" id="input{{p.pick}}" readonly="readonly"/><p><a data-target="#updateTeam{{p.pick}}" data-toggle="modal">修改</a></p></li>
									</ul>
								</div>
								<div class="col-sm-4">
									<ul>
										<li ng-if="p.pick<=30 && p.pick>20" ng-repeat="p in ps">第{{p.pick}}顺位:<input type="hidden" value="{{p.pick}}" name="inputPick"><input type="text" style="width:100px" name="inputTeam" id="input{{p.pick}}" readonly="readonly"/><p><a data-target="#updateTeam{{p.pick}}" data-toggle="modal">修改</a></p></li>
									</ul> 
								</div>
								<span style="display:block;margin: auto;">
								<button class="btn btn-default"  ng-click="loadTeamVal()">读取设置</button>
								<button class="btn btn-default"  ng-click="updateTeamBtn()">保存设置</button>
								</span>
							</div>
						</div>
						<!-- 添加 模态框 -->
						<div ng-repeat="p in ps" class="modal fade" name='myModalAdddiv' id='updateTeam{{p.pick}}' tabindex="-1" role="dialog"
							aria-labelledby="updateTeamLaber" aria-hidden="false">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="true"></button>
										<h4 class="modal-title text-center" id="updateTeamLaber">添加至球队</h4>
									</div>
									<div class="modal-body" align='center'>
										<button name="buttonTeam" class='btn btn-default' style="margin: 10px" ng-repeat="t in ts" ng-click="TcnameToInput(t.tcname,p.pick)" data-dismiss="modal">
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
					</div>
				</div>
			</div>
		</div>	
		<!-- -------------------------------------------------- -->
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
