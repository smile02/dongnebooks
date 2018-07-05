package com.inc.dao;

import com.inc.domain.Users;

public interface UsersDao {
	//회원정보 불러오기, id 중복체크
	public Users getUser(String id);
	//회원가입&정보변경시 닉네임 중복체크
	public Users nickCheck(String nickname);
	//회원가입
	public void signup(Users user);
	//이메일 중복체크
	public boolean emailCheck(String email);

}
