package com.inc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.domain.Books;
import com.inc.service.BooksService;
import com.inc.service.BooksServiceImpl;
import com.inc.service.CategoryService;
import com.inc.service.FileService;
import com.inc.util.Paging;

@Controller
public class BooksController {
	
	@Autowired
	private BooksService booksService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private Paging paging;

	//책의 목록을 보여주는 메서드
	@RequestMapping(value = "/books/list", method=RequestMethod.GET)
	public String booksList(Model model,HttpServletRequest request,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(required=false) String tag) {
		
		String searchParam = "";
		if(tag != null && !tag.equals("all")) { //전체검색 외에 다른 옵션을 선택 했다는 뜻
			searchParam = "&option="+tag;
		}
				
		model.addAttribute("booksList",booksService.booksList(tag, page));
		model.addAttribute("bigCategory",categoryService.bigCategoryList());
		model.addAttribute("books",new Books());
		model.addAttribute("paging", paging.getPaging("/books/list",
				page,
				booksService.getTotalCount(tag, page),
				BooksServiceImpl.numberOfList,
				BooksServiceImpl.numberOfPage,
				searchParam));
		
		request.getSession().setAttribute("nick", "test");
				
		return "/books/booksList.jsp";
	}
	
	//도서를 판매할 사람이 "도서 등록"버튼을 클릭 했을 때
	@RequestMapping(value ="/books/add", method= RequestMethod.POST)
	@ResponseBody
	public Map<String,Map<String,String>> booksAdd(@ModelAttribute @Valid Books books,BindingResult result,HttpServletRequest request) {
		
		Map<String,Map<String,String>> keyMap = booksValid(books,result);		
		if(keyMap == null && !result.hasErrors()) {
			try {
				//파일 저장
				String path = request.getServletContext().getRealPath("/WEB-INF/resources/image/photo");			
				String filename;
				filename = fileService.saveFile(path, books.getPhoto_file());
				books.setPhoto(filename);
				booksService.booksAdd(books);
			}catch (Exception e) {
				e.printStackTrace();
			}	
		}
		
		
		return keyMap;		
	}
	
	//도서목록에서 "자세히 보기"버튼을 클릭 했을 때 등록한 책의 상세정보를 볼 수 있도록
	@RequestMapping(value="/books/view", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Books> booksView(@RequestParam int idx,
							HttpServletResponse response,Model model,
							HttpServletRequest request){
		Books books = booksService.booksView(idx);
		
		Map<String, Books> resMap = new HashMap<>();		
		if(books != null) {
			resMap.put("book", books);
			response.addCookie(new Cookie("idx",books.getIdx()+""));
			System.out.println(books.getNickname());
			System.out.println(books.getIdx());
			return resMap;
		}				
		
		return resMap;
	}
	
	//판매자 본인일 경우에만 수정이 가능하도록
	@RequestMapping(value="/books/mod", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Map<String,String>> booksMod(@ModelAttribute @Valid Books books,
			BindingResult result,@CookieValue Cookie idx) {
		
		
		Map<String, Map<String, String>> keyMap = booksValid(books,result);
		
		if(keyMap == null && !result.hasErrors()) {
			books.setIdx(Integer.parseInt(idx.getValue()));		
			System.out.println("수정 : "+books.getIdx());		
			booksService.booksMod(books);
		}
		
		return keyMap;
	}	
	
	//유효성검사를 진행하는 메서드
	public Map<String,Map<String,String>> booksValid(@ModelAttribute @Valid Books books,
													BindingResult result){
		
		Map<String,Map<String,String>> keyMap = new HashMap<>();
		Map<String, String> erMap = new HashMap<>();
		
		if(result.hasErrors()) {
			for(ObjectError error : result.getAllErrors()) {
				System.out.println(error.getCode()+":"+error.getDefaultMessage());
				String err_code = error.getDefaultMessage().substring(0, error.getDefaultMessage().indexOf(":"));
				String err=error.getDefaultMessage().substring(error.getDefaultMessage().indexOf(":")+1, error.getDefaultMessage().length());
				erMap.put(err_code, err);
				keyMap.put("error", erMap);
			}			
			return keyMap;
		}
		
		return keyMap;
	}

}
