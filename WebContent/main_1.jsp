<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.sm1234.domain.User"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="easyui/jquery.min.js"></script>
		<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
		<link id="themeLink" rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
		<script type="text/javascript" src="js/pageURL.js"></script>
	</head>
	<body class="easyui-layout">
		<%
			String userName = (String)session.getAttribute("currentUser");
			User user = (User)session.getAttribute(userName);
			
			Cookie cookie = null;
			Cookie[] cookies = null;
			cookies = request.getCookies();
			
			if(user == null && cookies == null)
			    response.sendRedirect("index.jsp");
			else{
				// 判断是否存在用户名cookie,存在就输出,不存在跳转到登录页面
				// System.out.println("cookies.length:" + cookies.length);
				cookie = getCookieByName(cookies, "username");
				
				if (cookie != null) {
					System.out.println("登陆成功! welcome:" + cookie.getValue() + "!---cookie方式");
				}
				else if (session.getAttribute(userName) != null) {
					System.out.println("登陆成功! Welcome:" + user.getUserName() + "!---session方式");
				}
				else {
					response.sendRedirect("index.jsp");
				}
			}
		%>
		<%!// 创建方法,用于查找指定名称的cookie
		public static Cookie getCookieByName(Cookie[] cs, String name) {
			if (cs == null || cs.length == 0) {
				return null;
			}
			for (Cookie c : cs) {
				if (name.equals(c.getName())) {
					return c;
				}
			}
			return null;
		}%>
		
	    <div data-options="region:'north',title:'North Title',split:true" style="height:15%;">
	    	<form action="${pageContext.request.contextPath}/user/delete.do" id="entry_form" method="post">
				<!-- 退出系统时，将名为 userName 的 Session 删除 -->
				<input type="text" name="session_name" value="<%= userName%>" style="display:none">
				<button type="submit" id="entry_btn">退出登录</button>
				<div id="prompt" class="prompt"></div>
			</form>
	    </div>
	    <div data-options="region:'south',title:'South Title',split:true" style="height:15%;"></div>
	    <div data-options="region:'east',title:'East',split:true" style="width:15%;"></div>
	    <div data-options="region:'west',title:'West',split:true" style="width:15%;">
	    
			<div id="aa" class="easyui-accordion" style="width:100%;height:100%;">
			    <div title="Title1" data-options="iconCls:'icon-save'" style="overflow:auto;padding:10px;">
					<h3 style="color:#0099FF;">Accordion for jQuery</h3>
					<p>Accordion is a part of easyui framework for jQuery.
					It lets you define your accordion component on web page more easily.</p>
			    </div>
			    <div title="Title2" data-options="iconCls:'icon-reload'" style="padding:10px;">
					content2
			    </div>
				<div title="Title3" data-options="iconCls:'icon-search',selected:true" style="padding:10px;">
					<a href="javascript:void(0)" pageUrl="customer_manage.jsp">用户管理</a>
			    </div>
			</div>
	    </div>
	    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;">
	    	<div id="tt" class="easyui-tabs" style="width:100%;height:100%;">
			    <div title="Tab1" style="padding:20px;display:none;">
					tab1
			    </div>
			    <div title="Tab2" data-options="closable:true" style="overflow:auto;padding:20px;display:none;">
					tab2
			    </div>
			    <div title="Tab3" data-options="iconCls:'icon-reload',closable:true" style="padding:20px;display:none;">
					tab3
			    </div>
			</div>
	    </div>
	</body>
</html>