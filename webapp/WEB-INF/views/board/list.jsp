<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.1.1/minty/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4eGtnTOp6je5m6l1Zcp2WUGR9Y7kJZuAiD3Pk2GAW3uNRgHQSIqcrcAxBipzlbWP"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css" />
<style>
.paging, form-group {
	display: inline-block;
}

.select_option{
	display: inline-block;
	margin-top: 12px;
	margin-bottm: 12px;
}

.pagination {
	margin-top: 20px;
}

th {
	text-align: center;
}

	/* #box1 { position: static; top: 20px; left: 30px; }
	#box2 { position: relative; top: 20px; left: 30px; } */
	#paging { position: absolute; bottom: 100px; left: 480px; }
	
</style>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<jsp:include page="../include/pageView.jsp"/>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="form-control">
			<div class="form-control board-header">
				<h3 class="text-center display-5">게 시 판</h3>
				<table class="table table-hover">
					<thead>
						<tr class="table-light">
							<th width="7%" class="text-center">분 류</th>
							<th width="*" class="text-center">제 목</th>
							<th width="15%" class="text-center">작성자</th>
							<th width="12%" class="text-center">날 짜</th>
							<th width="8%" class="text-center">조회수</th>
						</tr>
						<c:if test="${empty boardList }">
							<tr>
								<!-- 게시물이 존재하지않을때 -->
								<td colspan="10">게시물이 존재하지 않습니다.</td>
							</tr>
						</c:if>
					</thead>
					<!-- 리스트 뿌리는 것 -->
					<c:forEach var="bvo" items="${boardList }">
						<tbody>
							<tr>
								<c:if test="${bvo.code == 1 }">
									<th>
										<span class="badge badge-pill badge-secondary">공지</span>
									</th>
								</c:if>
								<c:if test="${bvo.code == 2 }">
									<th>
										<span class="badge badge-pill badge-success">일반</span>
									</th>
								</c:if>
								<c:if test="${bvo.code == 3 }">
									<th>
										<span class="badge badge-pill badge-warning">질문</span>
									</th>
								</c:if>
								<c:if test="${bvo.code == 4 }">
									<th>
										<span class="badge badge-pill badge-dark">신고</span>
									</th>
								</c:if>
								<th>
									<a href="${pageContext.request.contextPath }/board/view?idx=${bvo.idx}">
										${bvo.title } 
										<!-- 댓글 갯수만큼 숫자 표시 --> 
										<span
										class="badge badge-info">댓글 ${bvo.replysize }
										</span> 
										<f:parseDate
											var="date2" value="${bvo.regdate }"
											pattern="yyyy-MM-dddd HH:mm:ss" /> 
										<!-- 글작성 시간이 24시간 이내이면 새글표시 -->
										<c:if test="${date2 ge yesterday}">
											<span class="badge badge-secondary">NEW</span>
											<!-- 글작성시간 24시간 이내에서 게시글의 조회수가 100넘으면 인기게시글 표시 -->
											<c:if test="${bvo.cnt >= 10 }">
												<span class="badge badge-danger">HOT</span>
											</c:if>
										</c:if>
									</a>
								</th>
								<th>${bvo.nickname }</th>
								<th>
									<f:parseDate var="date" value="${bvo.regdate }"
										pattern="yyyy-MM-dddd HH:mm:ss" /> <!-- timeZone="KST" 요거 우리나라 시간으로 맞출때-->
									<c:if test="${date le yesterday}">
										<f:formatDate value="${date }" pattern="yyyy/MM/dd" />
									</c:if> 
									<c:if test="${date ge yesterday}">
										<f:formatDate value="${date }" pattern="MM/dd HH:mm" />
									</c:if>
								</th>
								<th>${bvo.cnt }</th>
							</tr>
						</tbody>
					</c:forEach>
				</table>
			</div>
			<div class="form-control">
				<div class="container-fluid" style="margin: 0 auto;">
					<div class="row">
						<div class="col-md-10 form-group">
							<select
								class="select_option custom-select-width form-control col-3"
								id="search_option" onchange="lock()">
								<option value="all">전체</option>
								<option value="title">제목</option>
								<option value="nickname">작성자</option>
								<option value="comments">내용</option>
								<option value="title_name">제목+작성자</option>
							</select> 
							<input id="search_text" type="text" placeholder="검색할 단어를 이곳에"
								disabled="disabled"
								class="form-control is-valid custom-input-width col-3"
								id="inputValid">
							<div class="valid-feedback">무엇을 검색 하실껀가요?</div>
							<button class="btn btn-primary btn-sm custom-select-width"
								type="button" onclick="search()" style="margin: 0 auto;">검색</button>
						</div>
						<div class="col-md-2 text-right">
							<button type="button"
								class="btn btn-primary btn-block custom-button-width .navbar-right col-8"
								onclick="location.href='${pageContext.request.contextPath}/board/insert'">글쓰기</button>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 text-center">
						<div class="paging" id="paging">
							<ul class="pagination">${paging }
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
		<script>
	function lock(){
		if($("#search_option").val() != 'all'){
			$("#search_text").removeAttr("disabled");
			$("#search_text").val("");
		}else{
			$("#search_text").attr("disabled",true);
		} 
 	}
 	
 	function search(){
 		var option =$("#search_option").val();
 		var text = $("#search_text").val();
 		if(option != 'all' && text == ""){
 			alert("검색어를 입력해주세요.");
 			$("#search_text").focus();
 			return;
 		}
 		
 		location.href = "?option="+option+"&text="+text;
 	}
 
 	$(function(){
		$("#search_text").val("${param.text}");
		for(var option of $("#search_option").children()){
			if($(option).val() == "${param.option}"){
				$(option).attr("selected","selected");
			}
		}
		
		lock();
	});
 	
	</script>
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>