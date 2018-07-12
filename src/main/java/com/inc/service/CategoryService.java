package com.inc.service;

import java.util.List;

import com.inc.domain.BigCategory;
import com.inc.domain.SmallCategory;

public interface CategoryService {

	List<BigCategory> bigCategoryList();

	List<SmallCategory> smallCategoryList(String b_name);

}