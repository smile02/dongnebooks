package com.inc.util;

public class Paging {
	public String getPaging(String url, int nowPage, int totalCount,
			int numberOfList, int numberOfPage, String searchParam) {
		/*
		 nowPage : 현재 선택한 페이지의 수
		 totalCount : 전체 게시글의 수
		 numberOfList : 현재 선택한 페이지에서 보여지는 게시글의 수
		 numberOfPage : 한 화면에 보여지는 페이지의 수 
		 */ 
		StringBuffer sb = new StringBuffer();
		
		//numberofList : 8
		//numberOfPage : 5
		
		// 전체 페이지 수
		int totalPage;
		// 시작 페이지
		int startPage;
		// 마지막 페이지
		int endPage;

		// 다음페이지 존재여부
		boolean isNextPage;
		// 이전페이지 존재여부
		boolean isPrevPage;
		// 전체 페이지의 수 구하기
		if (totalCount % numberOfList == 0) { //전체게시글 % 보여지는 게시글의 수
			totalPage = totalCount / numberOfList;
		} else {
			totalPage = totalCount / numberOfList + 1;
		}
		
		// 시작 페이지 구하기
		startPage = (nowPage - 1) / numberOfPage * numberOfPage + 1;
		//여기서의 시작페이지는 오른쪽 버튼을 클릭했을 때 시작하는 페이지
		// (선택한 페이지 -1) / 한 화면의 페이지 * 한 화면의 페이지 +1;
		// 마지막 페이지 구하기
		endPage = startPage + numberOfPage - 1;
		//한 화면에서의 마지막 페이지 수
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		// 전체 페이지 수 가 5인데 마지막 페이지가 6으로 나올 경우
		
		// 다음페이지 존재여부
		//전체 페이지의 수 >= 한 화면에서의 시작페이지 수 + 한 화면에서 보여지는 페이지의 수
		// 
		if (totalPage >= startPage + numberOfPage) {
			//nowPage -1
			isNextPage = true;
		} else {
			isNextPage = false;
		}

		// 이전페이지 존재여부
		if (nowPage > numberOfPage) {
			isPrevPage = true;
		} else {
			isPrevPage = false;
		}
		// 이전페이지 작성
		if (isPrevPage) {
			sb.append("<li class='page-item'><a class='page-link' href='" + url + "?page=");
			sb.append(nowPage - numberOfPage+searchParam);
			sb.append("'><span>&laquo;</span></a></li>");			
		} else {
			sb.append("<li class='disabled page-item'><a class='page-link'><span>&laquo;</span></a></li>");
		}
		// 페이지 목록
		for (int i = startPage; i <= endPage; i++) {
			if(i == nowPage) { //선택한 페이지와 i의 값이 일치할 때에는 a태그 적용 x
				sb.append("<li class='active page-item'><a class='page-link'>"+i+"</a></li>");
			}else {
				sb.append("<li class='page-item'><a class='page-link' href='" + url + "?page=");
				sb.append(i +searchParam+ "'>");
				sb.append(i + "</a></li>");				
			}
		}

		// 다음페이지 작성
		if (isNextPage) {
			sb.append("<li class='page-item'><a class='page-link' href='" + url + "?page=");
			if(nowPage + numberOfPage > totalPage) {
				//현재페이지 + 한 화면에서의 페이지 수가 전체 페이지의 수 보다 클 때
				sb.append(totalPage);
			}else {
				sb.append(nowPage + numberOfPage);
			}
			sb.append(searchParam);
			sb.append("'><span>&raquo;</span></a></li>");
		} else {
			sb.append("<li class='disabled page-item'><a class='page-link'><span>&raquo;</span></a></li>");
		}

		return sb.toString();
	}
}
