package com.inc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.Board;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSession session;

	@Override
	public void plusHit(int idx) throws Exception {
		session.update("board.plusHit", idx);
	}

	@Override
	public Board selectOne(int idx) throws Exception {
		return session.selectOne("board.selectOne", idx);
	}

	@Override
	public void update(Board board) throws Exception {
		session.update("board.update", board);
		
	}

	@Override
	public void delete(int idx) throws Exception {
		session.delete("board.delete", idx);
	}

	@Override
	public void insert(Board board) throws Exception {
		session.insert("board.insert", board);
	}

	@Override
	public int totalCount(Map<String, Object> searchMap) throws Exception {
		return session.selectOne("board.totalCount", searchMap);
	}

	@Override
	public List<Board> selectList(Map<String, Object> searchMap) throws Exception {
		return session.selectList("board.selectList", searchMap);
	}

}