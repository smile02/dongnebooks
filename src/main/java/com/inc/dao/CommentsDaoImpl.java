package com.inc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.Comments;

@Repository
public class CommentsDaoImpl implements CommentsDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<Comments> commentsList(Map<String, Object> commentsMap) {
		return session.selectList("comments.commentsList",commentsMap);
	}

	@Override
	public void commentsAdd(Comments comments) {
		session.insert("comments.commentsAdd",comments);
	}

	@Override
	public void commentsMod(Comments comments) {
		session.update("comments.commentsMod",comments);
	}

	@Override
	public void commentsDel(int rno) {
		session.delete("comments.commentsDel",rno);
	}

	@Override
	public int commentsCount(int idx) {
		return session.selectOne("comments.commentsCount",idx);
	}

	@Override
	public void commentsAdmin(int rno) {
		session.delete("comments.commentsAdmin",rno);
	}


}
