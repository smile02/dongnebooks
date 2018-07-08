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

	@Override
	public Books booksView(int idx) {
		return session.selectOne("books.booksView",idx);
	}

	@Override
	public void booksMod(Books books) {
		session.update("books.booksMod",books);
	}

	@Override
	public List<String> booksB_Category() {
		return session.selectList("books.booksB_Category");
	}

	@Override
	public List<Books> booksS_Category(String b_category) {
		return session.selectList("books.booksS_Category",b_category);
	}

	
}
