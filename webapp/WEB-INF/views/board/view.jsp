<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	Calendar today = Calendar.getInstance();
	today.set(Calendar.HOUR_OF_DAY, today.get(Calendar.HOUR_OF_DAY)-24);
	Date yesterday = today.getTime();
	pageContext.setAttribute("yesterday", yesterday);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>동네북스에 오신 것을 환영합니다!</title>
<style>
.btn-center{
	text-align: center;
	display: inline-block;
}
</style>
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
		<form action="${pageContext.request.contextPath}/board/insert" 
			 	  method="post">
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
				<table class="table table-hover">
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
						<td colspan="8">${board.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="8">${board.comments }</td>
					</tr>
				</table>
			</div>
			<br />
			<div class="row">
				<div class=" col-sm-12 buttons text-center">
					<button type="button" class="btn btn-primary btn-sm btn-center"
						onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>
					<!-- 게시글올린 사용자만 수정과 삭제 볼수 있게 -->
					<c:if test="${sessionScope.user.nickname == board.nickname }">
					<button type="button" class="btn btn-primary btn-sm btn-center"
						onclick="update(this.form)">수정</button>
					<button type="button" class="btn btn-primary btn-sm"
							onclick="del(${board.idx})">삭제</button>
					</c:if>
					<!-- 관리자로 로그인 했을 때 이상한글 올렸을 때 관리자가 임의로 삭제할수 있는버튼 생성 -->
					<c:if test="${sessionScope.user.nickname == '관리자' }">
					<button type="button" class="btn btn-dark btn-sm btn-center"
						onclick="admin_delete(${board.idx})">관리자삭제</button>
					</c:if>
				</div>
			</div>
		</form>
	</div>
	<br />
	<!--  댓글입력하는  -->
	<div class="container">
		<div class="row col-12">
			<form:form action="/reply/insert" method="post" modelAttribute="reply">
				<!-- 로그인 했을 때만 댓글 작성할 수 있는 input태그 추가 -->
			<button class="btn btn-info btn-sm" type="button" disabled="disabled">댓글</button>
			<c:if test="${!empty sessionScope.user.nickname }">
				<input type="hidden" name="idx" value="${board.idx }" />
				<form:input class="form-control col-12 d-inline text-center" type="text" path="comments" id="comments"
					        placeholder="댓글 내용을 아주 재빠르게 입력하세요." style="text-align:center; width:820px; height:36px; letter-spacing: -1px"/>
				<button class="btn btn-primary btn-sm" type="submit">등록</button>
				<form:errors path="comments" class="error"/>
			</c:if>
			</form:form>
		</div>
		<!-- 댓글리스트 -->
		<div class="container">
			<form>
			<table class="table table-hover">
				<tr>
					<th width="12%">작성자</th>
					<th width="*">댓글내용</th>
					<th width="10%">댓글시간</th>
					<th width="20%"></th>
				</tr>
				<c:if test="${empty board.replyList }">
					<tr>
						<th colspan="3" style="text-align: center">이 게시판에 댓글이 존재하지않습니다. <br /> 첫댓글을 달아보세요.</th>
					</tr>
				</c:if>
				<c:forEach var="reply" items="${board.replyList }">
					<tr>
						<td>${reply.nickname }</td>
						<td id="td_${reply.rno }">${reply.comments }
						</td>
						<td>
							<f:parseDate var="date" value="${reply.regdate }"
								pattern="yyyy-MM-dddd HH:mm:ss"/>
							<c:if test="${date le yesterday}">	
								<f:formatDate value="${date }" pattern="yyyy/MM/dd"/>
							</c:if>
							<c:if test="${date ge yesterday}">	
								<f:formatDate value="${date }" pattern="HH:mm:ss"/>
							</c:if>	
						</td>
						<!-- 해당 댓글 작성자만 수정하고 삭제 할 수 있게 -->
						<td>
							<c:if test="${sessionScope.user.nickname == reply.nickname }">
<<<<<<< HEAD
								<button id="replyMod_${reply.rno}" class="btn btn-primary btn-sm" type="button" onclick="reply_update(${reply.rno})">수정</button>
								<button class="btn btn-primary btn-sm" type="button" onclick="reply_del(${reply.rno})">삭제</button>
=======
								<button id="replyMod_${reply.rno }" class="btn btn-primary btn-sm" type="button" 
										onclick="reply_update(${reply.rno})">수정</button>
								<button class="btn btn-primary btn-sm" type="button" 
										onclick="reply_del(${reply.rno})">삭제</button>
>>>>>>> f31b325144907cee42515625a1938f5f6aac07d3
							</c:if>
							<!-- 관리자권한으로 댓글 삭제 -->
							 <c:choose>
							 	<c:when test="${sessionScope.user.nickname == '관리자' && reply.nickname  == sessionScope.user.nickname}">
									<button id="reply_deladmin_${reply.rno}" class="btn btn-primary btn-sm" type="button" 
										onclick="reply_del_admin(${reply.rno})" style="display:none;">관리자삭제</button>
								</c:when> 
								<c:when test="${sessionScope.user.nickname == '관리자' }">
									<button id="reply_deladmin_${reply.rno}" class="btn btn-dark btn-sm" type="button" 
										onclick="reply_del_admin(${reply.rno})">관리자삭제</button>
								</c:when>
							</c:choose> 
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
	
		
	//댓글수정하는 input태그에서 엔터눌러서 전송 안되게 막는거
	function enabled_enter(){
		if(event.keyCode==13){
			event.returnValue=false;
		}else{
			return;
		}
	}
	
	//해당 사용자에게만 뜨는 게시글 삭제 눌렀을 때 
	function del(idx){
		var answer = confirm("이글을 삭제 하시겠습니까?");
		if(!answer){
			return;
		}
		$.ajax({
			url:"/board/delete",
			type:"post",
			data:{idx:idx},
			success:function(data){
				if(data=='y'){
					location.href='${pageContext.request.contextPath}/board/list';
				}else{
					alert("삭제실패");
					location.href='${pageContext.request.contextPath}/board/list';
				}
			}
		});
	}
	
	//관리자 전용 글삭제(이상한글 올렸을 때 관리자가 임의로 삭제할수 있게)
	function admin_delete(idx){
		var answer = confirm("관리자권한으로 이 글을 삭제 하시겠습니까?");
		if(!answer){
			return;
		}
		$.ajax({
			url:"/board/delete",
			type:"post",
			data:{idx:idx},
			success:function(data){
				if(data=='y'){
					alert("관리자권한으로 삭제");
					location.href='${pageContext.request.contextPath}/board/list';
				}else{
					alert("삭제실패");
					location.href='${pageContext.request.contextPath}/board/list';
				}
			}
		});
	}
	
	//관리자전용 댓글삭제(이상한글 올렸을 때 관리자가 임의로 삭제할수 있게)
	function reply_del_admin(rno){
		var answer = confirm("관리자권한으로 이 댓글을 삭제 하시겠습니가?");
		if(answer){
			$.ajax({
				url:"/reply/delete/{rno}",
				type:"post",
				data:{rno:rno},
				success:function(data){
					if(data=='y'){
						alert("권한사용");
						history.go(0);
					}else{
						alert("권한사용실패");
						history.go(0);
					}
				}
			});
		}
	}
	
	//글수정 눌렀을 때 해당글의 올린작성자인지 확인하고 맞으면 수정페이지(update)로 아니면 로그인화면으로
	function update(form){
		var nickname ="${sessionScope.user.nickname}";
		console.log(nickname);
		if(nickname == '${board.nickname}'){
			location.href='update?idx=${board.idx}';
		}else{
			alert("지금 뭐하시는거죠.?");
			location.reload();
		}
	}
	
	//댓글삭제
	function reply_del(rno){
		var answer = confirm("해당댓글을 삭제하시겠습니까?");
		if(answer){
			$.ajax({
				url:"/reply/delete/{rno}",
				type:"post",
				data:{rno:rno},
				success:function(data){
					if(data=='y'){
						alert("댓글삭제");
						history.go(0);
					}else{
						alert("댓글삭제실패");
						history.go(0);
					}
				}
			});
		}
	}
	
	//댓글수정
	function reply_update(rno) {
<<<<<<< HEAD
		console.log(rno);
		$("#replyMod_"+rno).attr("disabled",true);
		console.log($("#replyMod_"+rno).val());
		var comments_td = $("#td_"+rno);		
		var $input = $("<input id='input_"+rno+"' type='text'/>");
		console.log(comments_td.text());
=======
		var comments_td = $("#td_"+rno);
		//$("#replyMod_"+rno).attr('disabled',true);
		$("#replyMod_"+rno).css('display',"none");
		var $input = $("<input id='input_"+rno+"' type='text' onkeypress='enabled_enter()'/>");
>>>>>>> f31b325144907cee42515625a1938f5f6aac07d3
		$input.val(comments_td.text());
		comments_td.empty();
		comments_td.append($input);
		var $button = $("<button type='button' class='btn btn-primary btn-sm' onclick='updateToServer("+rno+")'>완료</button>");
		comments_td.append($button);
		
	}
	function updateToServer(rno){
		var comments = $("#input_"+rno).val();
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