package com.inc.dao;

import java.util.List;
import java.util.Map;

import com.inc.domain.Board;

public interface BoardDao {

	public void plusHit(int idx)throws Exception;

	public void update(Board board)throws Exception;

	public void delete(int idx)throws Exception;

	public void insert(Board board)throws Exception;

	public Board selectOne(int idx)throws Exception;

	public int totalCount(Map<String, Object> searchMap) throws Exception;

	public List<Board> selectList(Map<String, Object> searchMap) throws Exception;

	public List<Board> getNoticeList(int noticeCount);

}