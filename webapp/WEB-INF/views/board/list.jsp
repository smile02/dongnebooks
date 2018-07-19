<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date" %>
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
<style>
.paging, form-group {
	display: inline-block;
}

.select_option{
	display: inline-block;
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
							<span class="badge badge-pill badge-warning">공지</span>
							</th>
						</c:if>
						<c:if test="${bvo.code == 2 }">
							<th>
								<span class="badge badge-pill badge-secondary">일반</span>
							</th>
						</c:if>
						<th>
							<a href="${pageContext.request.contextPath }/board/view?idx=${bvo.idx}">
							${bvo.title }
							<span class="badge badge-info">댓글 ${bvo.replysize }</span>
							<%-- <c:set var="today" value="<%=new Date()%>">
							<f:parseDate var="regdate" value="${bvo.regdate}" pattern="yyyy-MM-dd"/>
							<f:parseDate var="now" value="${sysdate}" pattern="yyyy-MM-dd"/>
					        <f:parseNumber var="current" value="${now / (1000*60*60*24)}" integerOnly="true"/>
					        <f:parseNumber var="reg_date" value="${regdate / (1000*60*60*24)}" integerOnly="true"/>
							<c:if test="${curent - reg_date < 1 }">
							<span class="badge badge-info">new</span>
							</c:if> --%>
							</a>
						</th>
						<th>${bvo.nickname }</th>
						<th>
							<!-- 날짜 한국시간으로 뿌리는거 -->
							<f:parseDate var="date" value="${bvo.regdate }"
								pattern="yyyy-MM-dddd HH:mm:ss" timeZone="KST"/> 
							<f:formatDate value="${date }" pattern="yyyy/MM/dd HH:mm:ss"/>
						</th>
						<th>${bvo.cnt }</th>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		<div class="buttons">
			<div class="col-sm-1 text-right">
				<button type="button" class="btn btn-primary btn-sm btn-block text-center"
					onclick="location.href='${pageContext.request.contextPath}/board/insert'">글쓰기</button>
			</div>

			<div class="row col-sm-12">
				<div class="col-sm-2 form-group text-center">
						<select class="select_option custom-select text-right form-control" id="search_option" onchange="lock()">
							<option value="all">전체</option>
							<option value="title">제목</option>
							<option value="nickname">이름</option>
							<option value="comments">내용</option>
							<option value="title_name">제목+이름</option>
						</select>
						<div class="has-success">
							<label class="form-control-label" for="inputSuccess1"> </label> 
							<input id="search_text" type="text" placeholder="검색"
								class="form-control is-valid" id="inputValid">
							<div class="valid-feedback">무엇을 검색?</div>
							<button class="btn btn-primary btn-sm" type="button"
								onclick="search()">검색</button>
						</div>
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