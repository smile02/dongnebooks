package com.inc.service;

import java.util.List;
import java.util.Map;

import com.inc.domain.Cart;

public interface CartService {
	//구매요청(cart) 테이블에 담기
	public void cartAdd( Cart cart);
	//내 구매요청 목록 가져오기.
	public List<Cart> getCartList(String nickname, int page);
	//내 구매상태 변경하기.
	public void statusChange(Map<String, Object> paramMap);
	//전체 개체 수 구하기.
	public int getTotalCount(String nickname);

}
