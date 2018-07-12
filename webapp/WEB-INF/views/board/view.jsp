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
		<form action="${pageContext.request.contextPath}/board/insert" method="post">
		<input type="hidden" name="idx" value="${board.idx }" />
		<div class="row text-center">
			<table class="table">
					<tr>
						<th width="10%">분류</th>
						<td width="10%">
						<c:if test="${board.code == 1 }">
						<td>[공지]</td>
						</c:if>
						<c:if test="${board.code == 2 }">
						<td>[일반]</td>
						</c:if>
						</td>
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
			<div class="row">
				<textarea class="form-control" id="comments" name="comments"></textarea>
			</div>
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
	</div>
	</form>
	<br />
	<jsp:include page="../include/footer.jsp" />
	<!-- script library -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
		function del(idx){
			$.ajax({
				url:"/board/view.jsp",
				data:"idx="+idx,
				type:"post",
				success:function(data)
			});
		}
</script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>