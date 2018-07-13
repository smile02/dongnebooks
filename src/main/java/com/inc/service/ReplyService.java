package com.inc.service;

import java.util.List;

import com.inc.domain.Reply;

public interface ReplyService {

	void insert(Reply reply) throws Exception;

	List<Reply> replyList(int idx) throws Exception;

	void delete(int rno)throws Exception;

	void update(Reply reply) throws Exception;

}
