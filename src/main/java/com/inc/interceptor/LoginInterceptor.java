package com.inc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null) {
			request.setAttribute("msg", "로그인 후 이용가능한 페이지입니다.");
			request.setAttribute("url", "/main");
			request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
			return false;
		}
		return true;
	}
	
	

}
