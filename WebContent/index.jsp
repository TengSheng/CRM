﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>登录</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/vector.js"></script>

</head>
<body>

<div id="container">
	<div id="output">
		<div class="containerT">
			<h1>用户登录</h1>
			<form action="${pageContext.request.contextPath}/user/login.do" id="entry_form" method="post">
				<input class="aa" type="text" placeholder="用户名" id="entry_name" name="userName" value="${user.userName}">
				<input class="aa" type="password" placeholder="密码" id="entry_password" name="password" value="${user.password}">
				<input type="checkbox" name="keep" value="1">一周免登陆<br/>
				<button type="submit" id="entry_btn">登录</button>
				<br/><br/><font color="red">${errorMsg}</font>
				<div id="prompt" class="prompt"></div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
    $(function(){
        Victor("container", "output");   //登录背景函数
        $("#entry_name").focus();
        $(document).keydown(function(event){
            if(event.keyCode==13){
                $("#entry_btn").click();
            }
        });
    });
</script>
<div style="text-align:center;">
<p>更多模板：<a href="http://www.mycodes.net/" target="_blank">源码之家</a></p>
</div>
</body>
</html>