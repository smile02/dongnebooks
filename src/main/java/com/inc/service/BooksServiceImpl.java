package com.inc.service;

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
	
	@Override
	public List<Books> booksList() {
		return booksDao.booksList();
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

}
