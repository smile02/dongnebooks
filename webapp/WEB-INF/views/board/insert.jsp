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
		<form:form action="${pageContext.request.contextPath}/board/insert"
			method="post">
			<input type="hidden" name="nickname" value="${sessionScope.user.nickname }" />
			<fieldset>
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
				<div class="row">
					<div class="col-sm-12">
						<h3 class="text-center">글 쓰 기</h3>
						<br /> <br />
						<div class="form-group row">
							<label for="code" class="col-sm-1">분 류</label>
							<div class="col-sm-3">
								<select name="code" id="code" class="custom-select">
									<option value="">【유형선택】</option>
									<option value="1">공지</option>
									<option value="2">일반</option>
								</select>
							</div>
							<label for="title" class="col-sm-1">제 목</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="title" name="title"
									placeholder="글의 제목을 입력해주세요." />
							</div>
							<br />
						</div>
					</div>
					<div class="form-group row col-sm-12 ">
						<label for="comments" class="col-sm-3">내용</label>
						<div class="col-sm-12">
							<textarea class="form-control col-sm-12" name="comments" style="height:230px;" 
								placeholder="여기에 글의 내용을 작성해주세요."></textarea>
						</div>
						<br />
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary btn-sm"
							onclick="check(this.form)">글쓰기</button>
						<button type="reset" class="btn btn-primary btn-sm">재입력</button>
					</div>
				</div>
			</fieldset>
		</form:form>
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
		function check(form) {
			//제목,내용 유효성 검사
			if(form.code.value==""){
				alert("게시글의유형을선택해주세요.")
				form.code.focus();
				return;
			} 
			
			if (!/^.{5,30}$/.test(form.title.value)) {
				alert("제목 5글자이상 30이하로 작성하시오.")
				form.title.focus();
				return;
			}

			if (!/^.{10,1000}$/.test(form.comments.value)) {
				alert("내용을 10글자이상 1000글자 이하로 작성하시오.")
				form.comments.focus();
				return;
			}
			
			form.submit();

		}
	</script>
</body>
</html>