package com.inc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.domain.Board;
import com.inc.domain.Reply;
import com.inc.service.BoardService;
import com.inc.service.BoardServiceImpl;
import com.inc.util.Paging;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private Paging paging;
	
	@RequestMapping(value="/board/list", method=RequestMethod.GET)
	public String boardList(@RequestParam(required = false) String option, @RequestParam(required = false) String text,
			@RequestParam(defaultValue = "1") int page, Model model) throws Exception {
		String searchParam = "";
		if (option != null && !option.equals("all")) {
			searchParam = "&option=" + option + "&text=" + text;
		}
			model.addAttribute("boardList", boardService.boardList(option, text, page));
			model.addAttribute("paging", paging.getPaging
					("/board/list", page, boardService.getTotalCount(option,text,page), 
							BoardServiceImpl.numberOfList, BoardServiceImpl.numberOfPage,searchParam));
		return "/board/list.jsp";
	}
	
	@RequestMapping(value="/board/view", method=RequestMethod.GET)
	public String view(@RequestParam int idx,Model model) throws Exception{
		model.addAttribute("board",boardService.selectOne(idx));
		model.addAttribute("reply", new Reply());
	return "/board/view.jsp";
	}
	
	@RequestMapping(value="/board/update", method=RequestMethod.GET)
	public String update(@RequestParam int idx, Model model) throws Exception{
		Board board = boardService.selectOne(idx);
		model.addAttribute("board", board);
		return "/board/update.jsp";
	}
	
	@RequestMapping(value="/board/update", method=RequestMethod.POST)
	@ResponseBody
	public String update(@ModelAttribute Board board) throws Exception{
		boardService.update(board);
		return "y";
	}
	
	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam int idx) throws Exception{
		boardService.delete(idx);
		return "y";
	}
	
	@RequestMapping(value="/board/insert",method=RequestMethod.GET)
	public String insert(Model model) throws Exception{
		model.addAttribute("board", new Board());
		return "/board/insert.jsp";
	}
	
	@RequestMapping(value="/board/insert",method=RequestMethod.POST)
	public String insert(@ModelAttribute Board board, HttpSession session) throws Exception{
		System.out.println(board.getNickname());
		boardService.insert(board);
		return "redirect:/board/list";
	}
}
