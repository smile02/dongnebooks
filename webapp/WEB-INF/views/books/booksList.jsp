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
	height: 400px;
}

.img-container {
	height: 200px;
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
							<img src="/image/photo/noimage.png" />
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
				
				<form:form 
				class="form-horizontal" modelAttribute="books">
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="title" class="control-label">제목 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="title" 
								class="form-control" placeholder="책 제목을 입력해주세요."/>							
						    <form:errors path="title" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="comments" class="control-label">내용 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="comments" 
								class="form-control" placeholder="내용을 입력해주세요."/>
							<form:errors path="comments" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="price" class="control-label">가격 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="price" 
								class="form-control" placeholder="가격을 입력해주세요."/>
							<form:errors path="price" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="status" class="control-label">책 상태 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="status" 
								class="form-control" placeholder="책 상태를 입력해주세요."/>
							<form:errors path="status" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="d_type" class="control-label">거래유형 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="d_type" 
								class="form-control" placeholder="거래유형을 입력해주세요."/>
							<form:errors path="d_type" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="fee" class="control-label">배송비 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="fee" 
								class="form-control" placeholder="배송비를 입력해주세요."/>
							<form:errors path="fee" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="author" class="control-label">저자 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="author" 
								class="form-control" placeholder="저자를 입력해주세요."/>
							<form:errors path="author" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="b_category" class="control-label">대분류 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="b_category" 
								class="form-control" placeholder="대분류를 입력해주세요."
								value="IT"/>
							<form:errors path="b_category" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="s_category" class="control-label">소분류 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="text" path="s_category" 
								class="form-control" placeholder="소분류를 입력해주세요."
								value="programming"/>
							<form:errors path="s_category" class="error"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="photo_file" class="control-label">사진 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="file" path="photo_file" 
								class="form-control"/>							
						</div>			
					</div>
					
						<div class="modal-footer">
							<button type="button" class="btn btn-success" data-dismiss="modal"
								onclick="reg(this.form);">등록</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
						</div>					
					</form:form>					
				</div>				
			</div>

		</div>
	</div>

	<!--스크립트 라이브러리 -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>	
		 function reg(form){
			var data = {
					title:$("#title").val(),
					comments:$("#comments").val(),
					price:$("#price").val(),
					status:$("#status").val(),
					d_type:$("#d_type").val(),
					fee:$("#fee").val(),
					author:$("#author").val(),
					b_category:$("#b_category").val(),
					s_category:$("#s_category").val(),
					photo_file:$("#photo_file").val()
			};
			
			console.log(data);
			
			form.method="post";
			form.action="/books/add";
			form.submit();			
			 /*  $.ajax({
				url:"/books/add",
				type:"post",
				data:{
					 title:$("#title").val(),
					 comments:$("#comments").val(),
				     price:$("#price").val(),
					 status:$("#status").val(),
					 d_type:$("#d_type").val(),
					 fee:$("#fee").val(),
					 author:$("#author").val(),
					 b_category:$("#b_category").val(),
					 s_category:$("#s_category").val(),
					 photo_file:$("#photo_file").val()}
			  		,
					 success:function(data){
					if(data=='오류발생'){
						$("#myModal").modal();
					}else if(data=='등록완료'){
						location.reload();
					}else{
						alert("서버에 문제가 발생했습니다.\n잠시후에 시도해주세요.");
					}
				}
			}); */
		}
	</script>
</body>
</html>