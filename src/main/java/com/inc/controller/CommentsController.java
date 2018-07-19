package com.inc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.inc.domain.Comments;
import com.inc.service.CommentsService;
import com.inc.service.CommentsServiceImpl;
import com.inc.util.Paging;

@RestController
public class CommentsController {

	@Autowired
	private CommentsService commentsService;
	
	private static int getIdx = 0;
	
	@Autowired
	private Paging paging;
	
	//사용자가 선택한 도서에 대한 댓글 작성이 가능하게하고, 목록도 보여지게
	@RequestMapping(value="/comments/list/{idx}/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> commentsList(@PathVariable int idx,
			@PathVariable int page, Model model) {	
		ResponseEntity<Map<String, Object>> entity = null;
		System.out.println("comments : "+idx);
		getIdx = idx;
		try {
			
			Map<String, Object> commentsMap = new HashMap<>();
			List<Comments> commentsList = commentsService.commentsList(idx,page);
			
			commentsMap.put("commentsList", commentsList);
			int commentsCount = commentsService.commentsCount(idx);
			
			commentsMap.put("paging", paging.getPaging("/comments/list/"+idx, page, 
					commentsCount, CommentsServiceImpl.numberOfList, CommentsServiceImpl.numberOfPage));			
			entity = new ResponseEntity<Map<String, Object>>(commentsMap, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//사용자가 로그인을 하지 않거나, 주소창에서 
	@RequestMapping(value="/comments/list", method=RequestMethod.GET)
	public String commentsList() {
		return "/comments/list";
	}
	
	//댓글을 등록하는 메서드
	@RequestMapping(value="/comments/add", method=RequestMethod.POST)
	public ResponseEntity<String> commentsAdd(@RequestBody Comments comments){
		System.out.println("등록 시 : "+comments.getNickname());
		System.out.println("등록 시 : "+comments.getComments());
		System.out.println("등록 시 : "+comments.getIdx());
		
		
		ResponseEntity<String> entity = null;
		try {
			comments.setIdx(getIdx);
			System.out.println("그 다음 : "+comments.getIdx());
			if(comments.getComments() != "") {
				commentsService.commentsAdd(comments);
				entity = new ResponseEntity<String>(comments.getIdx()+"", HttpStatus.OK);
			}else {
				entity = new ResponseEntity<String>("y", HttpStatus.OK);
			}
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//댓글을 수정하는 메서드
	@RequestMapping(value="/comments/mod/{rno}", method= RequestMethod.PATCH)
	public ResponseEntity<String> commentsMod(@PathVariable("rno") int rno, 
											  @RequestBody Comments comments){
		ResponseEntity<String> entity = null;
		try {
			comments.setRno(rno);
			commentsService.commentsMod(comments);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity; 
	}
	
	//댓글을 삭제하는 메서드
	@RequestMapping(value="/comments/del/{rno}", method = RequestMethod.DELETE)
	public ResponseEntity<String> commentsDel(@PathVariable("rno") int rno){
		ResponseEntity<String> entity = null;
		try {
			commentsService.commentsDel(rno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
