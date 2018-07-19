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
					<legend class="text-center">댓글작성</legend>
					<div class="form-group row">					
						<label for="nickname" class="col-form-label col-sm-3">작성자: </label>						
						<div class="col-sm-4">
							<input type="text" readonly="readonly"
								class="form-control-plaintext" id="nickname"
								value="${sessionScope.user.nickname}">
						</div>
					</div>
					<div class="form-group">
						<label for="exampleInputComments">댓글</label> 
						<textarea class="form-control" name="comments" id="comments" cols="30" rows="3"
							aria-describedby="commentsHelp"></textarea> 
						<small id="commentsHelp" class="form-text text-muted">댓글을 작성해 주세요!</small>
						<span id="comments_error" class="error"></span>
					</div>					
					<button id="reg_Btn" type="button" class="btn btn-primary">댓글 등록</button>
				</fieldset>
			</form>
	</div>

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
			var sessionUser = "${sessionScope.user.nickname}";
			var out = "";
			var nickname = $("#nickname").val();
			var comments = $("#comments").val();
			console.log("등록 : "+nickname);
			console.log("등록 : "+comments);
			console.log("등록 : "+idx);
			console.log("sessionUser : "+sessionUser);
			if(sessionUser != ''){
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
						if(result != 'y'){
							$("#comments_error").html("");
							$("#comments").val("");
							alert("등록 완료");						
							$.getJSON("/comments/list/"+result+"/"+1, function(data){
								var userNickname = "";
								var regdate = "";
								var changeBtn = "";
								var deleteBtn = "";
								var userComments = "";
								$(data.commentsList).each(function(){
									userNickname = "작성자 : "+this.nickname;
									regdate = "작성일 : "+this.regdate;
									userComments = "<textarea class='form-control' rows='3' disabled='disabled' id='mod_area"+this.rno+"'>"
									+ this.comments +"</textarea>";
									
									if(sessionUser != '' && sessionUser == this.nickname){
										changeBtn = "<button id='mod_"+this.rno+"' type='button' class='btn btn-secondary btn-sm' onclick='commentsMod("+this.rno+");'"
										+"style='position: absolute; left: 380px;'>"
										+ "변경"+ "</button>";
										
										deleteBtn = "<button id='del_"+this.rno+"' type='button' class='btn btn-danger btn-sm' onclick='commentsDel("+this.rno+");'"
										+"style='position: absolute; right: 20px;'>"
										+ "삭제"+ "</button>";
									}else{
										changeBtn = "";
										deleteBtn = "";
									}
									
									out += "<li class='list-group-item list-group-item-action'>"
									+ userNickname
									+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
									+ regdate+"</br>"
									+ changeBtn
									+"&nbsp;"
									+ deleteBtn						
									+"</br>"+"내용 : "
									+ userComments
									+"<input type='hidden' id='getRno' value='"+this.rno+"'/>"
									+"</li>";							
								});
								$("#replies").html(out);
								$("#commentsPaging").html(data.paging);
							});		
						}else{
							$("#comments_error").html("댓글을 입력해주세요.");
						}
					}
				});
			}else{
				var answer = confirm("로그인 후 이용가능합니다.\n로그인 페이지로 이동하시겠습니까?");
				console.log(answer);
				if(answer){
					location.href='/main';
				}
			}
		});		
		
	</script>

</body>
</html>