<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	Calendar today = Calendar.getInstance();
	today.set(Calendar.HOUR_OF_DAY, today.get(Calendar.HOUR_OF_DAY)-24);
	Date yesterday = today.getTime();
	pageContext.setAttribute("yesterday", yesterday);
%>
<%
    // 줄바꿈 
    pageContext.setAttribute("br", "<br/>");
    pageContext.setAttribute("cn", "\n");
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
		<div class="row">
			<div class="col-sm-12">			
				<div class="jumbotron">
					<jsp:include page="../include/pageView.jsp"/>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="form-control">
			<form action="${pageContext.request.contextPath}/board/insert"
				method="post">
				<div class="row form-control" style="margin: 0 auto;">
					<table class="table table-hover">
						<tr class="table-light">
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
							<td colspan="8"><pre>${board.comments }</pre></td>
						</tr>
					</table>
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
							<!-- 관리자로 로그인 했을 때 이상한글 올렸을 때 관리자가 임의로 삭제할수 있는버튼 생성과 해당글의 작성자가 관리자 이면 삭제버튼만 보여지도록 -->
							<c:choose>
								<c:when
									test="${sessionScope.user.nickname == '관리자' && board.nickname == sessionScope.user.nickname }">
									<button type="button" class="btn btn-dark btn-sm btn-center"
										onclick="admin_delete(${board.idx})" style="display: none;">관리자삭제</button>
								</c:when>
								<c:when test="${sessionScope.user.nickname == '관리자' }">
									<button type="button" class="btn btn-dark btn-sm btn-center"
										onclick="admin_delete(${board.idx})">관리자삭제</button>
								</c:when>
							</c:choose>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<br />
	<!--  댓글입력하는  -->
	<div class="container">
		<form:form action="/reply/insert" method="post" modelAttribute="reply">
			<div class="row col-12"
				style="margin: 0 auto; margin-top: 18px; margin-bottom: 20px;">
				<input type="hidden" name="idx" value="${board.idx }" />
				<!-- 로그인 했을 때만 댓글 작성할 수 있는 input태그 추가 -->
				<div class="col-xs-12 reply_board">
					<c:if test="${!empty sessionScope.user.nickname }">
						<div class="form-control reply_header">
							<div class="col-xs-offset-3">
								<button class="btn btn-info btn-sm text-center" type="button"
									disabled="disabled">댓글</button>
							</div>
							<div class="col-xs-12">
								<form:textarea class="form-control" name="comments" cols="180" 
									rows="3" path="comments" maxlength="100" id="comments"
									wrap="hard" placeholder="댓글을 여기에 엄청 서둘러서 열심히 입력해보세요." />
							</div>
								<button class="btn btn-primary btn-sm" type="submit">등록</button>
								<form:errors path="comments" class="error" />
							<br />
						</div>
						<div class="form-control reply_list">
							<div class="col-xs-offset-3">
								<!-- 댓글리스트 -->
								<div class="form-control">
									<form>
										<table class="table table-hover">
											<tr align="center" valign="middle">
												<th width="12%">작성자</th>
												<th width="*">댓글내용</th>
												<th width="10%">댓글시간</th>
												<th width="20%"></th>
											</tr>
											<c:if test="${empty board.replyList }">
												<tr align="center" valign="middle">
													<th colspan="3" style="text-align: center">이 게시판에 댓글이
														존재하지않습니다. <br /> 첫댓글을 달아보세요.
													</th>
												</tr>
											</c:if>
											<c:forEach var="reply" items="${board.replyList }">
												<tr align="center" valign="middle">
													<td>${reply.nickname }</td>
													<td id="td_${reply.rno }"><pre>${reply.comments }<pre></pre></td>
													<td>
														<f:parseDate var="date" value="${reply.regdate }"
															pattern="yyyy-MM-dddd HH:mm:ss" /> 
														<c:if test="${date le yesterday}">
															<f:formatDate value="${date }" pattern="yyyy/MM/dd" />
														</c:if> 
														<c:if test="${date ge yesterday}">
															<f:formatDate value="${date }" pattern="HH:mm:ss" />
														</c:if>
													</td>
													<!-- 해당 댓글 작성자만 수정하고 삭제 할 수 있게 -->
													<td><c:if
															test="${sessionScope.user.nickname == reply.nickname }">
															<button id="replyMod_${reply.rno }"
																class="btn btn-primary btn-sm" type="button"
																onclick="reply_update(${reply.rno})">수정</button>
															<button class="btn btn-primary btn-sm" type="button"
																onclick="reply_del(${reply.rno})">삭제</button>
														</c:if> 
														<!-- 관리자권한으로 댓글 삭제 --> 
														<c:choose>
															<c:when
																test="${sessionScope.user.nickname == '관리자' && reply.nickname  == sessionScope.user.nickname}">
																<button class="btn btn-primary btn-sm" type="button"
																	onclick="reply_del_admin(${reply.rno})"
																	style="display: none;">관리자삭제</button>
															</c:when>
															<c:when test="${sessionScope.user.nickname == '관리자' }">
																<button class="btn btn-dark btn-sm" type="button"
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
						</div>
					</c:if>
				</div>
			</div>
		</form:form>
	</div>
	<jsp:include page="../include/footer.jsp" />
	<!-- script library -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
	
		
	/* //댓글수정하는 input태그에서 엔터눌러서 전송 안되게 막는거
	 function enabled_enter(){
		if(event.keyCode==13){
			event.returnValue=false;
		}else{
			return;
		}
	}  */
	
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
		var comments_td = $("#td_"+rno);
		//$("#replyMod_"+rno).attr('disabled',true);
		$("#replyMod_"+rno).css('display',"none");
		var $input = $("<textarea id='textarea_"+rno+"' maxlength='300'name='comments' class='form-control d-inline text-center' rows='1' cols='1' wrap='hard'></textarea><span id='reply_comments' class='error'/>");
		console.log(comments_td.text());
		$input.val(comments_td.text());
		comments_td.empty();
		comments_td.append($input);
		var $button = $("<button type='button' class='btn btn-primary btn-sm custom-button-width' onclick='replySend_btn("+rno+")'>완료</button>");
		comments_td.append($button);
		
	}
	
	//완료 버튼눌리면
	function replySend_btn(rno){
		var comments = $("#textarea_"+rno).val();
		//$("#textarea_"+rno).remove("");
        
		/* var frm = document.form1;
		console.log(frm)
        // 문자열 제일 앞의 화이트스페이스(공백, 엔터, 탭) 을 제거함.
        frm.comments.value = frm.comments.value.replace(/^\s/gm, '');
        frm.reply_comments.value = frm.reply_comments.value.replace(/^\s/gm, '');
        // 위의 정규식으로 없앨수 없는 제일 마지막줄 빈엔터를 제거함.
        frm.comments.value = frm.comments.value.replace(/\r\n$/g, '');
        frm.reply_comments.value = frm.reply_comments.value.replace(/\r\n$/g, '');
        //$.trim($("#reply_comments").val())); */
        
		
		var out_comments = $.trim(comments);
        if(out_comments == null || out_comments == '' || out_comments.length == 0){
        	$("#reply_comments").html("공백은 입력 할 수 없습니다.");
        	return;
        } 
		console.log("너 뭐니 : "+out_comments);
		$.ajax({
			url:"/reply/update",
			type:"post",
			data:{rno:rno,
				comments:out_comments},
				success:function(data){
				if(data=='y'){
					alert("댓글수정완료");
					history.go(0);
				}else{
					$("#reply_comments").html(data+"&nbsp;&nbsp;")
				}
			}
			
		});
	}
	
	</script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>