package com.inc.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.inc.domain.Users;
import com.inc.service.UsersService;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	private UsersService usersService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 자동 로그인 처리
		// session에 user가 없지만(즉, 로그인을 안했지만), loginCookie가 존재할 때, 즉 7일 이전에 만든 쿠키가 있을때 진행
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null) {
			//로그인한 객체가 없으면 만들어 놓은 쿠키 꺼내오기
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				//생성해놓은 쿠키가 있으면 세션ID가 맞고, 쿠키 유효기간이 지나지 않은 User를 불러온다.
				Users user = usersService.checkLoginBefore(loginCookie.getValue());
				
				if(user != null) {
					//만약 해당 조건에 맞는 유저가 있으면 로그인 처리
					session.setAttribute("user", user);
					return true;
				}
			}
		}
		return true;
	}
	
}
