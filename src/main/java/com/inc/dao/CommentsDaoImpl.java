package com.inc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.Comments;

@Repository
public class CommentsDaoImpl implements CommentsDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<Comments> commentsList(int idx) {
		return session.selectList("comments.commentsList",idx);
	}

	@Override
	public void commentsAdd(Comments comments) {
		session.insert("comments.commentsAdd",comments);
	}

	@Override
	public void commentsMod(Comments comments) {
		session.update("comments.commentsMod",comments);
	}


}
