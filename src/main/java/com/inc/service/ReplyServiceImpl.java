package com.inc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inc.dao.ReplyDao;
import com.inc.domain.Reply;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired 
	private ReplyDao replyDao;
	
	@Override
	public void insert(Reply reply) throws Exception {
		replyDao.insert(reply);
	}

	@Override
	public List<Reply> replyList(int idx) throws Exception {
		return replyDao.replyList(idx);
	}

	@Override
	public void delete(int rno) throws Exception {
		replyDao.delete(rno);
		
	}

	@Override
	public void update(Reply reply) throws Exception {
		replyDao.update(reply);
	}

}
