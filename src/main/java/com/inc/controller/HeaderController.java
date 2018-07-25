package com.inc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HeaderController {

	
	@RequestMapping("/faq")
	public String faqPage() {
		return "/header/faq.jsp";
	}
	
	@RequestMapping( value = "/intro", method= RequestMethod.GET)
	public String intro() {
		
		return "/header/intro.jsp";
	}
}
