package com.inc.dao;

import java.util.List;

import com.inc.domain.Comments;

public interface CommentsDao {

	List<Comments> commentsList(int idx);

	void commentsAdd(Comments comments);

}
