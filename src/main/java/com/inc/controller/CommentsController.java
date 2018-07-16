package com.inc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inc.domain.Comments;
import com.inc.service.CommentsService;

@Controller
public class CommentsController {

	@Autowired
	private CommentsService commentsService;
	
	//사용자가 선택한 도서에 대한 댓글 작성이 가능하게하고, 목록도 보여지게
	@RequestMapping(value="/comments/list/{idx}", method=RequestMethod.GET)
	public String commentsList(@PathVariable int idx,Model model) {
		model.addAttribute("commentsList",commentsService.commentsList(idx));		
		
		return "/comments/list.jsp";
	}
	
	//사용자가 로그인을 하지 않거나, 주소창에서 
	@RequestMapping(value="/comments/list", method=RequestMethod.GET)
	public String commentsList() {
		return "/comments/list";
	}
	
	@RequestMapping(value="/comments/add", method=RequestMethod.POST)
	public String commentsAdd(@ModelAttribute Comments comments){
		commentsService.commentsAdd(comments);
		
		return "redirect:/comments/list/"+comments.getIdx();
	}
}
