<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
		<form:form action="${pageContext.request.contextPath}/board/update"
			method="post" modelAttribute="board">
			<input type="hidden" name="idx" value="${board.idx }" />
			<fieldset>
				<table class="table">
					<tbody>
						<tr>
							<th>분류</th>
							<td>
								<c:if test="${board.code == 1 }">
									<td>[공지]</td>
								</c:if> 
								<c:if test="${board.code == 2 }">
									<td>[일반]</td>
								</c:if>
								<c:if test="${board.code == 3 }">
									<td>[질문]</td>
								</c:if>
								<c:if test="${board.code == 4 }">
									<td>[신고]</td>
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
							<td colspan="7">
								<form:input path="title" type="text" class="form-control" onkeypress="enabled_enter()"
									   style="width:500px; height:50px;" value="${board.title}" />
								<form:errors path="title" class="error"/>
							</td>
							
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="7">
								<form:textarea class="form-control" path="comments" style="width:990px; height:300px;" title="${board.comments}"></form:textarea>
								<form:errors path="comments" class="error"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="row">
					<div class="col-sm-12 text-center">
						<button type="submit" class="btn btn-primary btn-sm">수정하기</button>
						<button type="reset" class="btn btn-primary btn-sm">재입력</button>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="del(${board.idx})">삭제</button>
					</div>
				</div>
			</fieldset>
		</form:form>
	</div>
	<br />

	<jsp:include page="../include/footer.jsp" />
	<!-- script library -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		/* 게시글 삭제 눌렀을 때 */
		function del(idx){
			var answer = confirm("정말로 삭제하시겠습니까?")
			if(!answer){
				return;
			}
			$.ajax({
				url:"/board/delete",
				type:"post",
				data:{idx:idx},
				success:function(data){
					if(data=='y'){
						alert("삭제");
						location.href='${pageContext.request.contextPath}/board/list';
					}else{
						alert("삭제실패");
						location.href='${pageContext.request.contextPath}/board/list';
					}
				}
			});
		}
		
		//input태그에서 엔터눌러서 전송 안되게 막는거
		function enabled_enter(){
			if(event.keyCode==13){
				event.returnValue=false;
			}else{
				return;
			}
		}

		
	</script>
</body>
</html>