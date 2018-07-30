package com.inc.domain;

import javax.validation.constraints.Pattern;

public class Reply {
	private int rno;
	private int idx;
	private String nickname;
	@Pattern(regexp=".*{1,300}", message="1자이상 300자 이하로 내용을 입력해주세요.")
	private String comments;
	private String regdate;
	private Board board;

	
	public Board getBoard() {
		return board;
	}
	public void setBoard(Board board) {
		this.board = board;
	}
	
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
		this.comments = comments.trim();
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
