package com.inc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inc.dao.CategoryDao;
import com.inc.domain.BigCategory;
import com.inc.domain.SmallCategory;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDao categoryDao;
	
	@Override
	public List<BigCategory> bigCategoryList() {		
		return categoryDao.bigCategoryList();
	}

	@Override
	public List<SmallCategory> smallCategoryList(String b_name) {
		return categoryDao.smallCategoryList(b_name);
	}

}
