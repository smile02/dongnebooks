package com.inc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.domain.Reply;
import com.inc.domain.Users;
import com.inc.service.BoardService;
import com.inc.service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private BoardService boardService;
	
	//댓글입력
	@RequestMapping(value="/reply/insert", method=RequestMethod.POST)
	public String insert(@ModelAttribute @Valid Reply reply, BindingResult result, HttpSession session,HttpServletRequest req, Model model) throws Exception {
		System.out.println("확인1 : "+reply.getComments());
		
		reply.setComments(reply.getComments().trim());
		System.out.println("확인2 : "+reply.getComments());
		//에러있으면 
		if(result.hasErrors() || (reply.getComments().length() == 0 || reply.getComments().equals("") || reply.getComments() == null)) {
			model.addAttribute("board", boardService.selectOne(reply.getIdx()));
			return "/board/view.jsp";
		}
		Users user = (Users) req.getSession().getAttribute("user");
		reply.setNickname(user.getNickname());
		replyService.insert(reply);
		return "redirect:/board/view?idx="+reply.getIdx();
	}
	
	//댓글삭제
	@RequestMapping(value="/reply/delete/{rno}", method=RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam int rno) throws Exception{
		replyService.delete(rno);
		return "y";
	}
	
	//댓글수정
	@RequestMapping(value="/reply/update", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String update(@ModelAttribute @Valid Reply reply, BindingResult result) throws Exception{
		if(result.hasErrors()) {
			System.out.println(result.getFieldError().getDefaultMessage());
			return result.getFieldError().getDefaultMessage();
		}
		replyService.update(reply);
		return "y";
	}
}
