package com.inc.service;

import java.util.List;

import com.inc.domain.Users;

public interface UsersService {
	//관리자(admin)용 회원리스트 메서드(협의 하에 게시판 형식으로 만들어 볼 예정.)
	public List<Users> userList() throws Exception;
	//회원정보 보기
	public Users getUser() throws Exception;
	//회원 가입(insert)
	public void signup(Users User) throws Exception;
	//아이디 중복체크
	public Boolean idCheck(String id) throws Exception;
	//인증 이메일 발송
	public String sendCertifyEmail(String email) throws Exception;
	//회원정보 삭제 기능은 외래 키 제약조건 삭제 후 on delete 옵션 추가해서 재설정해야 가능하므로 협의 후 진행예정.
}