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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style>
.thumbnail {
	height: 450px;
}

.img-container {
	height: 220px;
}

.thumbnail img {
	width: 100%;
	height: 100% !important;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<c:forEach var="books" items="${booksList }">
				<div class="col-xs-3">
					<div class="thumbnail">
						<div class="img-container">
						<c:if test="${books.photo ne null}">
							<img src="/image/photo/${books.photo }" />
						</c:if>
						<c:if test="${books.photo == null}">
							<img src="/image/photo/noimage.png" />
						</c:if>
						
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
							<p>가격 : ${books.price }</p>
							<p>책 상태 :${books.status }</p>
							<span>
								<button id="detail" type="button" class="btn btn-primary">자세히 보기</button>
							</span>
						</div>
						
					</div>
				</div>
			</c:forEach>
		</div>
		
	<button type="button" class="btn btn-info btn-md" data-toggle="modal"
		data-target="#myModal">도서 등록</button>
	</div>
	
	<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title text-center">도서 등록 화면</h4>
				</div>
				<div class="modal-body">
				
				<form enctype="multipart/form-data" action="/books/add" method="post"
				class="form-horizontal">
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="title" class="control-label">제목 : </label>
						</div>
						<div class="col-xs-5">
							<input type="text" id="title" name="title" 
								class="form-control" placeholder="책 제목을 입력해주세요."/>		
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="comments" class="control-label">내용 : </label>
						</div>
						<div class="col-xs-5">
							<input type="text" id="comments" name="comments" 
								class="form-control" placeholder="내용을 입력해주세요."/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="price" class="control-label">가격 : </label>
						</div>
						<div class="col-xs-5">
							<input type="text" id="price" name="price" 
								class="form-control" placeholder="가격을 입력해주세요."/>
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
							</select>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="d_type" class="control-label">거래유형 : </label>
						</div>
						<div class="col-xs-5">
							<select name="d_type" id="d_type" class="form-control"
								onchange="deal();">										
								<option value="end">택배(착불)</option>
								<option value="start">택배(선불)</option>
								<option value="direct">직거래</option>
							</select>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="fee" class="control-label">배송비 : </label>
						</div>
						<div class="col-xs-5">
							<input type="text" id="fee" name="fee" 
								class="form-control" placeholder="배송비를 입력해주세요."/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="author" class="control-label">저자 : </label>
						</div>
						<div class="col-xs-5">
							<input type="text" id="author" name="author" 
								class="form-control" placeholder="저자를 입력해주세요."/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="b_category" class="control-label">대분류 : </label>
						</div>
						<div class="col-xs-5">
							<input type="text" id="b_category" name="b_category" 
								class="form-control" placeholder="대분류를 입력해주세요."
								value="IT"/>							
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="s_category" class="control-label">소분류 : </label>
						</div>
						<div class="col-xs-5">
							<input type="text" id="s_category" name="s_category" 
								class="form-control" placeholder="소분류를 입력해주세요."
								value="programming"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label for="photo_file" class="control-label">사진 : </label>
						</div>
						<div class="col-xs-5">
							<input type="file" id="photo_file" name="photo_file" 
								class="form-control"/>							
						</div>			
					</div>
					
						<div class="modal-footer">
							<button type="submit" class="btn btn-success">등록</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
						</div>					
					</form>					
				</div>				
			</div>

		</div>
	</div>

	<!--스크립트 라이브러리 -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>	
		 function deal(){
			 var $d_type = $("#d_type").val();
			 
			 if($d_type=='end'){
				 $("#fee").val('');
				 $("#fee").removeAttr("readonly","readonly");
			 }else{
				 $("#fee").val(0);
				 $("#fee").attr("readonly","readonly");
			 }
		 }
	</script>
</body>
</html>