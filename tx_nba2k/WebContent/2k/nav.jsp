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
	
	<style type="text/css">
 	.nav li {
	width: 120px;
	font-size: 20px;
	}
 	
 	</style>
  </head>
  <body>
  		<nav class='navbar navbar-inverse' role="navigation"
		style='margin:0px'>
		<div class="container-fluid">
			<c:choose>
				<c:when test="${!empty u }">
					<div class="navbar-header">
						<div class="navbar-brand">
							欢迎<span style="font: bold 20px '微软雅黑'; color: red;">${u.pname }</span>!!
						</div>
						<div class="navbar-brand dropdown">
						    <a class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">个人设置
						        <span class="caret"></span>
						    </a>
						    <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="dropdownMenu1">
						        <li role="presentation">
						            <a role="menuitem" tabindex="-1" href="2k/user.jsp">个人资料</a>
						        </li>
						        <c:if test="${u.power.id==4 }">
						        <li role="presentation">
						            <a role="menuitem" tabindex="-1" href="2k/power.jsp">权限管理</a>
						        </li>
						        </c:if>
						        <li role="presentation" class="divider"></li>
						        <li role="presentation">
						            <a role="menuitem" tabindex="-1"  ng-click="exit()">注销</a>
						        </li>
						    </ul>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="navbar-header">
						<div class="navbar-brand">
							您好，请<a data-toggle="modal" data-target="#myModalLogin"
								style="cursor: pointer;">登录</a>或<a data-toggle="modal"
								data-target="#myModalRegister" style="cursor: pointer";>注册</a>
						</div>
					</div>
				</c:otherwise>
				
			</c:choose>
			<div>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="2k/main.jsp">首页</a></li>
					<li><a href="2k/announcement.jsp">公告</a></li>
					<li><a href="2k/draft.jsp">选秀</a></li>
					<li><a href="2k/trade.jsp">转会</a></li>
					<li><a href="2k/player.jsp">球员</a></li>
					<li><a href="2k/team.jsp">球队</a></li>
					<li><a href="2k/rank.jsp">排名</a></li>
					<li><a href="2k/result.jsp">季后赛</a></li>
				</ul>
			</div>
		</div>
	</nav>
  </body>
</html>