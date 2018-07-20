<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>도서목록</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.1.1/minty/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4eGtnTOp6je5m6l1Zcp2WUGR9Y7kJZuAiD3Pk2GAW3uNRgHQSIqcrcAxBipzlbWP"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css" />
<style>
/* .thumbnail {
	height: 450px;
}
.img-container {
	height: 220px;
	margin-top:15px;
}
.thumbnail img {
	width: 100%;
	height: 100% !important;
}
.detail-modal {
	height: auto;
}
.photo {
	height: 220px;
}
.photo-hei {
	width: 100%;
	height: 200px !important;
} */
.err_color {
	color: red;
}
.left-btn{
	margin-left:10px;
}
.regBtn{
	margin-right:10px;
} 
.sold_out{
	opacity: 0.6;
    filter: alpha(opacity=40)
}
.paging{
	display:inline-block;
}
.pagination{
	margin-top:15px;
}
</style>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	
	<div class="container">
	<div class="row">
			<div class="col-sm-12">
				<div class="jumbotron">
					<h1 class="display-6">Welcome to DongneBooks!</h1>
					<p class="lead">This is a simple hero unit, a simple
						jumbotron-style component for calling extra attention to featured
						content or information.</p>
					<hr class="my-4">
					<p>It uses utility classes for typography and spacing to space
						content out within the larger container.</p>
				</div>
			</div>			
		</div>

		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg navbar-dark bg-primary">								
			  <a class="navbar-brand" href="/books/list?tag=all">전체보기</a>
			 	<!-- <button type="button" class="navbar-brand" name="all" onclick="tag(t);">전체보기</button> -->
			 	 
			 	 <button class="navbar-toggler" type="button" 
			 	 	data-toggle="collapse" data-target="#navbarColor02" 
			 	 aria-controls="navbarColor02" aria-expanded="false" 
			 	 aria-label="Toggle navigation" style="" name="all">
			    <span class="navbar-toggler-icon"></span>
			  </button>
			
			  <div class="collapse navbar-collapse" id="navbarColor02">
			    <ul class="navbar-nav mr-auto">
			    <c:forEach var="tag" items="${tagList }">
			      <li class="nav-item active">
			        <a class="nav-link" href="/books/list?tag=${tag }">${tag} <span class="sr-only">(current)</span></a>
			      </li>
			    </c:forEach>
			      
    		</ul>
			    <form class="form-inline my-2 my-lg-0">
			      	<c:if test="${not empty user.nickname}">
					<button id="modal" type="button"
						class="btn btn-secondary regBtn my-2 my-sm-0" data-toggle="modal"
									data-target="#booksList" style="position: absolute; right: 0;">
						도서 등록</button>
					</c:if>
					<c:if test="${empty user.nickname}">
						<button type="button" class="btn btn-danger  regBtn my-2 my-sm-0"
							onclick="login();" style="position: absolute; right: 0;">도서
							등록</button>
					</c:if>
			    </form>
			  </div>
			</nav>
			</div>
		</div>

		<div class="row">
					<c:forEach var="books" items="${booksList }">
					<c:if test="${books.deal ne 'complete' }">
						<div class="col-md-3 col-xs-6">
							<div class="thumbnail">
								<div class="img-container">
									<c:if test="${books.photo ne 'no_file' && books.photo != null}">
										<img src="/image/photo/${books.photo }" />
									</c:if>									
									<c:if test="${books.photo == 'no_file' || books.photo == null}">
										<img src="/image/photo/noimage.png" />
									</c:if>

								</div>
								<div class="caption">
									<h4>작성자 : ${books.nickname }</h4>
									<p>제목 : ${books.title }</p>
									<p>
										게시일 :
										<f:parseDate var="date" value="${books.regdate }"
											pattern="yyyy-MM-dd" />
										<f:formatDate value="${date }" pattern="yy년 MM월 dd일" />																												
									</p>
									<p>가격 : ${books.price }원</p>
									<p>
										책 상태 :
										<c:if test="${books.status == 'a'}">최상</c:if>
										<c:if test="${books.status == 'b'}">상</c:if>
										<c:if test="${books.status == 'c'}">중상</c:if>
										<c:if test="${books.status == 'd'}">중</c:if>
										<c:if test="${books.status == 'e'}">중하</c:if>
										<c:if test="${books.status == 'f'}">하</c:if>
									</p>
									<span>

										<button id="detail" type="button"
											class="btn btn-primary btn-xs detail_btn"
											onclick="detail(${books.idx});">자세히 보기</button>
										<c:if test="${sessionScope.user.nickname eq '관리자' }">
											<button id="admin_delete" type="button"
											class="btn btn-danger btn-xs"
											onclick="adminDelete(${books.idx})">관리자 삭제</button>
										</c:if>
									</span>
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${books.deal eq 'complete' }">										
						<div class="col-md-3 col-xs-6">
							<div class="thumbnail">
								<div class="img-container sold_out">									
										<img src="/image/photo/SoldOut.jpg" />
								</div>
								<div class="caption">
									<h4>작성자 : ${books.nickname }</h4>
									<p>제목 : ${books.title }</p>
									<p>
										게시일 :
										<f:parseDate var="date" value="${books.regdate }"
											pattern="yyyy-MM-dddd HH:mm:ss" />
										<f:formatDate value="${date }" pattern="yy년 MM월 dd일" />
									</p>
									<p>가격 : ${books.price }원</p>
									<p>
										책 상태 :
										<c:if test="${books.status == 'a'}">최상</c:if>
										<c:if test="${books.status == 'b'}">상</c:if>
										<c:if test="${books.status == 'c'}">중상</c:if>
										<c:if test="${books.status == 'd'}">중</c:if>
										<c:if test="${books.status == 'e'}">중하</c:if>
										<c:if test="${books.status == 'f'}">하</c:if>
									</p>
									<span>

										<button id="detail" type="button"
											class="btn btn-primary btn-xs detail_btn"
											disabled="disabled">자세히 보기</button>										
									</span>
								</div>
							</div>
						</div>
					</c:if>
					</c:forEach>					
				</div>
				<div class="modal" id="detailModal" role="dialog"
					data-backdrop="static">
					<div class="modal-dialog">
						<div class="modal-content detail-modal">
							<div class="modal-header text-center" id="title">
								제목 : <label id="mod_title" class="control-label res_title"> </label>
								<button type="button" class="close btn-md" onclick="exit_btn()">&times;</button>
							</div>
							<div class="modal-body">
								<form id="mod_form" class="form-horizontal" method="post"
									action="/books/mod">
									<div class="form-group photo">
										<div class="col-xs-2 col-xs-offset-3">
											<label class="control-label">사진 : </label>
										</div>
										<div class="col-xs-5">
											<img id="mod_photo"
												class="form-control photo photo-hei res_photo" />
										</div>
									</div>

									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label class="control-label">작성자 : </label>
										</div>
										<div class="col-xs-5">
											<p id="mod_nickname" class="form-control res_nickname"></p>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label class="control-label">등록시간 : </label>
										</div>
										<div class="col-xs-5">
											<p id="mod_regdate" class="form-control res_regdate"></p>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_price" class="control-label">가격 : </label>
										</div>
										<div class="col-xs-5">
											<p class="form-control res_price"></p>
											<input id="mod_price" name="price" type="text"
												class="form-control" />
											<span class="error error_price err_color"></span>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_status" class="control-label">책 상태 : </label>
										</div>
										<div class="col-xs-5">
											<p class="form-control res_status"></p>
											<select name="status" id="mod_status" class="form-control">
												<option value="a">최상</option>
												<option value="b">상</option>
												<option value="c">중상</option>
												<option value="d">중</option>
												<option value="e">중하</option>
												<option value="f">하</option>
											</select><span class="error error_status err_color"></span>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_d_type" class="control-label">거래유형 : </label>
										</div>
										<div class="col-xs-5">
											<p class="form-control res_d_type"></p>
											<select id="mod_d_type" name="d_type" class="form-control"
												onchange="mod_dealtype();">
												<option value="start">택배(선불)</option>
												<option value="end">택배(착불)</option>												
												<option value="direct">직거래</option>
											</select><span class="error error_d_type err_color"></span>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_fee" class="control-label">배송비 : </label>
										</div>
										<div class="col-xs-5">
											<p class="form-control res_fee"></p>
											<input id="mod_fee" type="text" name="fee"
												class="form-control" />
											<span class="error error_fee err_color"></span>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_author" class="control-label">저자 : </label>
										</div>
										<div class="col-xs-5">
											<p class="form-control res_author"></p>
											<input id="mod_author" type="text" name="author"
												class="form-control" />
												 <span class="error error_author err_color"></span>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_b_category" class="control-label">대분류 : </label>
										</div>
										<div class="col-xs-5">
											<p class="form-control res_b_category"></p>
											<select name="b_category" id="mod_b_category"
												class="form-control view_b_category"
												onchange="getSCategory();">
												<option value="">::선택::</option>
												<c:forEach var="bcate" items="${bigCategory}">
													<option value="${bcate.b_name }">${bcate.b_name }</option>
												</c:forEach>
											</select><span class="error error_b_category err_color"></span>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_s_category" class="control-label">소분류 : </label>
										</div>
										<div class="col-xs-5">
											<p class="form-control res_s_category"></p>
											<select name="s_category" id="mod_s_category"
												class="form-control view_s_category">
												<option value="">::선택::</option>
											</select><span class="error error_s_category err_color"></span>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_deal" class="control-label">거래상태 : </label>
										</div>
										<div class="col-xs-5">
											<p class="form-control res_deal"></p>											
											<span class="error error_deal err_color"></span>
										</div>
									</div>
									<div class="form-group">
										<div class="col-xs-2 col-xs-offset-3">
											<label for="mod_comments" class="control-label">내용 : </label>
										</div>
										<div class="col-xs-5">
											<div class="form-control res_comments"
												style="overflow: scroll; width: 100%; height: 100px; padding: 10px;"></div>
											<textarea id="mod_comments" class="form-control"
												name="comments" rows="10">${bk.comments }</textarea>
											<br /> <span class="error error_comments err_color"></span>
										</div>
									</div>
									<div class="modal-footer">
									<button id="replyBtn" type="button" class="btn btn-danger">댓글 보기
									<span id="commentsCount" class="badge badge-pill badge-light"></span></button>
									<button id="buy_btn" type="button" class="btn btn-warning"
											onclick="buy(${cookie.idx.value});">구매하기</button>
										<button id="mod_btn" type="button" class="btn btn-warning"
											onclick="mod(this.form);">수정하기</button>
										<button type="button" class="btn" onclick="exit_btn();">나가기</button>
									</div>
								</form>
									<form style="display:none" id="addForm" class="form-control">
										<jsp:include page="../comments/add.jsp"/>																
									</form>
									<div style="display:none" class="row" id="listDiv">									
										<br /><h4 id="commentsTitle" class="text-center text-muted">댓글목록</h4>
										<ul class="list-group" id="replies">
										
										</ul>
									</div>
									<div class="row">
										<div class="col-sm-12 text-center">
											<div class="paging">
												<ul class="pagination pagination-sm" id="commentsPaging">
												
												</ul>
											</div>
										</div>
									</div>				
							</div>
						</div>
					</div>
				</div>
				</div>
			<div class="row">
				<div class="col-sm-12 text-center">
					<div class="paging">
						<ul class="pagination">
							${paging }
						</ul>								
					</div>
				</div>
			</div>
			<!-- Modal   -->
			<div id="booksList" class="modal fade" role="dialog"
				data-backdrop="static">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
						<h4 class="modal-title text-center">도서 등록 화면</h4>
							<button type="button" class="close" onclick="exit_btn();">&times;</button>							
						</div>
						<div class="modal-body">

							<form method="post" id="form" class="form-horizontal"
								enctype="multipart/form-data" action="/books/add">
								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="title" class="control-label">제목 : </label>
									</div>
									<div class="col-xs-5">
										<input id="title" name="title" class="form-control"
											placeholder="책 제목을 입력해주세요." />
											<span class="error error_title err_color"></span>
									</div>
								</div>

								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="comments" class="control-label">내용 : </label>
									</div>
									<div class="col-xs-5">
										<textarea id="comments" name="comments" cols="30" rows="10"
											class="form-control"></textarea>
										<span class="error error_comments err_color"></span>
									</div>
								</div>

								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="price" class="control-label">가격 : </label>
									</div>
									<div class="col-xs-5">
										<input type="text" id="price" name="price" value="0"
											class="form-control reg_price" placeholder="가격을 입력해주세요." />
										<span class="error error_price err_color"></span>
									</div>
								</div>

								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="status" class="control-label">책 상태 : </label>
									</div>
									<div class="col-xs-5">
										<select name="status" id="status" class="form-control">
											<option value="a">최상</option>
											<option value="b">상</option>
											<option value="c">중상</option>
											<option value="d">중</option>
											<option value="e">중하</option>
											<option value="f">하</option>
										</select><span class="error error_status err_color"></span>
									</div>
								</div>

								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="d_type" class="control-label">거래유형 : </label>
									</div>
									<div class="col-xs-5">
										<select name="d_type" id="d_type" class="form-control"
											onchange="reg_deal();">
											<option value="start">택배(선불)</option>
											<option value="end">택배(착불)</option>											
											<option value="direct">직거래</option>
										</select><span class="error error_d_type err_color"></span>
									</div>
								</div>

								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="fee" class="control-label">배송비 : </label>
									</div>
									<div class="col-xs-5">
										<input type="text" id="fee" name="fee" class="form-control reg_fee"
											placeholder="배송비를 입력해주세요."/>
										<span class="error error_fee err_color"></span>
									</div>
								</div>

								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="author" class="control-label">저자 : </label>
									</div>
									<div class="col-xs-5">
										<input id="author" name="author" class="form-control"
											placeholder="저자를 입력해주세요." /> <span
											class="error error_author err_color"></span>
									</div>
								</div>

								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="b_category" class="control-label">대분류 : </label>
									</div>
									<div class="col-xs-5">
										<select name="b_category" id="b_category"
											class="form-control reg_b_category"
											onchange="regSCategory();">
											<option value="">::선택::</option>
											<c:forEach var="big" items="${bigCategory }">
												<option value="${big.b_name }">${big.b_name }</option>
											</c:forEach>
										</select> <span class="error error_b_category err_color"></span>
									</div>
								</div>

								<div class="form-group">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="s_category" class="control-label">소분류 : </label>
									</div>
									<div class="col-xs-5">
										<select name="s_category" id="s_category"
											class="form-control reg_s_category">
										</select> <span class="error error_s_category err_color"></span>
									</div>
								</div>

								<div class="form-group">
								<div class="custom-file">
									<div class="col-xs-2 col-xs-offset-3">
										<label for="photo_file" class="custom-file-label">사진 : </label>
									</div>
									<div class="col-xs-5">
										<input type="file" id="photo_file" name="photo_file"
											class="custom-file-input" onchange="fileCheck(this);"
											accept="image/gif, image/GIF, image/png, image/PNG, image/jpeg, image/JPEG" />
											<small id="photo_file" class="form-text text-muted">사진은 마음대로</small>
									</div>
								</div>
								</div>

								<div class="modal-footer">
									<button id="modalBtn" type="button" class="btn btn-success"
										onclick="reg();">등록</button>
									<button type="button" class="btn btn-default"
										onclick="exit_btn();">취소</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
	<input type="hidden" id="getIdx" />
		<%-- <div class="row">
			<div class="col-sm-9">
			
			</div>
		</div>
		<div class="col-sm-3">
			<jsp:include page="../include/right.jsp" />
		</div>	 --%>
<jsp:include page="../include/footer.jsp" />
	<!--스크립트 라이브러리 -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>


<script>
var page = 0;
var commentsPage = "";
	$(function(){		
		page = 1;
		$("#replyBtn").on("click", function(){
				$("#addForm").css("display","block");
				$("#listDiv").css("display","block");
				var idx = $("#getIdx").val();
				console.log("idx : "+idx);
				commentsPage = "/comments/list/"+idx+"/"+page;
				console.log("commentsPage : "+commentsPage);
				reply(commentsPage);
		});
	});
	
	//각 태그 클릭했을 때 같은 대분류만 보이도록
	function tag(t){
		var tag_name = t.name;
		
		location.href =	"?tag="+tag_name;
	}	
	
	function adminDelete(idx){
		$.ajax({
			url:"/books/adminDelete",
			type:"post",
			data:{idx:idx},
			success:function(data){
				if(data == 'y'){
					alert("악당 퇴치");
				}
			}
		});
	}
	
	function commentsMod(rno){
		var comments = $("#mod_area"+rno).val(); //textarea의 내용
		var btn = $("#mod_"+rno+"").html();//댓글번호의 버튼이름 가져오기
		
		console.log("btn : "+btn);
		console.log("rno : " +rno);
		if(btn=='변경'){
			alert("변경 눌림");
			$("#mod_area"+rno).removeAttr("disabled");
			$("#mod_"+rno+"").html('수정');
			console.log("btn : "+btn);
			console.log("rno : " +rno);
			return;
		}else{
			
		$.ajax({
			url:"/comments/mod/"+rno,
			type:"patch",
			headers:{
				"Content-Type":"application/json",
				"X-HTTP-Method-Override":"PATCH"
			},
			dataType:"text",
			data:JSON.stringify({
				comments:comments
			}),
			success:function(result){
				if(result == 'SUCCESS'){
					alert("수정 완료");
					$("#mod_"+rno+"").html('변경');
					$("#mod_area"+rno).attr("disabled","disabled");
				}
			}				
		});
		}
	}
	
	function commentsDel(rno){
		alert("삭제 눌림");
		console.log("rno : "+rno);
		$.ajax({
			url:"/comments/del/"+rno,
			type:"delete",
			headers:{
				"Content-Type":"application/json",
				"X-HTTP-Method-Override":"DELETE"
			},
			dataType:"text",
			success:function(result){
				if(result=='SUCCESS'){
					alert("삭제완료");
					$("#replies").empty();
					reply(commentsPage);
				}
			}
		});
	}
		
	$("#commentsPaging").on("click", "li a", function(event){
		event.preventDefault();
		commentsPage = $(this).attr("href");
		reply(commentsPage);
	});
	
	function reply(commentsPage) {
		var sessionUser = "${sessionScope.user.nickname}";
		var out = "";
		var regdate = "";
		console.log("sessionUser : "+sessionUser);
			$.getJSON(commentsPage, function(data){
				console.log(data.commentsList.length);
				var nickname = "";
				var regdate = "";
				var changeBtn = "";
				var deleteBtn = "";
				var comments = "";
				if(data.commentsList.length == 0){			
					$("#commentsTitle").html("작성된 댓글이 없습니다~~");
				}else{					
					$(data.commentsList).each(function(){
						nickname = "작성자 : "+this.nickname;
						regdate = "작성일 : "+this.regdate;
						comments = "<textarea class='form-control' rows='3' disabled='disabled' id='mod_area"+this.rno+"'>"
						+ this.comments +"</textarea>";
						
						if(sessionUser != '' && sessionUser == this.nickname){
							changeBtn = "<button id='mod_"+this.rno+"' type='button' class='btn btn-secondary btn-sm' onclick='commentsMod("+this.rno+");'"
							+"style='position: absolute; left: 380px;'>"
							+ "변경"+ "</button>";
							
							deleteBtn = "<button id='del_"+this.rno+"' type='button' class='btn btn-danger btn-sm' onclick='commentsDel("+this.rno+");'"
							+"style='position: absolute; right: 20px;'>"
							+ "삭제"+ "</button>";
						}else{ //sessionUser == '' || sessionUser != this.nickname
							changeBtn = "";
							deleteBtn = "";
						}
						
						out += "<li class='list-group-item list-group-item-action'>"
						+ nickname
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ regdate+"</br>"
						+ changeBtn
						+"&nbsp;"
						+ deleteBtn						
						+"</br>"+"내용 : "
						+ comments
						+"<input type='hidden' id='getRno' value='"+this.rno+"'/>"
						+"</li>";					
					});					
					$("#replies").html(out);
					$("#commentsPaging").html(data.paging);
				}
			});		
		} 
	
	//로그인을 안하게 되면 도서등록이 안되도록
	function login(){
		var answer = confirm("로그인 후 이용가능합니다.\n로그인 페이지로 이동하시겠습니까?");
		console.log(answer);
		if(answer){
			location.href='/main';
		}
	}
	
	//도서 등록시 소분류를 불러오는 함수
	function regSCategory(){
		var b_name = $(".reg_b_category").val(); //select태그 안에 있는 선택되어진 option태그
		$.ajax({
			url:"/categorys/scate",
			type:"post",
			data:{b_name:b_name},
			success:function(smallCategoryList){
				$(".reg_s_category").empty();
				$(".reg_s_category").append("<option val=''>::선택::</option>");
				for(var scate of smallCategoryList){
					var $option = $("<option>").val(scate.s_name).text(scate.s_name);				
					$(".reg_s_category").append($option);
				}
			}			
		});
	}
	//수정화면에서 소분류를 불러오는 함수
	function getSCategory(){
		var b_name = $(".view_b_category").val();
		
		$.ajax({
			url:"/categorys/scate",
			type:"post",
			data:{b_name:b_name},
			success:function(smallCategoryList){
				$(".view_s_category").empty();
				$(".view_s_category").append("<option val=''>::선택::</option>");
				for(var scate of smallCategoryList){
					var $option = $("<option>").val(scate.s_name).text(scate.s_name);				
					$(".view_s_category").append($option);
				}
			}			
		});
	}
	
	//구매버튼 클릭 시 구매화면으로 이동
	function buy(){
		var getIdx = $("#getIdx").val();		
		console.log("getIdx : "+getIdx);
		location.href="/cart/add/"+getIdx;
		alert("구매 버튼이 눌렸습니다.");
	}
	
	//나가기나 닫기 버튼 눌렀을 시 닫은다음 페이지 리로드
	function exit_btn(){
		$("#detailModal").modal("hide");
		location.reload();
	}
	
		//도서등록시 거래유형 바뀔 때
		 function reg_deal(){
			 var $d_type = $("#d_type").val();
			 
			 if($d_type=='start'){
				 $("#fee").val('');
				 $("#fee").removeAttr("disabled","disabled");
			 }else{
				 $("#fee").val(0);
				 $("#fee").attr("disabled","disabled");
			 }
		 }
		
		//내용 수정시 거래유형 바뀔 때
		 function mod_dealtype(){
			 var $mod_d_type = $("#mod_d_type").val();
			 
			 if($mod_d_type=='start'){
				 $("#mod_fee").val('');
				 $("#mod_fee").removeAttr("disabled","disabled");
			 }else{
				 $("#mod_fee").val(0);
				 $("#mod_fee").attr("disabled","disabled");
			 }
		 }
		
			  //var reg_price = parseInt($(".reg_price").val());
			  //var reg_fee = parseInt($(".reg_fee").val());
			  
		  //도서등록
		   function reg(){
			 var formData = new FormData($("#form")[0]);
			 if(formData.get("d_type") == 'start' && (formData.get("fee") == '' || formData.get("fee")==0)){
				 alert("배송비를 입력해주세요.");
				 return;
			 }
			 $.ajax({
				 url:"/books/add",
				 enctype:"multipart/form-data",
				 type:"post",
				 contentType: false,
				 processData: false,
				 data:formData
				 }).done(function(data){
					//서버 통신 성공					
					if(data.error == null){
						location.reload();
					}else{
						if(data.error.title != undefined){
							$(".error_title").html(data.error.title);	
						}else{
							$(".error_title").html("");
						}
						if(data.error.author != undefined){
							$(".error_author").html(data.error.author);	
						}else{
							$(".error_author").html("");
						}
						if(data.error.comments != undefined){
							$(".error_comments").html(data.error.comments);	
						}else{
							$(".error_comments").html("");
						}
						if(data.error.status != undefined){
							$(".error_status").html(data.error.status);	
						}else{
							$(".error_status").html("");
						}
						if(data.error.d_type != undefined){
							$(".error_d_type").html(data.error.d_type);	
						}else{
							$(".error_d_type").html("");
						}
						if(data.error.b_category != undefined){
							$(".error_b_category").html(data.error.b_category);	
						}else{
							$(".error_b_category").html("");
						}
						if(data.error.s_category != undefined){
							$(".error_s_category").html(data.error.s_category);	
						}else{
							$(".error_s_category").html("");
						}
						if(data.error.deal != undefined){
							$(".error_deal").html(data.error.deal);	
						}else{
							$(".error_deal").html("");
						}
						if(data.error.price != undefined){
							$(".error_price").html(data.error.price);
						}else{
							$(".error_price").html("");
						}
						if(data.error.fee != undefined){
							$(".error_fee").html(data.error.fee);
						}else{
							$(".error_fee").html("");
						}
				 		return;
					}
				 });
		 }
		 //내용 수정
		  function mod(form){
			if(form.d_type.value == 'start' && (form.fee.value == 0 || form.fee.value == '')){
				alert("배송비를 입력해주세요.");
				return;
			}
			if(form.price.value == ''){
				alert("가격을 입력해주세요.");
				return;
			}
			var deal = $(".res_deal").html();
			 $.ajax({
				 url:"/books/mod",
				 type:"post",
				 data:{
					 comments:form.comments.value,
					 status:form.status.value,
					 d_type:form.d_type.value,
					 author:form.author.value,
					 b_category:form.b_category.value,
					 s_category:form.s_category.value,
					 price:form.price.value,
					 deal:deal,
					 fee:form.fee.value
				 },
				 success:function(data){
					 if(data.error == null){
					 	location.href='/books/list';
					 }else{
						 if(data.error.title != undefined){
								$(".error_title").html(data.error.title);	
							}else{
								$(".error_title").html("");
							}
							if(data.error.author != undefined){
								$(".error_author").html(data.error.author);	
							}else{
								$(".error_author").html("");
							}
							if(data.error.comments != undefined){
								$(".error_comments").html(data.error.comments);	
							}else{
								$(".error_comments").html("");
							}
							if(data.error.status != undefined){
								$(".error_status").html(data.error.status);	
							}else{
								$(".error_status").html("");
							}
							if(data.error.d_type != undefined){
								$(".error_d_type").html(data.error.d_type);	
							}else{
								$(".error_d_type").html("");
							}
							if(data.error.b_category != undefined){
								$(".error_b_category").html(data.error.b_category);	
							}else{
								$(".error_b_category").html("");
							}
							if(data.error.s_category != undefined){
								$(".error_s_category").html(data.error.s_category);	
							}else{
								$(".error_s_category").html("");
							}
							if(data.error.deal != undefined){
								$(".error.deal").html(data.error.deal);	
							}else{
								$(".error_deal").html("");
							}
							if(data.error.price != undefined){
								$(".error_price").html(data.error.price);
							}else{
								$(".error_price").html("");
							}
							if(data.error.fee != undefined){
								$(".error_fee").html(data.error.fee);
							}else{
								$(".error_fee").html("");
							}
						 return;
					 }
				 }				 
			 });	 
		 } 
		 //제이쿼리에서 등록일을 포맷변경하는 함수
		  function getFormatDate(date){
				var year = date.getFullYear()+"";
				var sub_year = year.substring(2,4);				
				var month = (1 + date.getMonth());//M
				month = month >= 10 ? month : '0' + month;// month 두자리로 저장
				var day = date.getDate();  //d
				day = day >= 10 ? day : '0' + day; //day 두자리로 저장
				return  sub_year + '년' + month + '월' + day+ '일';
			}
		 
		   //자세히 보기
		   function detail(idx){
			   $.ajax({
					type:"post",
					url : "/books/view",
					data : {idx:idx},
					success:function(data){
						console.log("자세히보기 idx : "+data.book.idx);
						$("#getIdx").val(data.book.idx);
						var nick = "${user.nickname}";		
						var regdate = new Date(data.book.regdate);						
						regdate=getFormatDate(regdate);
						if(data.book == null){
							alert("서버에 문제가 발생했습니다.\n 잠시후에 시도해주세요.");
							return;
						}else{
							$("#commentsCount").html(data.book.commentsSize);
							if(nick == data.book.nickname){
								$("#buy_btn").remove();
								$("#mod_price").val(data.book.price);
								
								$("#mod_fee").val(data.book.fee);
								if(data.book.d_type != 'start'){
									$("#mod_fee").attr("disabled","disabled");
								}
								$("#mod_author").val(data.book.author);
								$("#mod_b_category").val(data.book.b_category);
								$("#mod_s_category").empty();
								var $option = $("<option>").val(data.book.s_category).html(data.book.s_category);				
								$("#mod_s_category").append($option);
								
								switch(data.book.deal){
									case "sale": $(".res_deal").html('판매 중'); break;
									case "deal": $(".res_deal").html('거래 중'); break;
									case "complete": $(".res_deal").html('거래 완료'); break;
								}
								
								$("#mod_comments").html(data.book.comments);
								if(data.book.photo == null){
									$("#mod_photo").attr("src","/image/photo/noimage.png");
								}else{
									$("#mod_photo").attr("src","/image/photo/"+data.book.photo);
								}
								$("#mod_regdate").html(regdate);
								
								$("#mod_title").html(data.book.title); //아직은 수정안되게		
								$("#mod_nickname").html(data.book.nickname); //수정안되게
								$("#mod_d_type").val(data.book.d_type);
								
								$(".res_price").remove();
								$(".res_status").remove();
								$(".res_d_type").remove();
								$(".res_fee").remove();
								$(".res_author").remove();
								$(".res_b_category").remove();
								$(".res_s_category").remove();
								$(".res_comments").remove();
								
								
							}else{
								$("#mod_btn").remove();
								$("#mod_price").remove();
								$("#mod_status").remove();
								$("#mod_d_type").remove();
								$("#mod_fee").remove();
								$("#mod_author").remove();
								$("#mod_b_category").remove();
								$("#mod_s_category").remove();
								$("#mod_deal").remove();
								$("#mod_comments").remove();
								
								$(".res_title").html(data.book.title); //아직은 수정안되게		
								$(".res_nickname").html(data.book.nickname); //수정안되게
								$(".res_comments").html(data.book.comments);							
								$(".res_regdate").html(regdate);
								$(".res_price").html(data.book.price+"원");
								
								if(data.book.author != null){
									$(".res_author").html(data.book.author);
								}else{
									$(".res_author").html("　");
								}
								$(".res_b_category").html(data.book.b_category);
								$(".res_s_category").html(data.book.s_category);
								switch(data.book.deal){
									case "sale": $(".res_deal").html('판매 중'); break;
									case "deal": $(".res_deal").html('거래 중'); break;
									case "complete": $(".res_deal").html('거래 완료'); break;
								}
								
								$(".res_fee").html(data.book.fee+"원");								
								if(data.book.photo == null){
									$(".res_photo").attr("src","/image/photo/noimage.png");
								}else{
									$(".res_photo").attr("src","/image/photo/"+data.book.photo);
								}
								switch(data.book.status){
									case 'a': 
										$(".res_status").html("최상"); break;
									case 'b': 
										$(".res_status").html("상"); break;
									case 'c':
										$(".res_status").html("중상"); break;
									case 'd':
										$(".res_status").html("중"); break;
									case 'e': 
										$(".res_status").html("중하"); break;
									case 'f': 
										$(".res_status").html("하"); break;
									default:
										$(".res_status").html("　");
								}
								switch(data.book.d_type){
									case 'direct': 
										$(".res_d_type").html("직거래"); break;
									case 'start': 
										$(".res_d_type").html("택배(선불)"); break;
									case 'end': 
										$(".res_d_type").html("택배(착불)");break;
									default:
										$(".res_d_type").html("　");
								}							
								
							}
							$("#detailModal").modal("show");
							}							
					}					
					//서버 통신시 오류가 있을 때
				});
		   }
		   //사진 등록시 파일 확장자 검사
		  function fileCheck(file){
				var point = file.value.lastIndexOf("."); //뒤에있는 .의 위치
				var extension = file.value.substring(point+1, file.value.length); //.다음부터 끝까지의 확장자
				
				if(extension != "jpg" && extension != "JPG"
					&& extension != "png" && extension != "PNG"
					&& extension != "gif" && extension != "GIF"
					&& extension != "jpeg" && extension != "JPEG"){
					alert("이미지 이외의 파일은 업로드 할 수 없습니다.");
					
					var parent = file.parentNode;			
					var next = file.nextSibling;
					var tmp = document.createElement("form");
					//tmp에 appendChild하고 reset한 다음 parent에 insertBefore
					tmp.appendChild(file);
					tmp.reset();
					parent.insertBefore(file, next);
					
					return;
				}
			}
</script>