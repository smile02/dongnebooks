package com.inc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.inc.service.ReplyService;

@Controller
public class ReplyController {
	@Autowired
	private ReplyService replyService;
}
