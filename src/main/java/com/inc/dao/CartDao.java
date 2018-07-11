package com.inc.dao;

import java.util.List;
import java.util.Map;

import com.inc.domain.Cart;

public interface CartDao {

	public void cartAdd(Cart cart);

	public List<Cart> getCartList(Map<String, Object> cartMap);

	public void statusChange(Map<String, Object> paramMap);

	public int getTotalCount(String nickname);

}
