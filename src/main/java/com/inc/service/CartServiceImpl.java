package com.inc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inc.dao.CartDao;
import com.inc.domain.Cart;

@Service
public class CartServiceImpl implements CartService {
	public static int numberOfList = 5;
	public static int numberOfPage = 3;
	@Autowired
	private CartDao cartDao;
	
	@Override
	public void cartAdd(Cart cart) {
		cartDao.cartAdd(cart);
	}

	@Override
	public List<Cart> getCartList(String nickname, int page) {
		Map<String, Object> cartMap = getCartMap(nickname, page);
		return cartDao.getCartList(cartMap);
	}
	
	

	private Map<String, Object> getCartMap(String nickname, int page) {
		Map<String, Object> cartMap = new HashMap<>();
		int start = (page-1)*numberOfList + 1;
		int end = start + numberOfList -1;
		
		cartMap.put("start", start);
		cartMap.put("end", end);
		cartMap.put("nickname", nickname);
		
		return cartMap;
	}

	@Override
	public void statusChange(Map<String, Object> paramMap) {
		cartDao.statusChange(paramMap);
	}

	@Override
	public int getTotalCount(String nickname) {
		return cartDao.getTotalCount(nickname);
	}

	@Override
	public List<Cart> getSaleList(String nickname, int page) {
		Map<String, Object> cartMap = getCartMap(nickname, page);
		return cartDao.getSaleList(cartMap);
	}

	@Override
	public int getSaleTotal(String nickname) {
		return cartDao.getSaleTotal(nickname);
	}

}
