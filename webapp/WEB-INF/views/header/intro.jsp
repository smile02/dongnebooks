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
			<h1 class="text-center">DongneBooks 소개</h1>	
		<div class="row">
		<div class="rightImage text-right" style="display:block;">
			<img style="height: 200px; width: 30%; display: inline; margin-bottom:20px; margin-right:100px" 
				src="/image/photo/bookstore.jpg" alt="introPicture" />
		</div>
		<div class="text text-left">
			<pre class="text-muted"> 
			  <strong>동네북스에 오신것을 환영합니다!</strong>			 
			동네북스는 '동네'라는 친숙하고 정감이가는 단어와 Books 를 합쳐서 만든 이름입니다.	
			작은 동네에서, 더 나아가 국내에서 내가 필요한 도서나 다른사람이 필요한 도서에 대해
			의사소통도 하고, 사거나 팔 수 있는 목적으로 만들어졌습니다.
			
			동네북스는 사용자들의 의견을 귀담아 듣고 반영하여 동네북스 사이트를 사용하시는데 느끼시는
			불편함을 최소화 하도록 하겠습니다.
			
			또한, 사용자들이 동네북스를 통해서 책에 한걸음 더 가까이 다가갈 수 있도록 함께 노력하겠습니다.
			
			감사합니다!
			
			 - 문의사항은 dongnebooks21@gmail.com으로 메일 보내주시기 바랍니다. -
			</pre>
		</div><%-- 
			<div class="col-sm-3">
				<jsp:include page="../include/right.jsp" />
			</div> --%>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>