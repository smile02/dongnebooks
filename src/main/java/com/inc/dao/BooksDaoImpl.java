package com.inc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.Books;

@Repository
public class BooksDaoImpl implements BooksDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<Books> booksList(Map<String, Object> map) {
		return session.selectList("books.booksList",map);
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
	public int getTotalCount(Map<String, Object> searchMap) {
		return session.selectOne("books.getTotalCount",searchMap);
	}

	@Override
	public List<String> tagList() {
		return session.selectList("books.tagList");
	}

}
