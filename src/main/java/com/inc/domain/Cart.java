package com.inc.domain;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class Cart {
	private int num;
	private String nickname;
	@NotEmpty(message="주소를 입력해 주세요.")
	private String address;
	@NotEmpty(message="거래 방법을 선택해 주세요.")
	private String d_type;//거래유형
	@NotEmpty(message="해당 부분은 선택하실 수 없습니다.")
	private String status;//거래상태 - 요청, 준비, 거절, 배송, 완료
	private int idx;
	@Size(min=0, max=65, message="요청사항은 최대 65자 이하로 입력가능합니다.")
	private String request;
	private String name;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getD_type() {
		return d_type;
	}
	public void setD_type(String d_type) {
		this.d_type = d_type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
