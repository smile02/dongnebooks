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
				<jsp:include page="../include/pageView.jsp"/>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-9" style="margin:0 auto;">
				<div class="row">
					<div class="container">
						<div class="row">
							<div class="col-sm-12">
							<h4 class="text-center">FAQ</h4><br />
							
<div class="card bg-light mb-3">
  <div class="card-header">홈페이지 속도가 느립니다.</div>
  <div class="card-body">
    <p class="card-text">
홈페이지의 원활한 이용을 위해 속도 향상 작업을 시행하였습니다만,<br />
인터넷 익스플로러(ie) 브라우저의 경우 속도가 다소 느리게 느껴질 수 있습니다. <br />
좀 더 원활한 이용을 위해서는 Chrome 브라우저를 이용해주시기 바랍니다. <br />
    </p>
  </div>
</div>
<div class="card bg-light mb-3">
  <div class="card-header">회원가입을 했는데 인증메일이 오지 않습니다.</div>
  <div class="card-body">
    <p class="card-text">
회원가입 정보를 입력한 후에는 기입한 이메일에서 인증을 해야합니다. <br />
회원분들 중 인증처리를 못한 경우는 대부분 이메일을 잘못 기입하였거나 인증 메일이 스팸처리가 된 경우입니다.<br />
<br />
인증 메일을 받지 못한 경우에는<br />
1. 5~10분 정도 더 기다려보시기 바랍니다.<br />
2. 스팸 메일함에 인증 메일이 들어가 있는지 확인해 보시기 바랍니다.<br />
3. 인증 메일 재발송을 해보시기 바랍니다.<br />
4. 인증 메일 재발송 또한 실패하였다면, 회원재가입신청을 하시기 바랍니다.<br />
    </p>
  </div>
</div>
<div class="card bg-light mb-3">
  <div class="card-header">자동로그인이 되다가 안됩니다.</div>
  <div class="card-body">
    <p class="card-text">
  자동로그인 기능은 보안을 위해 쿠키와 세션을 동시에 사용하여 저장됩니다. <br />
기능의 유효기간은 최대 7일이며, 그 이후에는 재차 로그인해주셔야 합니다.<br />
로그아웃하실 경우 쿠키가 삭제되므로, 재 로그인 시 자동로그인에 체크해주셔야 합니다.<br />
    </p>
  </div>
</div>
<div class="card bg-light mb-3">
  <div class="card-header">책을 구매했는데 책은 안오고 판매자가 연락이 안돼요~!</div>
  <div class="card-body">
    <p class="card-text">
  동네북스는 비영리 사이트로서, 개인간 직거래를 원칙으로 하므로 거래에 문제 발생 시에는 책임을 지지 않습니다. <br />
따라서 거래 시 판매자의 개인 정보에 주소나 전화번호 등이 없는 판매자와는 거래하지 않는 것이 좋습니다. <br />
게시판을 검색하셔서 불량 판매자로 신고된 이력이 있는지를 확인하시고,<br />
모두 확인했는데도 문제가 발생한다면 반드시 게시판 등에 아이디와 닉네임을 기재하여 신고해 주세요.<br />
    </p>
  </div>
</div>			
							
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<jsp:include page="../include/right.jsp" />
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>