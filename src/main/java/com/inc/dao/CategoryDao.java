package com.inc.dao;

import java.util.List;

import com.inc.domain.BigCategory;
import com.inc.domain.SmallCategory;

public interface CategoryDao {

	List<BigCategory> bigCategoryList();

	List<SmallCategory> smallCategoryList(String b_name);

}