package com.inc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inc.dao.CommentsDao;
import com.inc.domain.Comments;

@Service
public class CommentsServiceImpl implements CommentsService{

	@Autowired
	private CommentsDao commentsDao;
	
	@Override
	public List<Comments> commentsList(int idx) {
		return commentsDao.commentsList(idx);
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

}
