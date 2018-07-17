package com.inc.service;

import java.util.List;
import java.util.Map;

import com.inc.domain.Books;

public interface BooksService {

	//책의 목록을 보여주는 메서드
	public List<Books> booksList(String tag,int page);

	public void booksAdd(Books books);

	public Books booksView(int idx);

	public void booksMod(Books books);

	public int getTotalCount(String tag, int page);

	public List<String> tagList();
	
	public void dealChange(Map<String, Object> dealMap);

	public List<Books> newBooks(int bookCount);
	
	
}