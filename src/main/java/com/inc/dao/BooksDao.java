package com.inc.dao;

import java.util.List;
import java.util.Map;

import com.inc.domain.Books;

public interface BooksDao {

	public List<Books> booksList(Map<String, Object> map);

	public void booksAdd(Books books);

	public Books booksView(int idx);

	public void booksMod(Books books);

	public int getTotalCount(Map<String, Object> searchMap);

	public List<String> tagList();

}
