package com.inc.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.inc.domain.Users;

@Controller
public class TestController {
	@Autowired
	private SqlSession session;
	
	//테스트용 컨트롤러 코드입니다.
	@RequestMapping("/test")
	public String userList(Model model) {
		Users user = session.selectOne("users.selectOne");
		model.addAttribute("user", user);
		return "/test.jsp";
	}
}
