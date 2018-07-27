package com.inc.domain;

import java.util.*;

public class Message {
	private String to, from, msg;
	private long userCnt;
	private List<String> userList;
	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public long getUserCnt() {
		return userCnt;
	}

	public void setUserCnt(long userCnt) {
		this.userCnt = userCnt;
	}

	public List<String> getUserList() {
		return userList;
	}

	public void setUserList(List<String> userList) {
		this.userList = userList;
	}	
}
