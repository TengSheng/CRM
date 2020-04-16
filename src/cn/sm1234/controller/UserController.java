package cn.sm1234.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.sm1234.domain.User;
import cn.sm1234.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController{

	@Resource
	private UserService userService;
	
	/**
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @return String
	 * @throws ServletException
	 * @throws IOException
	 * 
	 * 用户登录控制器
	 */
	@RequestMapping("/login")
	public String login (User user, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
		User resultUser = userService.login(user);

		if(resultUser == null) {
			request.setAttribute("user", user);
			request.setAttribute("errorMsg", "用户名或者密码错误");
	        response.setCharacterEncoding("utf-8");
			response.getWriter().print("登陆失败！");
			return "index";
		}
		else {			
			if (request.getParameter("keep") != null) {   // 一周免登录
				// 设置 Cookie
				setCookie(60 * 60 * 24 * 7 * 1, "username", user, request, response);
			}
			else {
				// 设置 Cookie 为 0，即删除 Cookie
				setCookie(0, "username", user, request, response);
				
				HttpSession session = request.getSession();
				session.setAttribute("currentUser", resultUser.getUserName());
				session.setAttribute(resultUser.getUserName(), resultUser);
			}
	        response.setCharacterEncoding("utf-8");
	        response.getWriter().print("登陆成功！");
			return "redirect:/main_1.jsp";
		}
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return String
	 * @throws ServletException
	 * @throws IOException
	 * 
	 * 退出登录时，删除当前用户的 Session
	 */
	@RequestMapping("/delete")
	public String login (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{

		String sessionName = request.getParameter("session_name");

		HttpSession session = request.getSession();
		
		if(session.getAttribute(sessionName) != null) {
			// 删除当前用户的 Session
			session.removeAttribute(sessionName);
			
			if(session.getAttribute(sessionName) == null)
				System.out.println(sessionName + "：session 已经删除！");
		}
		return "redirect:/index.jsp";
	}
	
	/**
	 * 
	 * @param timeout
	 * @param cookieName
	 * @param user
	 * @param request
	 * @param response
	 * 
	 * 在servlet中设置的cookie只在该servlet所在的目录及其子目录下有效，
	 * 而很不幸要获取cookie的那个.jsp文件所在的目录不在其中,所以根本获取不到
	 * 在servlet中设置cookie时多加一句 usernameCookie.setPath(“/”)，
	 * 这样这个cookie的有效范围就可以扩充到整个项目了（”/”代表项目根目录）
	 */
	// 设置 Cookie
	public static void setCookie(int timeout, String cookieName, User user, HttpServletRequest request, HttpServletResponse response) {
		
		Cookie usernameCookie = new Cookie(cookieName, user.getUserName());
		usernameCookie.setMaxAge(timeout);
		usernameCookie.setPath("/");
		response.addCookie(usernameCookie);
	}
}
