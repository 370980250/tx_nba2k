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
  		var app=  angular.module('mainApp',[]);
  		app.controller('mainCtrl', function($scope,$http) {
  			denglu($scope, $http);
  			zhuxiao($scope, $http);
  			zhuce($scope,$http);
  			regUser($scope,$http);
  		}); 		
  	</script>
  </head>
  <body>
  	<div  ng-app="mainApp" ng-controller="mainCtrl">
	<div id="navDiv">
	</div>
	<div id="myCarousel" class="carousel slide">
		<!-- 轮播（Carousel）指标 -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>
		<!-- 轮播（Carousel）项目 -->
		<div class="carousel-inner">
			<div class="item active">
				<img src="img/567b539281c52df73f1581c39ccdb7c2.jpg"
					style="margin: auto; width: 100%; height: 100%"
					alt="First slide">
				<!--  	<div class="carousel-caption">标题 1</div>-->
			</div>
			<div class="item">
				<img src="img/ntk-1648-47146.jpg"
					style="margin: auto; width: 100%; height: 100%"
					alt="Second slide">
				<!--  	<div class="carousel-caption">标题 2</div>-->
			</div>
			<div class="item">
				<img src="img/ntk-1646-47107.jpg"
					style="margin: auto; width: 100%; height: 100%"
					alt="Third slide">
				<!--  	<div class="carousel-caption">标题 3</div>-->
			</div>
		</div>
		<!-- 轮播（Carousel）导航 -->
		<a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;
		</a> <a class="carousel-control right" href="#myCarousel"
			data-slide="next">&rsaquo; </a>
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

