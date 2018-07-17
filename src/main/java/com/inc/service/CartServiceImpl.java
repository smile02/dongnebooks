package com.inc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.inc.dao.BooksDao;
import com.inc.dao.CartDao;
import com.inc.domain.Cart;

@Service
public class CartServiceImpl implements CartService {
	public static int numberOfList = 5;
	public static int numberOfPage = 3;
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private BooksDao booksDao;
	
	@Transactional(rollbackFor=RuntimeException.class)
	@Override
	public void cartAdd(Cart cart) {
		Map<String, Object> dealMap = dealMap(cart.getIdx(), "deal");
		booksDao.dealChange(dealMap);
		cartDao.cartAdd(cart);
	}
	
	private Map<String, Object> dealMap(int idx, String status){
		Map<String, Object> dealMap = new HashMap<>();
		dealMap.put("idx", idx);
		dealMap.put("status", status);
		return dealMap;
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

	@Transactional(rollbackFor=RuntimeException.class)
	@Override
	public void statusChange(Map<String, Object> paramMap) {
		int idx = cartDao.getIdx((int)(paramMap.get("num")));
		System.out.println(idx);
		System.out.println((String)(paramMap.get("status")));
		Map<String, Object> dealMap = dealMap(idx, (String)(paramMap.get("status")));
		booksDao.dealChange(dealMap);
		//int i = 5 / 0;
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
