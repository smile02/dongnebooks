package com.inc.domain;

import javax.validation.constraints.Size;

public class Reply {
	private int rno;
	private int idx;
	private String nickname;
	@Size(min=1, max=300, message="1글자 이상 300글자 미만으로 댓글을 작성해주세요.")
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
