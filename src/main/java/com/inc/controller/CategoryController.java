package com.inc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inc.domain.SmallCategory;
import com.inc.service.CategoryService;

@Controller
public class CategoryController {

	@Autowired
	private CategoryService categoryServie;
	
	@RequestMapping(value="/categorys/scate", method=RequestMethod.POST)
	@ResponseBody
	public List<SmallCategory> sCategory(@RequestParam String b_name) {
		
		List<SmallCategory> smallCategoryList = categoryServie.smallCategoryList(b_name);
		
		return smallCategoryList;
	}
	
}
