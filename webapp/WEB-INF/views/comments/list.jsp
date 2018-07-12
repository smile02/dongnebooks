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
		<div class="row">
			<form>
				<fieldset>
					<legend>Legend</legend>
					<div class="form-group row">
						<label for="nickname" class="col-sm-2 col-form-label">작성자
							: </label>
						<div class="col-sm-10">
							<input type="text" readonly="readonly"
								class="form-control-plaintext" id="nickname"
								value="${sessionScope.user.nickname}">
						</div>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">댓글</label> <input type="email"
							class="form-control" id="exampleInputEmail1"
							aria-describedby="emailHelp" placeholder="댓글 작성 칸입니다."> <small
							id="emailHelp" class="form-text text-muted">댓글을 작성해 주세요!</small>
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">Password</label> <input
							type="password" class="form-control" id="exampleInputPassword1"
							placeholder="Password">
					</div>
					<button type="submit" class="btn btn-primary">Submit</button>
				</fieldset>
			</form>

		</div>

		<div class="row">
			z
			<c:forEach var="comments" items="${commentsList }">
				${comments.rno } <br />
				${comments.idx } <br />
				${comments.nickname } <br />
				${comments.comments } <br />
				${comments.regdate } <br />
			</c:forEach>
		</div>


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
		
	</script>
</body>
</html>