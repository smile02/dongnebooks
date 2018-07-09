package com.inc.service;

import java.util.List;

import javax.validation.Valid;

import com.inc.domain.Users;

public interface UsersService {
	//관리자(admin)용 회원리스트 메서드(협의 하에 게시판 형식으로 만들어 볼 예정.)
	public List<Users> userList();
	//회원정보 보기& ID중복체크
	public Users getUser(String id);
	//회원 가입(insert)
	public void signup(Users user);
	//인증 이메일 발송
	public String sendCertifyEmail(String email);
	//회원가입&회원정보 수정시 닉네임 중복체크
	public Users nickCheck(String nickname);
	//이메일 중복체크
	public boolean emailCheck(String email);
	//아이디 찾기
	public String findId(String email);
	//임시비밀번호로 업데이트 후 받아오기
	public String getTempPwd(String id);
	//회원정보변경
	public void update(Users user);
	//비밀번호 변경
	public void updatePwd(Users user);
}