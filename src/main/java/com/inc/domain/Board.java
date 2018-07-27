package com.inc.domain;

import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Range;

public class Board {
	private int idx;
	@Pattern(regexp="[0-9a-zA-Z가-힣!@#$%^&*]{5,30}", message="영문,숫자,한글 5자이상 30자 이하로 제목을 입력해주세요.")
	private String title;
	private String nickname;
	@Pattern(regexp="[0-9a-zA-Z가-힣]{10,1000}", message="영문,숫자,한글 10자이상 1000자 이하로 내용을 입력해주세요.")
	private String comments;
	private int cnt;
	private String regdate;
	@Range(min=1, max=5, message="어떤 게시물을 작성하시겠습니까?")
	private int code;
	private List<Reply> replyList;
	private int replysize;
	
	public int getReplysize() {
		return replysize;
	}
	public void setReplysize(int replysize) {
		this.replysize = replysize;
	}
	public List<Reply> getReplyList() {
		return replyList;
	}
	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	
}
