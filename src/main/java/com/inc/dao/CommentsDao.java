package com.inc.dao;

import java.util.List;
import java.util.Map;

import com.inc.domain.Comments;

public interface CommentsDao {

	List<Comments> commentsList(int idx);

}
