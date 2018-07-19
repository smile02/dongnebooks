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
		<c:if test="${sessionScope.user.nickname == null }">
			<input class="form-control col-3 d-inline" type="text" name="nickname" 
				   value="방문자"/ readonly> 님 환영합니다.
		</c:if>
		<c:if test="${sessionScope.user.nickname != null }">
			<input class="form-control col-3 d-inline" type="text" name="nickname" 
				   value="${sessionScope.user.nickname }" readonly/> 님 환영합니다.
		</c:if>
		<form action="${pageContext.request.contextPath}/board/update"
			method="post">
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
								<input id="title" type="text" name="title" 
									   style="text-align:center; width:500px; height:50px;" value="${board.title }" />
							</td>
							
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="7">
								<textarea class="form-control" id="comments" 
								style="text-align:center; width:990px; height:300px; letter-spacing: 1px" 
										name="comments">${board.comments }
								</textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="row">
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary btn-sm"
							onclick="update(this.form)">
						수정하기
						</button>
						<button type="reset" class="btn btn-primary btn-sm">
						재입력
						</button>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="location.href='${pageContext.request.contextPath}/board/list'">
						목록
						</button>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="del(${board.idx})">
						삭제
						</button>
					</div>
				</div>
			</fieldset>
		</form>
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
		
		/* 수정 눌렀을 때 */
		function update(form) {
			var title = form.title.value;
			var idx = form.idx.value;
			var comments = form.comments.value;
			//제목,이름,내용 유효성 검사
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
			$.ajax({
				url:"/board/update",
				type:"post",
				data:{idx:idx,
					title:title,
					comments:comments},
					success:function(data){
					if(data=='y'){
						alert("수정완료");
						location.href='${pageContext.request.contextPath}/board/view?idx='+idx;
					}else{
						alert("수정실패");
					}
				}
				
			});
			
			form.submit();

		}
	</script>
</body>
</html>