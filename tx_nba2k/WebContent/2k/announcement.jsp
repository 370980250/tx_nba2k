<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<meta name="viewport" contents="width=device-width,initial-scale=1">
	<script
	  src="http://code.jquery.com/jquery-3.2.1.min.js"
	  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	  crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  	<script src="https://cdn.bootcss.com/angular.js/1.5.8/angular.min.js"></script>
 	<script type="text/javascript" src="<%=basePath %>js/public.js"></script>
 	<script type="text/javascript">
 	var app = angular.module('annoApp',[]);
 	app.controller('annoCtrl', function($scope,$http) {
 		denglu($scope, $http);
 		zhuxiao($scope, $http);
 		zhuce($scope,$http);
 		$scope.initAnno = function(){
			$http.get("Anno/queryAnno.do").then(function(obj) {
				console.log(obj);
				$scope.as = obj.data;
			});
		};
		$scope.initAnno();
		
		
		$scope.deleteAnno = function(id){
			
				$http({
					method: "post",
					params: {"id":id},
					url: "Anno/deleteAnno.do"
				}).then(function(obj) {
					$scope.initAnno();
				});
			
		};
		
		$scope.updateAnno = function(id){
			$http({
				method: "post",
				params:{"id":id,"title":$("#utitle"+id).val(),"context":$("#ucontext"+id).val()},
				url: "Anno/updateAnno.do"		
			}).then(function(obj) {
				var text = window.location.href;
				location.href = text;
				$scope.initAnno();
			});
		};
		
		$scope.addAnno = function(){
			$http({
				method: "post",
				params: {"title":$("#atitle").val(),"context":$("#acontext").val()},
				url: "Anno/addAnno.do"
			}).then(function(value) {
				$scope.initAnno();
			});
		};
		
		
		
		$scope.deleteAnno = function(id){
			$http({
				method: "post",
				params: {"id":id},
				url: "Anno/deleteAnno.do"
			}).then(function(value) {
				$scope.initAnno();
			});
		};
 	})
 	</script>
 	<style type="text/css">
 		.login_input{
 			margin: 10px;
 		}

  </head>
  <body> 
 	<div  ng-app="annoApp" ng-controller="annoCtrl" ng-cloak>
	 <div id="navDiv" >
		 
	 </div>
	 <div class="col-sm-12 col-lg-8 col-lg-offset-2">
		<div class="panel panel-default">
			<div class="panel-heading">公告</div>
			<ul class="list-group">		
				<li class="list-group-item" ng-repeat="a in as">
					<a data-toggle="modal"
					data-target="#myModalNotice{{a.id}}"  >{{a.title}}&nbsp;&nbsp;&nbsp;<small>({{a.releaseDate | date:"yyyy-MM-dd"}})</small></a>
					<c:if test="${!empty u and u.power.id>=3 }">
					<button class='btn btn-default' data-target="#removeAnno{{a.id}}" data-toggle="modal" >
					删除
					</button>
					<button class='btn btn-default'  data-target="#myModalUpdateNotice{{a.id}}" data-toggle="modal">
					 更改
					</button>
					</c:if>
				</li>
				<c:if test="${!empty u and u.power.id>=3 }">
				<li class='list-group-item'>
					<button class='btn btn-default' data-toggle="modal"
							data-target="#myModalAddNotice" >
					添加公告
					</button>
				</li>
				</c:if>
			</ul>
		</div>
		<div id="loginDiv"></div>
		<div id="registerDiv"></div>
		<script>
			$("#loginDiv").load("2k/login.jsp");
			$("#registerDiv").load("2k/register.jsp");
			$("#navDiv").load("2k/nav.jsp");
		</script>
		<!-- 确认删除模态框 -->
		<div ng-repeat="a in as" class="modal fade"  id="removeAnno{{a.id}}" tabindex="-1" role="dialog" 
			aria-labelledby="MyModalLabelRemove" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body text-center">
						确认删除？
					</div>
					<div class="modal-foot text-center" style="height: 100px">
						<button type="button" class="btn btn-default" ng-click="deleteAnno(a.id)">确认
						</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">取消
						</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 公告信息 模态框 -->
		<div ng-repeat="a in as" class="modal fade" id="myModalNotice{{a.id}}" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabelNotice" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title text-center" id="myModalLabelNotice">{{a.title}}</h4>
					</div>
					<div class="modal-body" align='center'>
						<div>{{a.context}}</div>
						<div class='text-right'>
						{{a.releaseDate | date:'yyyy-MM-dd'}}
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
		
		<!-- 更新公告  -->
		<div ng-repeat="a in as" class="modal fade" id="myModalUpdateNotice{{a.id}}" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabelUpdateNotice" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title text-center" id="myModalLabelUpdateNotice">更改公告</h4>
					</div>
					<div class="modal-body" align='center'>
						<div class='input-group login_input'>
								<span class='input-group-addon'>公告标题：</span>
								<input type='text' class='form-control' id="utitle{{a.id}}"  name='utitle' value='{{a.title}}'/>
							</div>
							<div class='input-group login_input'>
								<span class='input-group-addon'>公告内容：</span><textarea rows="10" class='form-control' id="ucontext{{a.id}}" name='ucontext' >{{a.context}}</textarea>
							</div>
							<div class='btn-group login_input' >
								<input type='button' class='btn btn-default' value="更改公告"
									style="width: 200px; margin: 5px" data-dismiss="modal" ng-click="updateAnno(a.id)" />
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
		
		
		
		<!-- 添加公告 模态框 -->
		<div class="modal fade" id="myModalAddNotice" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabelAddNotice" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title text-center" id="myModalLabelAddNotice">添加公告</h4>
					</div>
					<div class="modal-body" align='center'>
						<div class='input-group login_input'>
								<span class='input-group-addon'>公告标题：</span>
								<input type='text' class='form-control' id="atitle" name='atitle' />
							</div>
							<div class='input-group login_input'>
								<span class='input-group-addon'>公告内容：</span><textarea rows="10" class='form-control' id="acontext" name='acontext'></textarea>
							</div>
							<div class='btn-group login_input'>
								<input type='button' class='btn btn-default' value="添加公告"
									style="width: 200px; margin: 5px" id='addNotice' ng-click="addAnno()"  data-dismiss="modal"/>
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
		</div>
	</div>
  </body>
</html>