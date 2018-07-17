package com.inc.service;

import java.util.List;

import com.inc.domain.Board;

public interface BoardService {

	Board selectOne(int idx) throws Exception;

	void update(Board board) throws Exception;

	void delete(int idx) throws Exception;

	void insert(Board board) throws Exception;

	List<Board> boardList(String option, String text, int page) throws Exception;

	int getTotalCount(String option, String text, int page) throws Exception;

	List<Board> getNoticeList(int noticeCount);


}
