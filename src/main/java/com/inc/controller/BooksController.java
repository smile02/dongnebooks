package com.inc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.inc.service.BooksService;

@Controller
public class BooksController {
	@Autowired
	private BooksService booksService;
	
}
