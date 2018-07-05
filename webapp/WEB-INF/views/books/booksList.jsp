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

.photo-hei{
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

								<button id="detail" type="button"
								class="btn btn-primary btn-xs" onclick="detail(${books.idx});">자세히 보기</button>
							</span>
						</div>						
					</div>
				</div>
			</c:forEach>
		</div>
		
	<div class="modal" id="detailModal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content detail-modal">					
			<div class="modal-header text-center" id="title">
				<label class="control-label res_title">제목 : </label>
				<button type="button" class="close btn-md" onclick="exit_btn()">&times;</button>
			</div>
			<div class="modal-body">
			<form id="mod_form" class="form-horizontal">
				<div class="form-group photo">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">사진 : </label>
						</div>
						<div class="col-xs-5">
							<img class="form-control photo photo-hei res_photo" />
						</div>			
				</div>
				
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">작성자 : </label>
						</div>
						<div class="col-xs-5">						
							<p class="form-control res_nickname"></p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">등록시간 : </label>
						</div>
						<div class="col-xs-5">
							<p id="regdate" class="form-control res_regdate"></p>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">가격 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${cookie.nickname.value != '관리자' }">
							<p id="price" class="form-control res_price"></p>
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<input id="mod_price" name="price" type="number" class="form-control" />
						</c:if>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">책 상태 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${cookie.nickname.value != '관리자' }">
							<p id="status" class="form-control res_status"></p>
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<select name="status" id="mod_status" class="form-control">
								<option value="a">최상</option>
								<option value="b">상</option>
								<option value="c">중상</option>
								<option value="d">중</option>
								<option value="e">중하</option>
								<option value="f">하</option>
							</select>
						</c:if>
						</div>			
				</div>				
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">거래유형 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${cookie.nickname.value != '관리자' }">
							<p id="d_type" class="form-control res_d_type">
							</p>
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<select id="mod_d_type" name="d_type" class="form-control">
								<option value="end">택배(착불)</option>
								<option value="start">택배(선불)</option>
								<option value="direct">직거래</option>
							</select>
						</c:if>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">배송비 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${cookie.nickname.value != '관리자' }">
							<p id="fee" class="form-control res_fee"></p>
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<input id="mod_fee" type="number" name="fee" class="form-control"/>
						</c:if>
						</div>			
				</div>				
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">저자 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${cookie.nickname.value != '관리자' }">
							<p id="author" class="form-control res_author"></p>
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<input id="mod_author" type="text" name="author" class="form-control"/>
							<span id="mod_aut" class="error"></span>
						</c:if>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">대분류 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${cookie.nickname.value != '관리자' }">
							<p id="b_category" class="form-control res_b_category"></p>
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<input id="mod_b_category" type="text" class="form-control" name="b_category"/>
						</c:if>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">소분류 : </label>
						</div>
						<div class="col-xs-5">
							<c:if test="${cookie.nickname.value != '관리자' }">
							<p id="s_category" class="form-control res_s_category"></p>
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<input id="mod_s_category" type="text" class="form-control" name="s_category"/>
						</c:if>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">거래상태 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${cookie.nickname.value != '관리자' }">
							<p id="deal" class="form-control res_deal"></p>
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<input id="mod_deal" type="text" name="deal" class="form-control" />
						</c:if>
						</div>			
				</div>
				<div class="form-group">
						<div class="col-xs-2 col-xs-offset-3">
							<label class="control-label">내용 : </label>
						</div>
						<div class="col-xs-5">
						<c:if test="${cookie.nickname.value != '관리자' }">					
							<div class="form-control res_comments" id="comments"
								style="overflow:scroll; width:220px; height:100px; padding:10px;"
								></div>			
						</c:if>
						<c:if test="${cookie.nickname.value == '관리자' }">
							<textarea id="mod_comments" class="form-control res_comments" name="comments" cols="30" rows="10" >${bk.comments }</textarea>
						</c:if>				
						</div>			
				</div>
			</form>
			</div>
			<div class="modal-footer">			
				<c:if test="${cookie.nickname.value == '관리자' }">
					<button type="button" class="btn btn-warning" onclick="mod(${cookie.idx.value})">수정하기</button>
				</c:if>
				<c:if test="${cookie.nickname.value != '관리자' }">
					<button type="button" class="btn btn-warning" id="mod" onclick="buy();" >구매하기</button>
				</c:if>				
				<button type="button" class="btn" onclick="exit_btn()">나가기</button>
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
							<form:input type="number" path="price" 
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
							<form:input type="number" path="fee" 
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
	
	function exit_btn(){
		$("#detailModal").modal("hide");
		location.reload();
				
		
				
		//$("#detailModal").css("display") == "none";
		//$("#detailModal").modal("hide");
		//$("#close_btn").attr("data-dismiss","modal");		
	}
	
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
						$("aut").html(data.error);
					}
				 });
		 } 
		  
		 //도서 수정
		 function mod(idx){
			 idx = Number(idx);
			 $.ajax({
				 url:"/books/mod",
				 type:"post",
				 data:{
					 idx:idx,
					 price:$("#mod_price").val(),
					 status:$("#mod_status").val(),
					 d_type:$("#mod_d_type").val(),
					 fee:$("#mod_fee").val(),
					 author:$("#mod_author").val(),
					 b_category:$("#mod_b_category").val(),
					 s_category:$("#mod_s_category").val(),
					 deal:$("#mod_deal").val(),
					 comments:$("#mod_comments").val()
				 },
				 success:function(data){
					 if(data.success == 'y'){
						alert("수정이 완료되었습니다.");
						location.reload();
					 }
				 }					
		 })
		 }
		   
		   //자세히 보기
		   function detail(idx){
			   $.ajax({
					type:"post",
					url : "/books/view",
					data : {idx:idx},
					success:function(data){	
						if(data.book == null){
							alert("서버에 문제가 발생했습니다.\n 잠시후에 시도해주세요.");
						}else{							
							$(".res_title").html(data.book.title); //아직은 수정안되게		
							$(".res_nickname").html(data.book.nickname); //수정안되게
							$(".res_comments").html(data.book.comments);							
							$(".res_regdate").html(data.book.regdate);
							$(".res_price").html(data.book.price);
							$("#mod_price").val(data.book.price);
							
							$(".res_fee").html(data.book.fee);
							$("#mod_fee").val(data.book.fee);
							
							if(data.book.photo == null){
								$(".res_photo").attr("src","/image/photo/noimage.png");
							}else{
								$(".res_photo").attr("src","/image/photo/"+data.book.photo);
							}
							
							$(".res_author").html(data.book.author);
							$("#mod_author").val(data.book.author);
							
							$(".res_b_category").html(data.book.b_category);
							$("#mod_b_category").val(data.book.b_category);
							
							$(".res_s_category").html(data.book.s_category);
							$("#mod_s_category").val(data.book.s_category);
							
							$(".res_deal").html(data.book.deal);
							$("#mod_deal").val(data.book.deal);
							
							switch(data.book.status){
								case 'a': 
									$(".res_status").html("최상"); 
									$("#mod_status").val(data.book.status);break;
								case 'b': 
									$(".res_status").html("상");
									$("#mod_status").val(data.book.status);break;
								case 'c':
									$(".res_status").html("중상"); 
									$("#mod_status").val(data.book.status);break;
								case 'd':
									$(".res_status").html("중"); 
									$("#mod_status").val(data.book.status); break;
								case 'e': 
									$(".res_status").html("중하"); 
									$("#mod_status").val(data.book.status); break;
								case 'f': 
									$(".res_status").html("하"); 
									$("#mod_status").val(data.book.status); break;
							}
							switch(data.book.d_type){
								case 'direct': 
									$(".res_d_type").html("직거래"); 
									$("#mod_d_type").val(data.book.d_type);break;
								case 'start': 
									$(".res_d_type").html("택배(선불)"); 
									$("#mod_d_type").val(data.book.d_type);break;
								case 'end': 
									$(".res_d_type").html("택배(착불)"); 
									$("#mod_d_type").val(data.book.d_type);break;
							}							
							$("#detailModal").modal("show");
						}
					}					
					//서버 통신시 오류가 있을 때
				});
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
					}
		 
		 */
	</script>
</body>
</html>