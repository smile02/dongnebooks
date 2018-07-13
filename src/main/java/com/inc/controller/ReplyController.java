package com.inc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.domain.Reply;
import com.inc.service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	/*@RequestMapping(value="/reply/list", method=RequestMethod.GET)
	public String replyList(@PathVariable int idx, @PathVariable String nickname ,Model model) throws Exception {
		model.addAttribute("replyList",replyService.replyList(idx));
		System.out.println(replyList(idx, nickname, model));
		return "/board/list.jsp";
	}*/
	
	@RequestMapping(value="/reply/insert", method=RequestMethod.POST)
	@ResponseBody
	public String insert(@ModelAttribute Reply reply) throws Exception {
		replyService.insert(reply);
		return "y";
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
