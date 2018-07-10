package com.inc.service;

import java.util.List;

import com.inc.domain.Books;

public interface BooksService {

	//책의 목록을 보여주는 메서드
	public List<Books> booksList(int page);

	public void booksAdd(Books books);

	public Books booksView(int idx);

	public void booksMod(Books books);

	public int getTotalCount(int page);
	
	
}
