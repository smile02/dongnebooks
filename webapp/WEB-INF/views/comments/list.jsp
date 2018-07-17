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
<title>댓글</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.1.1/minty/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4eGtnTOp6je5m6l1Zcp2WUGR9Y7kJZuAiD3Pk2GAW3uNRgHQSIqcrcAxBipzlbWP"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css" />
<style>
.thumbnail {
	height: 450px;
}

.img-container {
	height: 220px;
	margin-top: 15px;
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
}

.err_color {
	color: red;
}

.left-btn {
	margin-left: 10px;
}

.regBtn {
	margin-right: 10px;
}

.sold_out {
	opacity: 0.6;
	filter: alpha(opacity = 40)
}

.paging {
	display: inline-block;
}

.pagination {
	margin-top: 15px;
}
</style>
</head>
<body>
	<%-- <jsp:include page="../include/header.jsp" />
	 --%>
	<div class="container">
		<form>
			<input type="hidden" id="idx" value="${cookie.idx.value }" />
				<fieldset>
					<legend>댓글작성</legend>
					<div class="form-group row">					
						<label for="nickname" class="col-form-label col-sm-2">작성자: </label>						
						<div class="col-sm-3">
							<input type="text" readonly="readonly"
								class="form-control-plaintext" id="nickname"
								value="${sessionScope.user.nickname}">
						</div>
					</div>
					<div class="form-group">
						<label for="exampleInputComments">댓글</label> 
						<input type="text"
							class="form-control" id="comments"
							aria-describedby="commentsHelp" placeholder="댓글 작성 칸입니다."> 
						<small id="commentsHelp" class="form-text text-muted">댓글을 작성해 주세요!</small>
					</div>
					
					<button id="reg_Btn" type="button" class="btn btn-primary">댓글 등록</button>
				</fieldset>
			</form>
	</div>
	<!-- 

	<table class="table table-hover text-center">																					
											<thead>
												<tr>
										<th scope="col"
										class="col-xs-3"><small class="text-muted">작성자</small></th>
										<th scope="col"
										class="col-xs-6"><small class="text-muted">내용</small></th>													
										<th scope="col"
										class="col-xs-3"><small class="text-muted">기타</small></th>
												</tr>
											</thead>
											<tbody id="replies" >
											
											</tbody>
										</table>
 -->
	<%-- <jsp:include page="../include/footer.jsp" /> --%>

	<!--스크립트 라이브러리 -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<script>
		
		$("#reg_Btn").on("click", function(){
			
			var out = "";
			var nickname = $("#nickname").val();
			var comments = $("#comments").val();
			console.log("등록 : "+nickname);
			console.log("등록 : "+comments);
			console.log("등록 : "+idx);
			$.ajax({
				url:"/comments/add",
				type:"post",
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"POST"
				},
				dataType:"text",
				data:JSON.stringify({
					nickname:nickname,
					comments:comments
				}),
				success:function(result){
					if(result != ''){
						console.log("result : "+result);
						alert("등록 완료");						
						$.getJSON("/comments/list/"+result, function(data){				
							$(data.commentsList).each(function(){
								out += "<li class='list-group-item'>"+"작성자 : "+this.nickname
								+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"작성일 : "+this.regdate+"&nbsp;&nbsp;"
								+ "<button id='mod_commentsBtn' type='button' class='btn btn-secondary btn-sm' onclick='commentsMod();'>"
								+ "변경"+ "</button>"+"&nbsp;"
								+ "<button type='button' class='btn btn-danger btn-sm' onclick='commentsDel();'>"
								+ "삭제"+ "</button>"+"</br>"+"내용 : "
								+"<textarea class='form-control' rows='3' readonly='readonly' id='mod_area'>"
								+ this.comments +"</textarea>"
								+"<input type='hidden' id='getRno' value='"+this.rno+"'/>"
								+"</li>";
							});
							$("#replies").empty();
							$("#replies").append(out);
						});		
					}
				}
			});
			
		});		
		
	</script>

</body>
</html>