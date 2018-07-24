package com.inc.dao;

import java.util.List;
import java.util.Map;

import com.inc.domain.Comments;

public interface CommentsDao {

	List<Comments> commentsList(Map<String, Object> commentsMap);

	void commentsAdd(Comments comments);

	void commentsMod(Comments comments);

	void commentsDel(int rno);

	int commentsCount(int idx);

	void commentsAdmin(int rno);

}
