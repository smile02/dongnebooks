package com.inc.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import com.inc.domain.Users;
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
	public String booksList(Model model,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(required=false) String tag) {
		
		//사용자가 태그버튼을 클릭했을 때의 기본값
		String searchParam = "";
		if(tag != null && !tag.equals("all")) { //전체검색 외에 다른 옵션을 선택 했다는 뜻
			searchParam = "&tag="+tag;
		}
		List<Books> booksList = booksService.booksList(tag, page);
		
		for(Books book : booksList) {
			try {
				//현재시간을 불러와서 형식을 년-월-일 시:분:초 로 변환
				Calendar calendar = Calendar.getInstance();
				SimpleDateFormat curFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S", Locale.KOREA);
				//변환한 시간을 스트링으로 저장
				String curDate = curFormat.format(calendar.getTime());
				
				//아래에서 도서등록시간과 현재시간을 아래의 형식으로 변환해줄 변수
				SimpleDateFormat changeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S", Locale.KOREA);
				
				//Date클래스를 사용하여 현재시간과 도서등록시간을 String형태에서 Date형태로 변환
				Date curTime = changeFormat.parse(curDate);
				Date regTime = changeFormat.parse(book.getRegdate());
				
				//현재시간을 밀리세컨드, 등록시간을 밀리세컨드로 변환한 후 뺀 값을 diffTime에 넣기
				long diffTime = curTime.getTime() - regTime.getTime();
				
				//넣은 값을 (1시간)으로 나누어서 out타임에 저장
				long outTime = diffTime / (1000*60*60);
				
				//반복문이 돌때마다 outTime즉 차이나는 시간이 2시간보다 작을때만 newBooks를 true로
				if(outTime < 2) {
					book.setNewBooks(true);
				}else {
					book.setNewBooks(false);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}			
		}
		
		//현재 등록되어져 있는 태그들의 목록을 불러온다.
		model.addAttribute("tagList",booksService.tagList());
		//전체 도서목록을 불러온다.
		model.addAttribute("booksList",booksList);
		//자세히보기에서 대분류에 들어가야 할 내용들을 미리 넣어준다.
		model.addAttribute("bigCategory",categoryService.bigCategoryList());
		//도서목록 페이지에서 페이징이 가능하도록 page의 번호 가져오기
		model.addAttribute("paging", paging.getPaging("/books/list",
				page,
				booksService.getTotalCount(tag, page),
				BooksServiceImpl.numberOfList,
				BooksServiceImpl.numberOfPage,
				searchParam));
						
		return "/books/booksList.jsp";
	}
	
	@RequestMapping(value="/books/add", method=RequestMethod.GET)
	public String booksAdd() {
		System.out.println("여기로 옴");
		return "redirect:/books/list";
	}
	
	//도서를 판매할 사람이 "도서 등록"버튼을 클릭 했을 때
	@RequestMapping(value ="/books/add", method= RequestMethod.POST)
	@ResponseBody
	public Map<String,Map<String,String>> booksAdd(@ModelAttribute @Valid Books books,BindingResult result,HttpServletRequest request) {
		
		//booksValid에서 사용자가 도서등록을 클릭했을 때 정규표현식에 대한 정보를 가져오기 위한 Map
		Map<String,Map<String,String>> keyMap = booksValid(books,result);
		System.out.println("keyMap.get(\"error\") : "+keyMap.get("error"));
		
		//booksValid에서 error가 있다면 error라는 키에 저장하고 있는데,
		//이때 에러가 발생한다면 에러가 들어있는 Map을 그대로 리턴
		if(keyMap.get("error") == null) {
			//error라는 키가 없을 경우 사용자가 입력한 값 정상적으로 insert
			Users nick_user = (Users) request.getSession().getAttribute("user");
			try {
				//파일 저장
				String path = request.getServletContext().getRealPath("/WEB-INF/resources/image/photo");			
				String filename;
				filename = fileService.saveFile(path, books.getPhoto_file());
				books.setPhoto(filename);
				System.out.println(nick_user.getNickname());
				books.setNickname(nick_user.getNickname());
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
		//전체 도서목록 중 사용자가 "자세히 보기"를 클릭한 도서에 대한 정보면 가져온다.
		Books books = booksService.booksView(idx);
				
		Map<String, Books> resMap = new HashMap<>();		
		//위에서 정보를 제대로 가져왔다면
		if(books != null) {
			//book이라는 키에 가져온 정보들을 매칭
			resMap.put("book", books);
			//Cookie로 가져온 정보에 대한 idx값을 넣어준다.
			response.addCookie(new Cookie("idx",books.getIdx()+""));
			System.out.println(books.getIdx());
			return resMap;
		}				
		
		return resMap;
	}
	
	@RequestMapping(value="/books/mod", method=RequestMethod.GET)
	public String booksMod() {
		
		return "redirect:/books/list";
	}	
	
	//판매자 본인일 경우에만 수정이 가능하도록
	@RequestMapping(value="/books/mod", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Map<String,String>> booksMod(@ModelAttribute @Valid Books books,
			BindingResult result,@CookieValue Cookie idx) {
		
		//booksValid에서 error가 있다면 error라는 키에 저장하고 있는데,
		//이때 에러가 발생한다면 에러가 들어있는 Map을 그대로 리턴
		Map<String, Map<String, String>> keyMap = booksValid(books,result);
		
		if(keyMap.get("error") == null) {
			//error라는 키가 없다는 것은 에러가 없다는 뜻.
			//@CookieValue로 "자세히 보기"에서 Cookie에 등록한 값을 가져와서 idx를 넣어주고
			//해당 idx에 대한 정보만 수정
			books.setIdx(Integer.parseInt(idx.getValue()));		
			System.out.println("수정 : "+books.getIdx());		
			booksService.booksMod(books);
		}
		
		return keyMap;
	}	
	
	@RequestMapping(value = "/books/adminDelete", method=RequestMethod.POST)
	@ResponseBody
	public String adminDelete(@RequestParam int idx) {
		booksService.adminDelete(idx);
		return "y";
	}
	
	//유효성검사를 진행하는 메서드
	public Map<String,Map<String,String>> booksValid(@ModelAttribute @Valid Books books,
													BindingResult result){
		
		//booksAdd와 booksMod에서 사용중인 메서드
		//유효성 검사를 위한 메서드이다.
		Map<String,Map<String,String>> keyMap = new HashMap<>();
		Map<String, String> erMap = new HashMap<>();
		
		if(result.hasErrors()) {
			for(ObjectError error : result.getAllErrors()) {
				System.out.println(error.getCode()+":"+error.getDefaultMessage());
				
				//Books에서 message에 jsp의 name값:으로 메세지를 지정해서 그걸 기준으로 error라는 키에 저장
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