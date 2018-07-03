package com.inc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.Books;

@Repository
public class BooksDaoImpl implements BooksDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<Books> booksList() {
		return session.selectList("books.booksList");
	}

	@Override
	public void booksAdd(Books books) {
		session.insert("books.booksAdd",books);
	}

	
}
