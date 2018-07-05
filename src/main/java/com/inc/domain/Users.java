package com.inc.domain;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class Users {
	@NotEmpty(message="사용할 닉네임을 입력해 주세요.")
	@Size(min=2, max=15, message="2자이상 15자 이하로 닉네임을 입력해주세요.")
	private String nickname;
	@Pattern(regexp="[0-9a-z]{4,20}", message="소문자+숫자 4자이상 20자 이하로 아이디를 입력해 주세요.")
	private String id;
	@Pattern(regexp="[0-9a-zA-Z]{4,20}", message="영문자+숫자 4자 이상 20자 이하로 비밀번호를 입력해주세요.")
	private String password;
	private String passwordConfirm;
	@NotEmpty(message="이메일을 입력해 주세요.")
	@Pattern(regexp="[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}", message="입력하지 않았거나 잘못된 이메일 형식입니다.")
	private String email;
	private String emailcode;
	@Pattern(regexp="01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})", message="잘못된 형식입니다.")
	private String phone;
	private String address;
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPasswordConfirm() {
		return passwordConfirm;
	}
	public void setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm = passwordConfirm;
	}
	
	public boolean isPasswordEqual() {
		return this.password.equals(this.passwordConfirm);
	}
	public String getEmailcode() {
		return emailcode;
	}
	public void setEmailcode(String emailcode) {
		this.emailcode = emailcode;
	}
}
