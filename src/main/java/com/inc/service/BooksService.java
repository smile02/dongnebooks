package com.inc.service;

import java.util.List;

import com.inc.domain.Books;

public interface BooksService {

	//책의 목록을 보여주는 메서드
	public List<Books> booksList();

	public void booksAdd(Books books); 
}
