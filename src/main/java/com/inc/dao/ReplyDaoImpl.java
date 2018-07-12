package com.inc.dao;

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

}