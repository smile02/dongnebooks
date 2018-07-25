package com.inc.domain;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

public class Books {
	private int idx;
	@Size(min=1, max=10, message="title:제목 - 한글 1~10글자이내")
	private String title;
	private String nickname;
	@Size(min=1, max=300, message="comments:내용 - 한글 1~300글자이내")
	private String comments;
	private String regdate;
	@Range(min=1, max=9999999, message="price:가격 - 예)1000")
	private int price;
	@Pattern(regexp="[abcdef]", message="status:상태 - 잘못된 선택입니다.")
	private String status;
	@Range(min=0, max=9999999, message="fee:배송비- 예)1000")
	private int fee;
	private String photo;
	private MultipartFile photo_file;
	private String d_type;
	@Pattern(regexp="[가-힣]{0,30}",message="author:저자 - 한글 1~30글자이내")
	private String author;
	@NotNull(message="b_category: 대분류 -잘못된 선택입니다.")
	private String b_category;
	@NotNull(message="s_category: 소분류 -잘못된 선택입니다.")
	private String s_category;
	private String deal;
	private int commentsSize;
	private boolean newBooks;
	
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
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getFee() {
		return fee;
	}
	public void setFee(int fee) {
		this.fee = fee;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getD_type() {
		return d_type;
	}
	public void setD_type(String d_type) {
		this.d_type = d_type;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getB_category() {
		return b_category;
	}
	public void setB_category(String b_category) {
		this.b_category = b_category;
	}
	public String getS_category() {
		return s_category;
	}
	public void setS_category(String s_category) {
		this.s_category = s_category;
	}
	public String getDeal() {
		return deal;
	}
	public void setDeal(String deal) {
		this.deal = deal;
	}
	public MultipartFile getPhoto_file() {
		return photo_file;
	}
	public void setPhoto_file(MultipartFile photo_file) {
		this.photo_file = photo_file;
	}
	public int getCommentsSize() {
		return commentsSize;
	}
	public void setCommentsSize(int commentsSize) {
		this.commentsSize = commentsSize;
	}
	public boolean isNewBooks() {
		return newBooks;
	}
	public void setNewBooks(boolean newBooks) {
		this.newBooks = newBooks;
	}
	
	
}