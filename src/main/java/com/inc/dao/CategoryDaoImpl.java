package com.inc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.BigCategory;
import com.inc.domain.SmallCategory;

@Repository
public class CategoryDaoImpl implements CategoryDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<BigCategory> bigCategoryList() {
		return session.selectList("category.bigCategoryList");
	}

	@Override
	public List<SmallCategory> smallCategoryList(String b_name) {
		return session.selectList("category.smallCategoryList",b_name);
	}

}
