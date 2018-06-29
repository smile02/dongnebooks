package com.inc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.inc.service.CommentService;

@Controller
public class CommentController {
	@Autowired
	private CommentService commentService;
}
