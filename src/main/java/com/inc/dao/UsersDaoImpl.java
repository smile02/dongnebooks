package com.inc.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.inc.domain.Users;

@Repository
public class UsersDaoImpl implements UsersDao {
	@Autowired
	private SqlSession session;
	
	@Override
	public Users getUser(String id) {
		return session.selectOne("users.getUser", id);
	}

	@Override
	public Users nickCheck(String nickname) {
		return session.selectOne("users.nickCheck", nickname);
	}

	@Override
	public void signup(Users user) {
		session.insert("users.signup", user);
	}

	@Override
	public boolean emailCheck(String email) {
		//중복되는 이메일이 있으면 true 리턴
		return session.selectOne("users.emailCheck", email) != null;
	}

	@Override
	public String findID(String email) {
		return session.selectOne("users.findID", email);
	}

	@Override
	public void updatePwd(Users user) {
		session.update("users.updatePwd", user);
	}

	@Override
	public void update(Users user) {
		session.update("users.update", user);
	}

	@Override
	public void keepLogin(String id, String sessionId, Date next) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next", next);
		session.update("users.keepLogin", paramMap);
	}

	@Override
	public Users checkUserWithSessionKey(String value) {
		return session.selectOne("checkUserWithSessionKey", value);
	}

}
