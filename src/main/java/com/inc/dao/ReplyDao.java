package com.inc.dao;

import java.util.List;

import com.inc.domain.Reply;

public interface ReplyDao {

	void insert(Reply reply);

	List<Reply> replyList(int idx);

	void delete(int rno);

	void update(Reply reply);

}
