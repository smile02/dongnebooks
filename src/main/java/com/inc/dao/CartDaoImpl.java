package com.inc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.Cart;

@Repository
public class CartDaoImpl implements CartDao {
	@Autowired
	private SqlSession session;

	@Override
	public void cartAdd(Cart cart) {
		session.insert("cart.cartAdd", cart);
	}

	@Override
	public List<Cart> getCartList(Map<String, Object> cartMap) {
		return session.selectList("cart.getCartList", cartMap);
	}

	@Override
	public void statusChange(Map<String, Object> paramMap) {
		session.update("cart.statusChange", paramMap);
	}

	@Override
	public int getTotalCount(String nickname) {
		return session.selectOne("cart.getTotalCount", nickname);
	}

}
