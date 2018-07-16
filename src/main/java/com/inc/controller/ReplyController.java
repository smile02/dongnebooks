package com.inc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.domain.Reply;
import com.inc.domain.Users;
import com.inc.service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping(value="/reply/insert", method=RequestMethod.POST)
	public String insert(@ModelAttribute @Valid Reply reply, BindingResult result, HttpSession session,HttpServletRequest req) throws Exception {
		//System.out.println(reply.getComments());
		//System.out.println(reply.getIdx());
		if(result.hasErrors()) {
			System.out.println("몰라임마");
		}
		Users user = (Users) req.getSession().getAttribute("user");
		reply.setNickname(user.getNickname());
		System.out.println(reply.getNickname());
		replyService.insert(reply);
		return "redirect:/board/view?idx="+reply.getIdx();
	}
	
	@RequestMapping(value="/reply/delete/{rno}", method=RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam int rno) throws Exception{
		replyService.delete(rno);
		return "y";
	}
	
	@RequestMapping(value="/reply/update", method=RequestMethod.POST)
	@ResponseBody
	public String update(@ModelAttribute Reply reply) throws Exception{
		replyService.update(reply);
		return "y";
	}
}
