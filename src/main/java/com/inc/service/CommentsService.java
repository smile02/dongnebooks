package com.inc.service;

import java.util.List;

import com.inc.domain.Comments;

public interface CommentsService {

	List<Comments> commentsList(int idx, int page);

	void commentsAdd(Comments comments);

	void commentsMod(Comments comments);

	void commentsDel(int rno);

	int commentsCount(int idx);

}
