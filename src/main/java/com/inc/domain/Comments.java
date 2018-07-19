package com.inc.domain;

import javax.validation.constraints.Size;

public class Comments {
	private int rno;
	private int idx;
	private String nickname;
	@Size(min=1, max=100, message="댓글은 100자까지 입력 가능합니다.")
	private String comments;
	private String regdate;

	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
