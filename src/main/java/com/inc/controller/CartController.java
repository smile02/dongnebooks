package com.inc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.inc.service.BooksService;
import com.inc.service.CartService;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
	
	@Autowired
	private BooksService booksService;
	
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
		cartService.cartAdd(cart);
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
}