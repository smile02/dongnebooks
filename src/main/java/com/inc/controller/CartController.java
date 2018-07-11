package com.inc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inc.domain.Cart;
import com.inc.domain.Users;
import com.inc.service.CartService;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
	@RequestMapping(value="/cart/add", method=RequestMethod.GET)
	public String cart(Model model) {
		model.addAttribute("cart", new Cart());
		return "/cart/add.jsp";
	}
}