package com.inc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.inc.domain.Books;
import com.inc.service.BooksService;
import com.inc.service.FileService;

@Controller
@SessionAttributes(value= {"bk"})
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
	
	//도서를 판매할 사람이 "도서 등록"버튼을 클릭 했을 때
	@RequestMapping(value ="/books/add", method= RequestMethod.POST)
	@ResponseBody
	public Map<String, String> booksAdd(@ModelAttribute("books") @Valid Books books, BindingResult result,
							HttpServletRequest request,Model model) {
		System.out.println(books.getAuthor());
		
		Map<String, String> erMap = new HashMap<>();
		if(result.hasErrors()) {
			for(ObjectError error : result.getAllErrors()) {
				System.out.println(error.getCode()+":"+error.getDefaultMessage());				
				erMap.put("error", error.getDefaultMessage());
			}
			model.addAttribute("booksList",booksService.booksList());
			model.addAttribute("books",books);
			return erMap;
		}
		
		try {
			//파일 저장
			String path = request.getServletContext().getRealPath("/WEB-INF/resources/image/photo");			
			String filename;
			filename = fileService.saveFile(path, books.getPhoto_file());
			books.setPhoto(filename);
			erMap.put("success", "y");
			booksService.booksAdd(books);
		}catch (Exception e) {
			e.printStackTrace();
			/*model.addAttribute("msg", "서버오류입니다.");
			model.addAttribute("url","/product/list");
			return "/error.jsp";*/
		}	
		
		return erMap;		
	}
	
	//도서목록에서 "자세히 보기"버튼을 클릭 했을 때 등록한 책의 상세정보를 볼 수 있도록
	@RequestMapping(value="/books/view", method=RequestMethod.POST)
	@ResponseBody
	public String booksView(@RequestParam int idx,Model model){
		
		Books books = booksService.booksView(idx);
		if(books != null) {
			model.addAttribute("bk",books);
			return "y";
		}				
		
		return "n";
	}
	
	//판매자 본인일 경우에만 수정이 가능하도록
	
}
