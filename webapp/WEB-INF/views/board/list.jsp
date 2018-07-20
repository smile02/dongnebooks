<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
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

	#box1 { position: static; top: 20px; left: 30px; }
	#box2 { position: relative; top: 20px; left: 30px; }
	#paging { position: absolute; bottom: 100px; left: 480px; }
</style>
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
		<div class="col-sm-12">
				<c:if test="${sessionScope.user.nickname == null }">
					<input class="form-control col-3 d-inline" type="text" name="nickname" 
					   value="방문자" readonly/> 님 환영합니다.
				</c:if>
				<c:if test="${sessionScope.user.nickname != null }">
					<input class="form-control col-3 d-inline" type="text" name="nickname" 
					   value="${sessionScope.user.nickname }" readonly/> 님 환영합니다.
				</c:if>
			</div>
		<h3 class="text-center display-5"> 게 시 판 </h3>
		<table class="table table-hover">
			<thead>
				<tr>
					<th width="7%" class="text-center">분 류</th>
					<th width="*" class="text-center">제 목</th>
					<th width="15%" class="text-center">작성자</th>
					<th width="10%" class="text-center">날 짜</th>
					<th width="10%" class="text-center">조회수</th>
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
					<tr class="table-light">
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
							<span class="badge badge-info">댓글 ${bvo.replysize }</span>
							<%-- <jsp:useBean id="now" class="java.util.Date" />
							<f:formatDate value="${now}" pattern="yyyy/MM/dd HH:mm:ss" var="today" />  
							<f:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="currunt" scope="request"/>
							<f:formatDate value="${bvo.regdate }" pattern="yyyy/MM/dd HH:mm:ss" var="write_dt"/>
							<f:parseNumber value="${bvo.regdate / (1000*60*60*24)}" integerOnly="true" var="bvo" scope="request"/>
							<c:if test="${currunt == bvo }">
							new
							</c:if> --%>
							</a>
						</th>
						<th>${bvo.nickname }</th>
						<th>
							<f:parseDate var="date" value="${bvo.regdate }"
								pattern="yyyy-MM-dddd HH:mm:ss"/> <!-- timeZone="KST" 요거 우리나라 시간으로 맞출때-->
							<f:formatDate value="${date }" pattern="yyyy/MM/dd HH:mm:ss"/>
						</th>
						<th>${bvo.cnt }</th>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-10 form-group">
							<select class="select_option custom-select-width form-control col-3" 
									id="search_option" onchange="lock()" style="width:100%;text-align:center;">
								<option value="all">전체</option>
								<option value="title">제목</option>
								<option value="nickname">이름</option>
								<option value="comments">내용</option>
								<option value="title_name">제목+이름</option>
							</select>
							<input id="search_text" type="text" placeholder="검색할 단어를 이곳에"
								   class="form-control is-valid custom-input-width col-3" id="inputValid">
							<div class="valid-feedback">무엇을 검색 하실껀가요?</div>
							<button class="btn btn-primary btn-sm custom-select-width" type="button"
									onclick="search()">검색</button>
				</div>	
				<div class="col-md-2 text-right">
					<button type="button" class="btn btn-primary btn-block custom-button-width .navbar-right col-8"
							onclick="location.href='${pageContext.request.contextPath}/board/insert'">글쓰기</button>
				</div>	
			</div>
		</div>
			<div class="row">
					<div class="col-sm-12 text-center">
						<div class="paging" id="paging">
							<ul class="pagination">
							${paging }
							</ul>
						</div>
					</div>
				</div>
		</div>
		<jsp:include page="../include/footer.jsp" />
		<script>
	function lock(){
		if($("#search_option").val() == 'all'){
			$("#search_text").attr("disabled","disabled");
			$("#search_text").val("");
		}else{
			$("#search_text").removeAttr("disabled");
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