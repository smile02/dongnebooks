<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sign up</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.1.1/minty/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4eGtnTOp6je5m6l1Zcp2WUGR9Y7kJZuAiD3Pk2GAW3uNRgHQSIqcrcAxBipzlbWP"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<div class="container">
	<div class="row">
		<div class="col-sm-12">
			<div class="jumbotron">
  <h1 class="display-6">Welcome to DongneBooks!</h1>
  <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
  <hr class="my-4">
  <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
</div>
		</div>
  </div>
	<div class="row">
		<div class="col-sm-9">
		<h3 class="text-center">Sign Up</h3><br /><br />
			<form:form action="/user/signup" method="post" modelAttribute="user">
  <fieldset>
	<div class="form-group row">
      <label for="id" class="col-sm-2">ID</label>
      <div class="col-sm-6">
      	<form:input type="text" class="form-control" id="id" path="id" placeholder="Enter Id"/>
      	<form:errors path="id" class="error"/>
      </div>
      <div class="col-sm-1">
      	<button class="btn btn-outline-primary btn-sm" type="button" onclick="idCheck();">중복확인</button>
      </div>
      <div class="col-sm-3 text-center" id="idCheck"></div>
    </div>
    <div class="form-group row">
      <label for="nickname" class="col-sm-2">Nick Name</label>
      <div class="col-sm-6">
      	<form:input type="text" class="form-control" id="nickname" path="nickname" placeholder="Enter NickName"/>
      	<form:errors path="nickname" class="error"/>
      </div>
      <div class="col-sm-1">
      	<button class="btn btn-outline-primary btn-sm" type="button" onclick="nickCheck();">중복확인</button>
      </div>
      <div class="col-sm-3 text-center" id="nickCheck"></div>
    </div>
    <div class="form-group row">
      <label for="email" class="col-sm-2">Email address</label>
	  <div class="col-sm-6">
	      <form:input type="text" class="form-control" id="email" path="email" aria-describedby="emailHelp" placeholder="Enter email"/>
	      <small id="emailHelp" class="form-text text-muted">회원 가입 시 이메일 인증이 필요합니다.</small>
	      <form:errors path="email" class="error"/>
      </div>
      <div class="col-sm-1">
      	<button type="button" class="btn btn-outline-primary btn-sm" onclick="certifyEmail(this);">인증</button>
      </div>
      <div class="col-sm-1">
      	<div id="loader"></div>
      </div>
    </div>
    <div class="form-group row">
    	<label for="emailcode" class="col-sm-2">Email 인증번호</label>
		  <div class="col-sm-3">
		  	<form:input type="text" class="form-control form-control-sm" id="emailcode" path="emailcode" placeholder="인증번호입력"/>
      		<form:errors path="emailcode" class="error"/>
	      </div>
    </div>
    <div class="form-group row">
      <label for="password" class="col-sm-2">Password</label>
      <div class="col-sm-6">
      	 <form:password class="form-control" id="password" path="password" placeholder="Password"/>
      	 <form:errors path="password" class="error"/>
      </div>
    </div>
    <div class="form-group row">
      <label for="passwordConfirm" class="col-sm-2">Password 확인</label>
      <div class="col-sm-6">
      	 <form:password class="form-control" id="passwordConfirm" path="passwordConfirm" placeholder="Password Confirm"/>
      	 <form:errors path="passwordConfirm" class="error"/>
      </div>
    </div>
    <div class="form-group row">
      <label for="phone" class="col-sm-2">Phone</label>
      <div class="col-sm-6">
      	<form:input type="text" class="form-control" id="phone" path="phone" placeholder="ex)010-1234-5678"/>
      	<small class="form-text text-muted">도서 거래 시 거래자와 직접 연락을 할 수 있습니다.</small>
      	<form:errors path="phone" class="error"/>
      </div>
    </div>
    <div class="form-group">
    	<div class="row">
    	<label for="" class="col-sm-2">Address</label>
    	<!-- <input type="text" id="sample3_postcode" class="form-control" placeholder="postcode"> -->
		<div class="col-sm-2"><input type="button" onclick="sample3_execDaumPostcode()" class="btn btn-primary btn-sm" value="우편번호"></div>
			<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
				<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
			</div>
			<br />
		</div>
		<div class="col-sm-10">
		<form:input type="text" id="sample3_address" path="address" class="d_form large form-control" placeholder="우편번호 버튼을 눌러 주소를 입력해주세요."/>
		<small class="form-text text-muted">택배 거래 시 배송지를 쉽게 입력할 수 있습니다.</small>
		</div>
    </div>
    <div class="row">
    	<div class="col-sm-12 text-center">
    		<button type="submit" class="btn btn-primary btn-sm">가입하기</button>
    		<button type="reset" class="btn btn-primary btn-sm">재입력</button>
    	</div>
    </div>
  </fieldset>
</form:form>
		</div>
		<div class="col-sm-3">
		<jsp:include page="../include/right.jsp"/>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp"/>
<!-- script library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script>
	//아이디 중복확인코드
	function idCheck(){
		var id = $("#id").val();
		console.log(id);
		$.ajax({
			url:"/user/idCheck",
			type:"post",
			data:{id:id},
			success:function(result){
				if(result == 'incorrect'){
					$("#idCheck").text("소문자+숫자 4자이상 20자 이하");
				}else if(result == 'n'){
					$("#idCheck").text("사용가능한 아이디");
				}else if(result == 'y'){
					$("#idCheck").text("중복되는 아이디");
				}else{
					$("#idCheck").text("잠시후 다시 시도해주세요.");
				}
			}
		});
	}
	//닉네임 중복확인코드
	function nickCheck(){
		var nickname = $("#nickname").val();
		$.ajax({
			url:"/user/nickCheck",
			type:"post",
			data:{nickname:nickname},
			success:function(result){
				//console.log(result);
				if(result == 'incorrect'){
					$("#nickCheck").text("2자 이상 15자 이하 입력요망");
				}else if(result == 'n'){
					$("#nickCheck").text("사용가능한 닉네임");
				}else if(result == 'y'){
					$("#nickCheck").text("중복되는 닉네임");
				}else{
					$("#nickCheck").text("잠시후 다시 시도해주세요.");
				}
			}
		});
	}
	
	//이메일 인증요청코드
	function certifyEmail(button){
		$("#loader").addClass("loader");
		$(button).attr("disabled", "disabled");
		$.ajax({
			url:"/user/emailCertify",
			type:"post",
			data:{email:$("#email").val()},
			success:function(result){
				$(button).removeAttr("disabled");
				$("#loader").removeClass("loader");
				if(result == 'success'){
					alert("메일 발송완료");
				}else if(result == 'incorrect'){
					alert("메일 형식에 맞지 않습니다.");
				}else if(result == 'duplicated'){
					alert('중복된 이메일 주소입니다.');
				}else if(result == 'error'){
					alert('서버 오류입니다.');
				}else if(result == 'null'){
					alert('이메일을 입력해 주세요.');
				}
			}
		});
	}
</script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="/js/address.js"></script>
</body>
</html>