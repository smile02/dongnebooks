package com.inc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inc.dao.CommentsDao;
import com.inc.domain.Comments;

@Service
public class CommentsServiceImpl implements CommentsService{

	public static int numberOfList = 3;
	public static int numberOfPage = 5;
	
	@Autowired
	private CommentsDao commentsDao;
	
	@Override
	public List<Comments> commentsList(int idx,int page) {
		Map<String, Object> commentsMap = commentsCountMap(idx, page);
		return commentsDao.commentsList(commentsMap);
	}
	
	private Map<String, Object> commentsCountMap(int idx, int page) {
		Map<String, Object> commentsMap = new HashMap<>();
		int start = (page-1)*numberOfList + 1;
		int end = start + numberOfList -1;
		
		commentsMap.put("start", start);
		commentsMap.put("end", end);
		commentsMap.put("idx", idx);
		
		return commentsMap;
	}
	

	@Override
	public void commentsAdd(Comments comments) {
		commentsDao.commentsAdd(comments);
	}

	@Override
	public void commentsMod(Comments comments) {
		commentsDao.commentsMod(comments);
	}

	@Override
	public void commentsDel(int rno) { 
		commentsDao.commentsDel(rno);
	}

	@Override
	public int commentsCount(int idx) {
		return commentsDao.commentsCount(idx);
	}	

}
