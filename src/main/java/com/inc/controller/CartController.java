package com.inc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.domain.Cart;
import com.inc.domain.Users;
import com.inc.service.BooksService;
import com.inc.service.CartService;
import com.inc.service.CartServiceImpl;
import com.inc.service.UsersService;
import com.inc.util.Paging;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
	@Autowired
	private UsersService usersService;
	
	@Autowired
	private BooksService booksService;
	
	@Autowired
	private Paging paging;
	
	@RequestMapping(value="/cart/add/{idx}", method=RequestMethod.GET)
	public String cart(@PathVariable int idx, Model model) {
		String title = booksService.booksView(idx).getTitle();
		model.addAttribute("idx", idx);
		model.addAttribute("title", title);
		model.addAttribute("cart", new Cart());
		return "/cart/add.jsp";
	}
	
	@RequestMapping(value="/cart/add/{idx}", method=RequestMethod.POST)
	public String cartAdd(@PathVariable int idx, @ModelAttribute("cart") @Valid Cart cart, BindingResult result, Model model) {
		/*System.out.println(cart.getIdx());
		System.out.println(result.hasErrors());
		System.out.println(cart.getAddress());
		System.out.println(cart.getD_type());*/
		if(result.hasErrors()) {
			/*for(ObjectError error : result.getAllErrors()) {
				System.out.println(error.getDefaultMessage());
			}*/
			model.addAttribute("idx", cart.getIdx());
			model.addAttribute("cart", cart);
			return "/cart/add.jsp";
		}
		
		try {
			cartService.cartAdd(cart);
		}catch(RuntimeException e) {
			model.addAttribute("msg", "서버 오류");
			model.addAttribute("url", "/cart/add/"+idx);
			return "/error.jsp";
		}
		return "redirect:/user/mypage";
	}
	
	@RequestMapping(value="/cart/statusChange", method=RequestMethod.POST)
	@ResponseBody
	public String statusChange(@RequestParam int num, @RequestParam String status) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("num", num);
		if(status.equals("request")) {
			//요청중(request) 상태에서 변경할 경우 구매취소(cancel)
			paramMap.put("status", "cancel");
		}else {
			paramMap.put("status", "complete");
		}
		
		try {
			cartService.statusChange(paramMap);
		}catch(Exception e) {
			return "fail";
		}
		
		
		return "success";
	}
	
	@RequestMapping(value="/cart/dealAccept", method=RequestMethod.POST)
	@ResponseBody
	public String dealAccept(@RequestParam int num, @RequestParam String status) {
		//판매자의 거래상태변경, select Box의 값을 그대로 가져다 업데이트한다.
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("status", status);
		
		try {
			cartService.statusChange(paramMap);
		}catch(Exception e) {
			return "fail";
		}
		
		
		return "success";
	}
	
	@SuppressWarnings("unused")//사용하지 않는 코드 관련 경고 억제
	@RequestMapping(value="/cart/getSeller", method=RequestMethod.POST)
	@ResponseBody
	public Users getSeller(@RequestParam String nickname) {
		//nickCheck 재사용
		Users user = usersService.nickCheck(nickname);
		System.out.println(nickname);
		System.out.println(user.getId());
		if(user != null) {
			System.out.println("success");
			return user;
		}else {
			return null;
		}
	}
	
	@RequestMapping(value="/cart/sale/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable int page, HttpSession session){
		ResponseEntity<Map<String, Object>> entity = null;
		//세션에서 닉네임을 가져와서 판매 목록을 출력.
		String nickname = ((Users)session.getAttribute("user")).getNickname();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			List<Cart> saleList = cartService.getSaleList(nickname, page);
			map.put("saleList", saleList);
			int saleTotal = cartService.getSaleTotal(nickname);
			map.put("paging", paging.getPaging("/cart/sale", page, saleTotal, CartServiceImpl.numberOfList, CartServiceImpl.numberOfPage));
			
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch(Exception e) {
			System.out.println("error");
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}