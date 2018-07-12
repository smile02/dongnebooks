package com.inc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inc.dao.ReplyDao;
import com.inc.domain.Reply;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired 
	private ReplyDao replyDao;
	
	@Override
	public void insert(Reply reply) {
		replyDao.insert(reply);
	}

}
