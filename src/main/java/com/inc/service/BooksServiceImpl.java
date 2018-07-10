package com.inc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inc.dao.BooksDao;
import com.inc.domain.Books;

@Service
public class BooksServiceImpl implements BooksService{

	@Autowired
	private BooksDao booksDao;
	
	public static final int numberOfList = 8;
	public static final int numberOfPage = 5;
	
	
	@Override
	public List<Books> booksList(int page) {
		return booksDao.booksList(getSearchMap(page));
	}

	@Override
	public void booksAdd(Books books) {
		booksDao.booksAdd(books);
	}

	@Override
	public Books booksView(int idx) {
		return booksDao.booksView(idx);
	}

	@Override
	public void booksMod(Books books) {
		booksDao.booksMod(books);
	}

	@Override
	public int getTotalCount(int page) {
		return booksDao.getTotalCount(getSearchMap(page));
	}
	
	private Map<String, Object> getSearchMap(int page){
		
		int start = (page -1)*numberOfList+1;
		int end = start + numberOfList -1;
		
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("start", start);
		searchMap.put("end", end);
		
		return searchMap;
	}
}
