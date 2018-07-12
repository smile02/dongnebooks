package com.inc.service;

import java.util.List;
import java.util.Map;

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

}
