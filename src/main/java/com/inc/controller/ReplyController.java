package com.inc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inc.domain.Reply;
import com.inc.service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping(value="/reply/insert", method=RequestMethod.POST)
	public String insert(@ModelAttribute Reply reply) {
		replyService.insert(reply);
		return "redirect:/board/view?idx="+reply.getIdx();
	}
}
