package com.inc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.inc.service.CartService;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
}