package com.inc.domain;

import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Range;

public class Board {
	private int idx;
	@Size(min=5, max=30, message="제목은 - 5~10글자이내")
	private String title;
	private String nickname;
	@Size(min=10, max=1000, message="내용은 - 10~1000글자이내")
	private String comments;
	private int cnt;
	private String regdate;
	@Range(min=1, max=5, message="유형을 선택해주세요")
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
