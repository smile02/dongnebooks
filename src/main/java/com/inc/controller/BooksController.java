package com.inc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inc.domain.Books;
import com.inc.service.BooksService;
import com.inc.service.FileService;

@Controller
public class BooksController {
	
	@Autowired
	private BooksService booksService;
	
	@Autowired
	private FileService fileService;

	//책의 목록을 보여주는 메서드
	@RequestMapping(value = "/books/list", method=RequestMethod.GET)
	public String booksList(Model model) {
		
		model.addAttribute("booksList",booksService.booksList());
		model.addAttribute("books",new Books());
		
		return "/books/booksList.jsp";
	}
	
	@RequestMapping(value ="/books/add", method=RequestMethod.POST)
	public String booksAdd(@ModelAttribute @Valid Books books,
							BindingResult result,
							HttpServletRequest request,Model model) {
		if(result.hasErrors()) {			
			model.addAttribute("err_books",books);			
			return "/books/booksList.jsp";
		}
		
		try {
			//파일 저장
			String path = request.getServletContext().getRealPath("/WEB-INF/resources/image/photo");
			String filename;
			filename = fileService.saveFile(path, books.getPhoto_file());
			books.setPhoto(filename);	
			booksService.booksAdd(books);
		}catch (Exception e) {
			e.printStackTrace();
			/*model.addAttribute("msg", "서버오류입니다.");
			model.addAttribute("url","/product/list");
			return "/error.jsp";*/
		}	
		
		return "redirect:/books/list";		
	}
}
