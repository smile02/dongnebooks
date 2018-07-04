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

.detail-modal{
	height:auto;
}

.photo{
	height:220px;
}

#photo{
	width:100%;
	height: 200px !important;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<c:forEach var="books" items="${booksList }">
				<div class="col-md-3 col-xs-6">
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
							<p>책 상태 :
							<c:if test="${books.status == 'a'}">최상</c:if>
							<c:if test="${books.status == 'b'}">상</c:if>
							<c:if test="${books.status == 'c'}">중상</c:if>
							<c:if test="${books.status == 'd'}">중</c:if>
							<c:if test="${books.status == 'e'}">중하</c:if>
							<c:if test="${books.status == 'f'}">하</c:if>
							</p>								
							<span>
							<input type="hidden" value="${books.nickname }" id="detail_nickname" />
								<button id="detail" type="button" 
								class="btn btn-primary btn-xs" onclick="detail(${books.idx});">자세히 보기</button>
							</span>
						</div>
						
					</div>
				</div>
			</c:forEach>
		</div>
		
	<div class="modal" id="detailModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content detail-modal">
		<button type="button" class="close btn-md" data-dismiss="modal">&times;</button>			
			<div class="modal-header text-center" id="title">
				<label class="control-label">제목 : </label> ${bk.title }
			</div>
			<div class="modal-body">
			<form action="" class="form-horizontal">
				<div class="form-group photo">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">사진 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${bk.photo ne null}">
							<img src="/image/photo/${bk.photo }" id="photo" class="form-control"/>
						</c:if>
						<c:if test="${bk.photo == null}">
							<img src="/image/photo/noimage.png" />
						</c:if>
						</div>			
				</div>
				
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">작성자 : </label>
						</div>
						<div class="col-xs-5">
							<p id="nickname" class="form-control">${bk.nickname }</p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">등록시간 : </label>
						</div>
						<div class="col-xs-5">
							<p id="regdate" class="form-control">
							<f:parseDate var="date" value="${bk.regdate }"
									pattern="yyyy-MM-dddd HH:mm:ss" />
								<f:formatDate value="${date }" pattern="yy년 MM월 dd일 HH시 mm분" />
							</p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">가격 : </label>
						</div>
						<div class="col-xs-5">
							<p id="price" class="form-control">${bk.price }</p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">책 상태 : </label>
						</div>
						<div class="col-xs-5">
							<p id="status" class="form-control">
							<c:if test="${bk.status == 'a'}">최상</c:if>
							<c:if test="${bk.status == 'b'}">상</c:if>
							<c:if test="${bk.status == 'c'}">중상</c:if>
							<c:if test="${bk.status == 'd'}">중</c:if>
							<c:if test="${bk.status == 'e'}">중하</c:if>
							<c:if test="${bk.status == 'f'}">하</c:if></p>
						</div>			
				</div>				
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">거래유형 : </label>
						</div>
						<div class="col-xs-5">
							<p id="d_type" class="form-control">
								<c:if test="${bk.d_type == 'direct' }">직거래</c:if>
								<c:if test="${bk.d_type == 'start' }">택배(선불)</c:if>
								<c:if test="${bk.d_type == 'end' }">택배(착불)</c:if>
							</p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">배송비 : </label>
						</div>
						<div class="col-xs-5">
							<p id="fee" class="form-control">${bk.fee }</p>
						</div>			
				</div>				
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">저자 : </label>
						</div>
						<div class="col-xs-5">
							<p id="author" class="form-control">${bk.author }</p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">대분류 : </label>
						</div>
						<div class="col-xs-5">
							<p id="b_category" class="form-control">${bk.b_category }</p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">소분류 : </label>
						</div>
						<div class="col-xs-5">
							<p id="s_category" class="form-control">${bk.s_category }</p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">거래상태 : </label>
						</div>
						<div class="col-xs-5">
							<p id="deal" class="form-control">${bk.deal }</p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">내용 : </label>
						</div>
						<div class="col-xs-5">							
							<div class="form-control" id="comments"
								style="overflow:scroll; width:220px; height:100px; padding:10px;"
								>${bk.comments }</div>							
						</div>			
				</div>
			</form>
			</div>
			<div class="modal-footer">			
				<c:if test="${bk.nickname == '관리자' }">
					<button type="button" class="btn btn-warning" id="mod" onclick="mod(${bk.idx});" >수정하기</button>
				</c:if>
				<c:if test="${bk.nickname != '관리자' }">
					<button type="button" class="btn btn-warning" id="mod" onclick="buy();" >구매하기</button>
				</c:if>				
				<button type="button" class="btn" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
		
			<!--    -->
	<button id="modal" type="button" class="btn btn-info btn-md"
	data-toggle="modal" data-target="#booksList">도서 등록</button>	
	</div>	
	<!-- Modal   -->
	<div id="booksList" class="modal fade" role="dialog" data-backdrop="static" >
		<div class="modal-dialog modal-lg">
			<!-- Modal content-->
			<div class="modal-content">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title text-center">도서 등록 화면</h4>
				</div>
				<div class="modal-body">
				
				<form:form method="post" id="form" class="form-horizontal" modelAttribute="books">
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="title" class="control-label">제목 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input path="title" 
								class="form-control" placeholder="책 제목을 입력해주세요."/>
							<form:errors path="title" class="error"/>	
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="comments" class="control-label">내용 : </form:label>
						</div>
						<div class="col-xs-5">							
							<form:textarea path="comments" class="form-control"></form:textarea>
							<form:errors path="comments" class="error"/>	
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="price" class="control-label">가격 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input path="price" 
								class="form-control" placeholder="가격을 입력해주세요."/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="status" class="control-label">책 상태 : </form:label>
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
							<form:label path="d_type" class="control-label">거래유형 : </form:label>
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
							<form:label path="fee" class="control-label">배송비 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input path="fee" 
								class="form-control" placeholder="배송비를 입력해주세요."/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="author" class="control-label">저자 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input path="author"
								class="form-control" placeholder="저자를 입력해주세요."/>
							<span id="aut" class="error"></span>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="b_category" class="control-label">대분류 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input path="b_category"
								class="form-control" placeholder="대분류를 입력해주세요."
								value="IT"/>							
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="s_category" class="control-label">소분류 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input path="s_category"
								class="form-control" placeholder="소분류를 입력해주세요."
								value="programming"/>
						</div>			
					</div>
					
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<form:label path="photo_file" class="control-label">사진 : </form:label>
						</div>
						<div class="col-xs-5">
							<form:input type="file" path="photo_file"
								class="form-control" onchange="fileCheck(this);"
								accept="image/gif, image/GIF, image/png, image/PNG, image/jpeg, image/JPEG"/>							
						</div>			
					</div>
					
						<div class="modal-footer">
							<button id="modalBtn" type="button" class="btn btn-success"
								onclick="reg();">등록</button>
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
	//거래유형 바뀔 때
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
		 //도서등록
		   function reg(){
			   var formData = new FormData($("#form")[0]);
			 $.ajax({
				 url:"/books/add",
				 enctype:"multipart/form-data",
				 type:"post",
				 contentType: false,
				 processData: false,
				 data:formData
				 }).done(function(data){
					//서버 통신 성공					
					if(data.success == 'y'){
						location.reload();
					}else{
						console.log(data.error);
						$("#aut").html(data.error);
					}
				 });
		 } 
		   
		   
		   //자세히 보기
		   function detail(idx){
			   $.ajax({
					type:"post",
					url : "/books/view",
					data : "idx="+idx
				}).done(function(data){ 
					
				}).fail(function(err){ 
					//서버 통신시 오류가 있을 때
				});
			   $("#detailModal").modal();
		   }
		   //파일 확장자 검사
		  function fileCheck(file){
				var point = file.value.lastIndexOf("."); //뒤에있는 .의 위치
				var extension = file.value.substring(point+1, file.value.length); //.다음부터 끝까지의 확장자
				
				if(extension != "jpg" && extension != "JPG"
					&& extension != "png" && extension != "PNG"
					&& extension != "gif" && extension != "GIF"	){
					alert("이미지 이외의 파일은 업로드 할 수 없습니다.");
					
					var parent = file.parentNode;			
					var next = file.nextSibling;
					var tmp = document.createElement("form:form");
					//tmp에 appendChild하고 reset한 다음 parent에 insertBefore
					tmp.appendChild(file);
					tmp.reset();
					parent.insertBefore(file, next);
					
					return;
				}
			}
		/*   
		 $(function(){
				var err = err;
				console.log(err);
			}); */


		 /*
		 $("#title").html(data.book.title);
					$("#nickname").html(data.book.nickname);
					$("#comments").html(data.book.comments);
					$("#regdate").html(data.book.regdate);
					$("#price").html(data.book.price);
					$("#fee").html(data.book.fee);
					///image/photo/noimage.png
					if(data.book.photo == null){
						$("#photo").attr("src","/image/photo/noimage.png");
					}else{
						$("#photo").attr("src","/image/photo/"+data.book.photo);
					}
					$("#author").html(data.book.author);
					$("#b_category").html(data.book.b_category);
					$("#s_category").html(data.book.s_category);
					$("#deal").html(data.book.deal);
					//$("#status").html(data.book.status);
					switch(data.book.status){
						case 'a': $("#status").html("최상"); break;
						case 'b': $("#status").html("상"); break;
						case 'c': $("#status").html("중상"); break;
						case 'd': $("#status").html("중"); break;
						case 'e': $("#status").html("중하"); break;
						case 'f': $("#status").html("하"); break;
					}
					//$("#d_type").html(data.book.d_type);
					switch(data.book.d_type){
						case 'direct': $("#d_type").html("직거래"); break;
						case 'start': $("#d_type").html("택배(선불)"); break;
						case 'end': $("#d_type").html("택배(착불)"); break;
		 
		 */
	</script>
</body>
</html>