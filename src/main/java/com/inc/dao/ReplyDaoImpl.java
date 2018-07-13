package com.inc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.Reply;

@Repository
public class ReplyDaoImpl implements ReplyDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(Reply reply) {
		session.insert("reply.insert",reply);
	}

	@Override
	public List<Reply> replyList(int idx) {
		return session.selectList("reply.replyList",idx);
	}

	@Override
	public void delete(int rno) {
		session.delete("reply.delete",rno);
	}

	@Override
	public void update(Reply reply) {
		session.update("reply.update",reply);
	}


}