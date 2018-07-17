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
	<jsp:include page="include/header.jsp" />
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

		<div class="row">
			<div class="col-sm-9">
				<div class="row">
					<div class="col-sm-12">
						<h4>공지사항</h4>
						<p class="text-right"><a href="/board/list"><span class="badge badge-primary badge-pill">more..</span></a></p>
<table class="table table-hover">
<caption class="text-right"></caption>
  <thead>
    <tr class="table-secondary text-center">
      <th scope="col" width="60%">제목</th>
      <th scope="col" width="20%">날짜</th>
      <th scope="col" width="20%">작성자</th>
    </tr>
  </thead>
  <tbody>
    <c:if test="${empty noticeList}">
		<tr>
			<td colspan="4">등록된 공지사항이 없습니다.</td>
		</tr>						
	</c:if>
	<c:forEach var="notice" items="${noticeList}">
		<tr class="table-light">
			<td>
				<a href="/board/view?idx=${notice.idx}">${notice.title}</a></td>
			<td class="text-center">
				<f:parseDate var="date" value="${notice.regdate}" pattern="yyyy-MM-dd"/>
				<f:formatDate value="${date}" pattern="yyyy/MM/dd" />
			</td>
			<td class="text-center">${notice.nickname}</td>
		</tr>
	</c:forEach>
  </tbody>
</table> 
						<hr />
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<h4>최근 등록도서</h4>
						<p class="text-right"><a href="/books/list"><span class="badge badge-primary badge-pill">more..</span></a></p>
					</div>
				</div>
				<div class="row">
					<c:if test="${ empty newBooks }">
					<div class="col-sm-12 text-center">
						최근 등록된 도서가 없습니다.
					</div>
					</c:if>
					<c:forEach var="book" items="${newBooks}">
					<div class="col-sm-6">
					<div class="media">
					  <div class="media-left media-middle">
					    <c:if test="${book.photo ne 'no_file' && book.photo != null}">
							<img class="img-circle media-object" src="/image/photo/${book.photo }" />
						</c:if>									
						<c:if test="${book.photo == 'no_file' || book.photo == null}">
							<img class="img-circle media-object" src="/image/photo/noimage.png" />
						</c:if>
					  </div>
					  <div class="media-body">
					    <h5 class="media-heading">${book.title}</h5>
					   	${book.price}원<br />
					   	${book.b_category}/${book.s_category}
					  </div>
					</div>
					</div>
					</c:forEach>
				</div>
			</div>
			<div class="col-sm-3">
				<jsp:include page="include/right.jsp" />
			</div>
		</div>
	</div>
	<jsp:include page="include/footer.jsp" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>