package com.inc.controller;

import java.util.List;
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

import com.inc.domain.Board;
import com.inc.domain.Books;
import com.inc.domain.Cart;
import com.inc.domain.Users;
import com.inc.service.BoardService;
import com.inc.service.BooksService;
import com.inc.service.CartService;
import com.inc.service.CartServiceImpl;
import com.inc.service.UsersService;
import com.inc.util.Paging;
import com.inc.util.SHA256Encryptor;

@Controller
public class UsersController {
	@Autowired
	private UsersService usersService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BooksService booksService;
	
	@Autowired
	private Paging paging;
	
	@RequestMapping("/main")
	public String mainPage(Model model,HttpSession session) {
		//1. 로그인 기능.
		//2. 책 목록 최근 6개정도.
		int bookCount = 6;
		List<Books> newBooks = booksService.newBooks(bookCount);
		model.addAttribute("newBooks", newBooks);
		//3. 공지사항 최근게시물 출력
		int noticeCount = 5;
		List<Board> noticeList = boardService.getNoticeList(noticeCount);
		model.addAttribute("noticeList", noticeList);
		Users fakeUser = new Users();
		fakeUser.setId("admin");
		fakeUser.setNickname("관리자");
		session.setAttribute("user", fakeUser);
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
		//패스워드 암호화
		String password = SHA256Encryptor.shaEncrypt(user.getPassword());
		user.setPassword(password);
		
		usersService.signup(user);
		
		session.invalidate();
		
		return "redirect:/main";
	}
	@RequestMapping(value="/user/updatePwd", method=RequestMethod.POST)
	@ResponseBody
	public String updatePwd(@ModelAttribute Users user) {
		//둘 중 하나를 입력하지 않았을 경우.
		if(user.getPassword().length() == 0 || user.getPasswordConfirm().length() == 0) {
			return "null";
		}
		//두 개의 비밀번호가 일치하지 않을 경우
		if(!user.isPasswordEqual()) {
			return "notEqual";
		}
		
		//비밀번호가 형식에 맞지 않을 경우.
		if(!passwordValidator(user.getPassword())) {
			return "incorrect";
		}
		
		//비밀번호 암호화
		String password = SHA256Encryptor.shaEncrypt(user.getPassword());
		user.setPassword(password);
		
		usersService.updatePwd(user);
		return "success";
	}
	
	private boolean passwordValidator(String password) {
		return Pattern.compile("[0-9a-zA-Z]{4,20}")
				.matcher(password).matches();
	}
	
	@RequestMapping(value="/user/mypage", method=RequestMethod.POST)
	public String update(@ModelAttribute("user") @Valid Users user, BindingResult result, Model model, HttpSession session) {
		//닉네임과 이메일은 타인과 중복되어서는 안되지만 자신의 정보와 중복될수는 있다.
		//그러므로 기존 정보를 불러와 비교한다.
		Users savedUser = usersService.getUser(user.getId());
		
		if(!savedUser.getNickname().equals(user.getNickname()) && usersService.nickCheck(user.getNickname()) != null) {
			//기존 정보와 다르면서 타인과 닉네임 중복검색이 될때.
			result.addError(new FieldError("nickError", "nickname", "중복된 닉네임을 입력하셨습니다."));
		}
		if(!savedUser.getEmail().equals(user.getEmail()) && usersService.emailCheck(user.getEmail())) {
			//기존 정보와 다르면서 중복된 이메일일경우
			result.addError(new FieldError("emailError", "email", "중복된 이메일입니다."));
		}

		if(result.hasErrors()) {
			model.addAttribute("user", user);
			return "/users/mypage.jsp";
		}
		
		usersService.update(user);
		//정보가 변경되었으므로 세션도 변경된 정보로 업데이트 해준다.
		Users updatedUser = usersService.getUser(user.getId());
		session.setAttribute("user", updatedUser);
				
		return "redirect:/user/mypage";
	}
	
	private boolean idValidator(String id) {
		return Pattern.compile("[0-9a-z]{4,20}").matcher(id).matches();
	}
	
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public String idCheck(@RequestParam String id){
		if(!idValidator(id)) {
			return "incorrect";
		}
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
		if(nickname.length() < 2 || nickname.length() > 15) {
			return "incorrect";
		}
		Users user = usersService.nickCheck(nickname);
		if(user == null) {
			return "n";
		}else {
			return "y";
		}
	}
	
	@RequestMapping(value="/user/emailCheck", method=RequestMethod.POST)
	@ResponseBody
	public String emailCheck(@RequestParam String email){
		if(!emailValidator(email)) {
			return "incorrect";
		}
		if(usersService.emailCheck(email)) {
			//중복되는 경우
			return "y";
		}else {
			return "n";
		}
	}
	
	@RequestMapping(value="/user/signin", method=RequestMethod.POST)
	@ResponseBody
	public String signin(@ModelAttribute Users user, HttpServletRequest request) {
		Users savedUser = usersService.getUser(user.getId());
		
		//입력받은 패스워드 암호화
		String password = SHA256Encryptor.shaEncrypt(user.getPassword());
		user.setPassword(password);
		
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
	
	@RequestMapping(value="/user/sendCode", method=RequestMethod.POST)
	@ResponseBody
	public String sendCode(@ModelAttribute Users user, HttpSession session) {
		//이메일과 아이디를 받아 일치하는 경우 인증메일을 발송한다.
		//이메일 발송과 인증 로직은 동일하지만, 기존에 있는 회원정보를 찾는 것이므로 받는 파라미터와 응답 문자열이 다소 다르다.
		
		System.out.println(user.getId());
		System.out.println(user.getEmail());
		
		//이메일과 아이디 둘 중 하나가 null일 경우.
		if(user.getId().length() == 0 || user.getEmail().length() == 0) {
			return "null";
		}
		//등록된 아이디와 이메일 둘다 일치해야 한다. 일치하는 정보가 없을 경우.
		//이메일 형식이 맞지 않으면 어차피 여기서 걸리므로, 따로 확인하지 않는다.
		Users savedUser = usersService.getUser(user.getId());
		if(savedUser == null || !savedUser.getEmail().equals(user.getEmail())) {
			//아이디가 틀렸거나 or 아이디는 맞는데 이메일이 틀릴경우
			//System.out.println(savedUser.getEmail() + ":" + user.getEmail());
			return "notfound";
		}
		
		String code = null;
		try {
			code = usersService.sendCertifyEmail(user.getEmail());
		}catch(RuntimeException e) {
			return "error";
		}
		session.setAttribute("userId", user.getId());
		//임시비번 발급을 위해 회원아이디를 세션에 저장
		session.setAttribute("code", code); 
		//회원가입시의 이메일 코드와 구분하기 위해 이름을 다르게 설정해준다.

		return "success";
	}

	
	@RequestMapping(value="/user/findPwd", method=RequestMethod.POST)
	@ResponseBody
	public String findPwd(@RequestParam String code, HttpSession session) {
		//임시비번 발급 로직
		//1. 세션에 담긴 emailCode와 파라미터로 받아온 emailCode가 일치하는지 여부 확인.
		//2. 일치하지 않으면 "fail" 응답, 일치할 경우 usersService로 넘김.
		//3. usersService에서는 임시 비번 생성하고 암호화해서 업데이트하고 비번 코드를 넘긴다.
		//4. 예외 발생시 "error"응답, 정상 처리되면 임시비번으로 응답한다.
		
		if(!((String)session.getAttribute("code")).equals(code)) {
			//이메일로 받은 인증코드와 입력받은 코드가 일치하지 않을 경우
			return "fail";
		}
		
		String id = (String)session.getAttribute("userId");
		String tempPwd = null;
		try {
			//회원아이디로 정보를 찾아 임시비번을 발급하고 비번을 리턴받는다.
			tempPwd = usersService.getTempPwd(id);
		}catch(RuntimeException e) {
			return "error";
		}
		return tempPwd;
	}

	private boolean emailValidator(String email) {
		return Pattern.compile("[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}")
				.matcher(email).matches();
	}
	
	@RequestMapping(value="/user/mypage", method=RequestMethod.GET)
	public String myPage(@RequestParam(defaultValue="1") int page, Model model, HttpSession session) {
		Users user = (Users)session.getAttribute("user");
		model.addAttribute("user", user);
		
		//회원닉네임으로 구매요청 목록 찾아서 가져오기
		List<Cart> cartList = cartService.getCartList(user.getNickname(), page);
		model.addAttribute("cartList", cartList);
		int totalCount = cartService.getTotalCount(user.getNickname());
		model.addAttribute("paging", paging.getPaging("/user/mypage", page, totalCount, CartServiceImpl.numberOfList, CartServiceImpl.numberOfPage, ""));
		
		return "/users/mypage.jsp";
	}
	
	@RequestMapping(value="/user/findId", method=RequestMethod.POST)
	@ResponseBody
	public String findId(@RequestParam String email) {
		//이메일 주소로 아이디 찾아오기.
		System.out.println(email);
		if(email.length() == 0) {
			return "null";
		}
		if(!emailValidator(email)) {
			return "incorrect";
		}
		
		String id = usersService.findId(email);
		System.out.println(id);
		if(id == null) {
			return "notfound";
		}else {
			return id;
		}
	}
}