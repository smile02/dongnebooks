<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>동네북스에 오신 것을 환영합니다!</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.1.1/minty/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4eGtnTOp6je5m6l1Zcp2WUGR9Y7kJZuAiD3Pk2GAW3uNRgHQSIqcrcAxBipzlbWP"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css" />
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
		<form action="${pageContext.request.contextPath}/board/insert"
			method="post">
			<input type="hidden" name="idx" value="${board.idx }" />
			<div class="row text-center">
				<table class="table">
					<tr>
						<th width="10%">분류</th>
						<td width="10%"><c:if test="${board.code == 1 }">
								<td>[공지]</td>
							</c:if> <c:if test="${board.code == 2 }">
								<td>[일반]</td>
							</c:if></td>
						<th>작성자</th>
						<td>${board.nickname }</td>
						<th>작성시간</th>
						<td>${board.regdate }</td>

						<th>조회수</th>
						<td>${board.cnt }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${board.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">${board.comments }</td>
					</tr>
				</table>
			</div>
			<br />
			<div class="row">
				<div class="buttons">
					<button type="button" class="btn btn-primary btn-sm"
						onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>
					<button type="button" class="btn btn-primary btn-sm"
						onclick="location.href='update?idx=${board.idx}'">수정</button>
				</div>
			</div>
		</form>
	</div>
	<br />
	<!--  댓글  -->
	<div class="container">
		<label for="content">댓 글</label>
		<form name="commentInsertForm">
			<div class="input-group">
				<input type="text" class="form-control" id="comments" name="comments"
					placeholder="댓글 내용을 재빠르게 입력하세요."/> <span class="input-group-btn">
					<button class="btn btn-primary btn-sm" type="button" onclick="reply(this.form)">등록</button>
				</span>
			</div>
		</form>
		<div class="container">
			<form>
			<table style="width:100%">
				<tr>
					<th width="30%">작성자</th>
					<th width="30%">댓글내용</th>
					<th width="40%">댓글시간</th>
				</tr>
				<c:if test="${empty board.replyList }">
					<tr>
						<th colspan="2" style="text-align: center">댓글이 존재하지않습니다.</th>
					</tr>
				</c:if>
				<c:forEach var="reply" items="${board.replyList }">
					<tr>
						<td>${reply.nickname }</td>
						<td id="td_${reply.rno }">${reply.comments }</td>
						<td>${reply.regdate }
							<button class="btn btn-primary btn-sm" type="button" onclick="reply_update(${reply.rno})">수정</button>
							<button class="btn btn-primary btn-sm" type="button" onclick="del(${reply.rno})">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</table>
			</form>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
	<!-- script library -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
	function del(rno){
		$.ajax({
			url:"/reply/delete/{rno}",
			type:"post",
			data:{rno:rno},
			success:function(data){
				if(data=='y'){
					alert("삭제");
					history.go(0);
				}else{
					alert("삭제실패");
					history.go(0);
				}
			}
		});
	}
	

	function reply_update(rno) {
		var comments_td = $("#td_"+rno);
		var $input = $("<input id='input_"+rno+"' type='text'/>");
		$input.val(comments_td.text());
		comments_td.empty();
		comments_td.append($input);
		var $button = $("<button id='btn_dis' type='button' class='btn btn-primary btn-sm' onclick='updateToServer("+rno+")'disabled=''"">완료</button>");
		comments_td.append($button);
		
	}
	function updateToServer(rno){
		var comments = $("#input_"+rno).val();
		$btn_dis = $('.btn_dis').attr('disabled', true);
		if (!/^.{3,100}$/.test(comments)) {
			alert("내용을 3글자이상 100글자 이하로 작성하시오.");
			$("#input_"+rno).focus();
			return;
		}
		console.log(comments);
		$.ajax({
			url:"/reply/update",
			type:"post",
			data:{rno:rno,
				comments:comments},
				success:function(data){
				if(data=='y'){
					alert("댓글수정완료");
					history.go(0);
				}else{
					alert("댓글수정실패");
				}
			}
			
		});
	}
	
	function reply(form) {
			var comments = form.comments.value;
			if (!/^.{3,100}$/.test(form.comments.value)) {
				alert("내용을 3글자이상 100글자 이하로 작성하시오.")
				form.comments.focus();
				return;
			}
			
			$.ajax({
				url : "/reply/insert",
				type : "post",
				data : {comments : comments, idx:'${board.idx}'},
				success : function(data) {
					if (data == 'y') {
						alert("댓글등록");
						history.go(0);
					} else {
						alert("댓글등록실패");
					}
					}
				});
				form.submit();
		}
	</script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>