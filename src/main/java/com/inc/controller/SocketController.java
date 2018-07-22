package com.inc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.inc.domain.Users;

@Controller
public class SocketController {
	
	@RequestMapping(value="/socket/chat")
	public String socketChat(HttpServletRequest request, Model model) {
		Users user = (Users)request.getSession().getAttribute("user");
		
		model.addAttribute("loginUser",user);
		
		return "/socket/chat_socket.jsp";
	}
}
