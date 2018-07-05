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
<link rel="stylesheet" href="https://bootswatch.com/4/minty/bootstrap.min.css">
</head>
<style>
	.error{
		font-size:9pt;
		color:red;
	}
	#idCheck, #nickCheck{
		font-size:9pt;
	}
	.loader {
	    border: 2px solid #f3f3f3; /* Light grey */
	    border-top: 2px solid #3498db; /* Blue */
	    border-radius: 50%;
	    width: 30px;
	    height: 30px;
	    animation: spin 2s linear infinite;
	    display:inline-block;
	}

	@keyframes spin {
	    0% { transform: rotate(0deg); }
	    100% { transform: rotate(360deg); }
}
</style>
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
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
				console.log(result);
				if(result == 'n'){
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
				console.log(result);
				if(result == 'n'){
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
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('sample3_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample3_address').value = "(" + data.zonecode + ") " + fullAddr;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
</body>
</html>