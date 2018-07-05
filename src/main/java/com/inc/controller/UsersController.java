package com.inc.controller;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.domain.Users;
import com.inc.service.UsersService;

@Controller
public class UsersController {
	@Autowired
	private UsersService usersService;
	
	@RequestMapping("/main")
	public String mainPage() {
		//1. 로그인 기능
		//2. 책 목록
		//3. 공지사항 출력
		return "/main.jsp";
	}
	
	@RequestMapping(value="/user/signup", method=RequestMethod.GET)
	public String signup(Model model) {
		model.addAttribute("user", new Users());
		return "/users/signup.jsp";
	}
	
	@RequestMapping(value="/user/signup", method=RequestMethod.POST)
	public String signup(@ModelAttribute("user") @Valid Users user, BindingResult result, Model model, HttpSession session) {
		if(usersService.getUser(user.getId()) != null) {
			//아이디 중복시
			result.addError(new FieldError("idError", "id", "중복된 아이디입니다."));
		}
		if(usersService.nickCheck(user.getNickname()) != null) {
			//닉네임 중복시
			result.addError(new FieldError("nickError", "nickname", "중복된 닉네임을 입력하셨습니다."));
		}
		if(!user.isPasswordEqual()) {
			//패스워드와 패스워드 확인이 일치하지 않을 경우.
			FieldError error = new FieldError("passwordError", "passwordConfirm", "비밀번호가 일치하지 않습니다.");
			result.addError(error);
		}
		if(!user.getEmail().equals((String)session.getAttribute("email"))) {
			//인증받은 이메일과 일치하지 않을 경우
			result.addError(new FieldError("emailNotEqualError", "email", "인증받은 메일로 가입해 주세요."));
		}
		if(!user.getEmailcode().equals((String)session.getAttribute("emailCode"))) {
			//이메일코드가 잘못 입력되었을 경우
			result.addError(new FieldError("emailCodeError", "emailcode", "이메일 코드를 입력해 주세요."));
		}
		
		if(result.hasErrors()) {
			model.addAttribute("user", user);
			return "/users/signup.jsp";
		}
		
		usersService.signup(user);
		session.invalidate();
		
		return "redirect:/main";
	}
	
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public String idCheck(@RequestParam String id){
		//System.out.println(id);
		Users user = usersService.getUser(id);
		//System.out.println(user);
		if(user == null) {
			return "n";
		}else {
			return "y";
		}
	}
	
	
	@RequestMapping(value="/user/nickCheck", method=RequestMethod.POST)
	@ResponseBody
	public String nickCheck(@RequestParam String nickname){
		Users user = usersService.nickCheck(nickname);
		if(user == null) {
			return "n";
		}else {
			return "y";
		}
	}
	
	@RequestMapping(value="/user/signin", method=RequestMethod.POST)
	@ResponseBody
	public String signin(@ModelAttribute Users user, HttpServletRequest request) {
		Users savedUser = usersService.getUser(user.getId());
		if(savedUser == null) {
			return "null";
		}else if(!savedUser.getPassword().equals(user.getPassword())) {
			//가져온 유저의 패스워드와 입력한 패스워드가 일치하지 않을 경우.
			return "pass";
		}else {
			request.getSession().invalidate();
	
			request.getSession().setAttribute("user", savedUser);
			return "success";
		}
	}
	
	@RequestMapping(value="/user/signout", method=RequestMethod.GET)
	public String signout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
	
	@RequestMapping(value="/user/emailCertify", method=RequestMethod.POST)
	@ResponseBody
	public String emailCertify(@RequestParam String email, HttpSession session) {
		if(email.length() == 0) {
			return "null";
		}
		if(!emailValidator(email)) {
			return "incorrect";
		}
		if(usersService.emailCheck(email)) {
			return "duplicated";
		}
		String emailCode = null;
		try {
			emailCode = usersService.sendCertifyEmail(email);
		}catch(RuntimeException e) {
			return "error";
		}
		
		
		session.setAttribute("email", email);
		session.setAttribute("emailCode", emailCode);
		
		return "success";
	}

	private boolean emailValidator(String email) {
		return Pattern.compile("[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}")
				.matcher(email).matches();
	}
}
