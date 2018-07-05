package com.inc.dao;

import java.util.List;

import com.inc.domain.Books;

public interface BooksDao {

	public List<Books> booksList();

	public void booksAdd(Books books);

	public Books booksView(int idx);

	public void booksMod(Books books);
}
