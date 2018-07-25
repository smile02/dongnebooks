package com.inc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inc.dao.BoardDao;
import com.inc.domain.Board;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public static final int numberOfList = 8;
	public static final int numberOfPage = 3;

	@Override
	public Board selectOne(int idx) throws Exception {
		// 조회수늘리는거
		boardDao.plusHit(idx);
		// board가져오는거
		return boardDao.selectOne(idx);
	}

	@Override
	public void update(Board board) throws Exception {
		boardDao.update(board);
	}

	@Override
	public void delete(int idx) throws Exception {
		boardDao.delete(idx);
	}

	@Override
	public void insert(Board board) throws Exception {
		boardDao.insert(board);
	}

	@Override
	public List<Board> boardList(String option, String text, int page) throws Exception {
		return boardDao.selectList(getSearchMap(option, text, page));
	}
	
	@Override
	public int getTotalCount(String option, String text, int page) throws Exception {
		return boardDao.totalCount(getSearchMap(option, text, page));
	}
	
	private Map<String, Object> getSearchMap(
					String option, String text, int page) throws Exception{
		int start = (page - 1) * numberOfList + 1;
		int end = start + numberOfList - 1;
		System.out.println("start : "+start);
		System.out.println("end : "+end);
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("start", start);
		searchMap.put("end", end);
		searchMap.put("option", option);
		searchMap.put("text", text);
		
		return searchMap;
	}

	@Override
	public List<Board> getNoticeList(int noticeCount) {
		return boardDao.getNoticeList(noticeCount);
	}

}
