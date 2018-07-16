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
			<input type="text" name="nickname" value="${sessionScope.user.nickname }" />
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
						onclick="update(this.form)">수정</button>
				</div>
			</div>
		</form>
	</div>
	<br />
	<!--  댓글  -->
	<div class="container">
		<label for="content">댓 글</label>
		<form:form action="/reply/insert" method="post" modelAttribute="board">
		<fieldset>
			<div class="input-group">
			<c:if test="${!empty sessionScope.user.nickname }">
				<input type="hidden" name="idx" value="${board.idx }" />
				<form:input type="text" class="form-control" path="comments"
					placeholder="댓글 내용을 재빠르게 입력하세요."/>
				<form:errors path="comments" class="error"/> 
				<span class="input-group-btn">
					<button class="btn btn-primary btn-sm" type="submit">등록</button>
				</span>
			</c:if>
			</div>
			</fieldset>
		</form:form>
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
						<th colspan="2" style="text-align: center">이 게시판에 댓글이 존재하지않습니다. <br /> 첫댓글을 달아보세요.</th>
					</tr>
				</c:if>
				<c:forEach var="reply" items="${board.replyList }">
					<tr>
						<td>${reply.nickname }</td>
						<td id="td_${reply.rno }">${reply.comments }</td>
						<td>${reply.regdate }
							<c:if test="${sessionScope.user.nickname == reply.nickname }">
								<button class="btn btn-primary btn-sm" type="button" onclick="reply_update(${reply.rno})">수정</button>
								<button class="btn btn-primary btn-sm" type="button" onclick="del(${reply.rno})">삭제</button>
							</c:if>
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
	//글수정 눌렀을 때 해당글의 올린작성자인지 확인하고 맞으면 수정페이지(update)로 아니면 로그인화면으로
	function update(form){
		var nickname ="${sessionScope.user.nickname}";
		console.log(nickname);
		if(nickname == '${board.nickname}'){
			location.href='update?idx=${board.idx}';
		}else{
			alert("글의 작성자만 수정가능합니다.");
			location.reload();
		}
	}
	
	//댓글삭제
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
	
	//댓글수정
	function reply_update(rno) {
		var comments_td = $("#td_"+rno);
		var $input = $("<input id='input_"+rno+"' type='text'/>");
		$input.val(comments_td.text());
		comments_td.empty();
		comments_td.append($input);
		var $button = $("<button type='button' class='btn btn-primary btn-sm' onclick='updateToServer("+rno+")'>완료</button>");
		comments_td.append($button);
		
	}
	function updateToServer(rno){
		var comments = $("#input_"+rno).val();
		//$btn_dis = $('.btn_dis').attr('disabled', true);
		if (!/^.{3,100}$/.test(comments)) {
			alert("내용을 3글자이상 100글자 이하로 작성하시오.");
			$("#input_"+rno).focus();
			return;
		}
		//console.log(comments);
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
	
	</script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>