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
<style>
.paging, form-group {
	display: inline-block;
}

.pagination {
	margin-top: 20px;
}

th {
	text-align: center;
}
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
		<input type="text" name="nickname" value="${sessionScope.user.nickname }" />
		<h2 class="text-center"> 게 시 판 </h2>
		<table class="table table-hover">
			<thead>
				<tr>
					<th width="10%" class="text-center">분 류</th>
					<th width="10%" class="text-center">글번호</th>
					<th width="*" class="text-center">제 목</th>
					<th width="10%" class="text-center">작성자</th>
					<th width="20%" class="text-center">날 짜</th>
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
						<th>${bvo.idx }</th>
						<th>
							<a href="${pageContext.request.contextPath }/board/view?idx=${bvo.idx}">
							${bvo.title }
							<span class="badge badge-danger">Info</span>
							</a>
						</th>
						<th>${bvo.nickname }</th>
						<th>
							<f:parseDate var="date" value="${bvo.regdate }"
								pattern="yyyy-MM-dddd HH:mm:ss" /> 
							<f:formatDate value="${date }" pattern="yyyy/MM/dd" />
						</th>
						<th>${bvo.cnt }</th>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		<div class="buttons">
			<div class="col-sm-1" style="text-align: center;">
				<button type="button" class="btn btn-primary btn-sm btn-block"
					onclick="location.href='${pageContext.request.contextPath}/board/insert'">글쓰기</button>
			</div>

			<div class="row col-sm-12">
				<div class="col-sm-4">
					<div class="form-group">
						<select class="custom-select text-right" id="search_option" onchange="lock()">
							<option value="all">전체</option>
							<option value="title">제목</option>
							<option value="nickname">이름</option>
							<option value="comments">내용</option>
							<option value="title_name">제목+이름</option>
						</select>
					</div>
						<div class="has-success">
							<label class="form-control-label" for="inputSuccess1"> </label> 
							<input
								id="search_text" type="text" placeholder="검색"
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
						<div class="paging">
							<ul class="pagination">${paging }
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