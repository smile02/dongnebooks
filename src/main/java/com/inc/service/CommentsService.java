package com.inc.service;

import java.util.List;

import com.inc.domain.Comments;

public interface CommentsService {

	List<Comments> commentsList(int idx);

	void commentsAdd(Comments comments);

	void commentsMod(Comments comments);

	void commentsDel(int rno);

}
