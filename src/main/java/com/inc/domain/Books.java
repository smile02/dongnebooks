package com.inc.domain;

import org.springframework.web.multipart.MultipartFile;

public class Books {
	private int idx;
//	@Size(min=1,max=10,message="제목은 1~10글자 이내")
	private String title;
	private String nickname;
//	@Size(min=1,max=300,message="내용은 1~300글자 이내")
	private String comments;
	private String regdate;
//	@Pattern(regexp="[0-9]*",message="책 가격은 숫자만 입력해주세요.")
	private int price;
//	@NotNull(message="책 상태를 선택해주세요.")
	private String status;
//	@Pattern(regexp="[0-9]*",message="배송비는 숫자만 입력해주세요.")
	private int fee;
	private String photo;
	private MultipartFile photo_file;
	private String d_type;
//	@Pattern(regexp="[가-힣]{2,30}",message="저자는 2~30글자 이내")
	private String author;
//	@NotNull(message="대분류를 선택해주세요.")
	private String b_category;
//	@NotNull(message="대분류를 선택해주세요.")
	private String s_category;
	private String deal;
	
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
	
	
}
