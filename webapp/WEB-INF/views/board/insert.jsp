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
<title>게시글등록</title>
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
								jumbotron-style component for calling extra attention to
								featured content or information.</p>
							<hr class="my-4">
							<p>It uses utility classes for typography and spacing to
								space content out within the larger container.</p>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="form-contorl">
			<div class="row form-control" style="margin: 0 auto;">
				<form:form action="${pageContext.request.contextPath}/board/insert"
					method="post" modelAttribute="board">
					<input type="hidden" name="nickname"
						value="${sessionScope.user.nickname }" />
					<fieldset>
						<div class="row form-control" style="margin: 0 auto;">
							<input type="hidden" name="idx" value="${board.idx }" />
							<div class="col-sm-12">
								<h3 class="text-center">글 쓰 기</h3>
								<br /> 
								<br />
								<div class="form-group row">
									<div class="col-sm-4">
										<label for="code" class="text-center">분 류</label>
										<form:errors path="code" class="error" />
										<form:select path="code" class="custom-select" 
										style="width:100%;text-align:center;">
											<option value="0">【유형선택】</option>
											<!-- 관리자만 공지 선택할 수 있게 -->
											<c:if test="${sessionScope.user.nickname == '관리자' }">
											<option value="1">공지</option>
											</c:if>
											<option value="2">일반</option>
											<option value="3">질문</option>
											<option value="4">신고</option>
										</form:select>
									</div>
									<div class="col-sm-7">
										<label for="title" class="text-center">제 목</label>
										<form:errors path="title" class="error"/>
										<form:input type="text" class="form-control" path="title"
											placeholder="글의 제목을 입력해주세요."/>
										
									</div>
									<br />
								</div>
								<div class="form-group row col-sm-12 ">
									<label for="comments" class="col-sm-3">내용</label>
									<div class="col-sm-12">
									<form:errors path="comments" class="error"/>
										<pre>
											<form:textarea class="form-control col-sm-12" path="comments"
												wrap="hard" cols="7" rows="10" maxlength="500"
												placeholder="여기에 글의 내용을 작성해주세요."/>
										</pre>
									</div>
								</div>
							</div>
							<div class="col-sm-12 text-center">
								<button type="submit" class="btn btn-primary btn-sm">글쓰기</button>
								<button type="reset" class="btn btn-primary btn-sm">재입력</button>
								<button type="button" class="btn btn-primary btn-sm"
									onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>
							</div>
						</div>
					</fieldset>
				</form:form>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
	<!-- script library -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<script>
		
	</script>
</body>
</html>