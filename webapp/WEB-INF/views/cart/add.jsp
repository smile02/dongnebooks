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
			<div class="col-sm-9">
				<h3 class="text-center">Cart</h3><br />
				<form:form action="/cart/add/${idx}" method="post" modelAttribute="cart">
  <fieldset>
  	<div class="form-group row">
      <label for="title" class="col-sm-2">구매도서</label>
      <div class="col-sm-6">
      	<form:input type="hidden" class="form-control" id="idx" path="idx" value="${idx}"/>
      	<b>${title}</b>
      </div>
    </div>
    <div class="form-group row">
      <label for="nickname" class="col-sm-2">Nick Name</label>
      <div class="col-sm-6">
      	<form:input type="text" class="form-control" id="nickname" path="nickname" value="${sessionScope.user.nickname}" readonly="true"/>
      </div>
    </div>
    <div class="form-group">
    	<div class="row">
    		<label for="" class="col-sm-2">Address</label>
    	<!-- <input type="text" id="sample3_postcode" class="form-control" placeholder="postcode"> -->
			<div class="col-sm-2">
				<input type="button" onclick="sample3_execDaumPostcode()" class="btn btn-primary btn-sm" value="우편번호" id="postCode">
			</div>
			<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
				<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
			</div>
			<br />
		</div>
		<div class="row">
			<div class="col-sm-2">
			</div>
			<div class="col-sm-8">
				<form:input type="text" id="sample3_address" path="address" class="d_form large form-control" placeholder="우편번호 버튼을 눌러 주소를 입력해주세요."/>
				<div class="custom-control custom-checkbox">
				      <input type="checkbox" class="custom-control-input" id="myAddress">
				      <label class="custom-control-label" for="myAddress">내 주소 가져오기</label>
				</div>
				<small class="form-text text-muted">직거래 시 가능 장소를, 택배 거래 시 수령할 주소를 정확히 입력해 주세요.</small>
				<form:errors path="address" class="error"/>
			</div>
		</div>
    </div>
    <div class="form-group row">
      <label for="d_type" class="col-sm-2">거래유형</label>
      <div class="col-sm-8">
      	<form:select path="d_type" class="custom-select">
	      <form:option value="" selected="">거래방법 선택(필수)</form:option>
	      <form:option value="direct">직거래</form:option>
	      <form:option value="start">택배(선불)</form:option>
	      <form:option value="end">택배(착불)</form:option>
	    </form:select>
	    <form:errors path="d_type" class="error"/>
	    <small class="form-text text-muted">만약 판매자의 판매방식과 다른 거래방법을 원하실 경우, 판매자와 직접 협의하세요.</small>
      </div>
    </div>
    <div class="form-group row">
      <label for="request" class="col-sm-2">요청사항</label>
      <div class="col-sm-8">
      	<form:textarea class="form-control" id="request" path="request" rows="3" ></form:textarea>
      	<form:errors path="request" class="error"/>
      	<button type="button" class="btn btn-primary btn-sm" onclick="addPhone();">폰번호 전달</button>
      </div>
    </div>
    <div class="form-group row">
      <label for="name" class="col-sm-2">Name</label>
      <div class="col-sm-8">
      	<form:input type="text" class="form-control" id="name" path="name"/>
      	<form:errors path="name" class="error"/>
      	<small class="form-text text-muted">수령인이 다르거나 택배거래일 경우 수령자 성명을 입력해주세요.</small>
      </div>
    </div>
    <div class="row">
    	<div class="col-sm-12 text-center">
    		<button type="submit" class="btn btn-primary btn-sm" >판매요청</button>
    		<button type="button" class="btn btn-primary btn-sm" onclick="history.back();">취소</button>
    	</div>
    </div>
  </fieldset>
</form:form>
				
			</div>
			<div class="col-sm-3">
				<jsp:include page="../include/right.jsp" />
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
	
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	<script src="/js/address.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<script>
		//체크하면 내 주소 가져오기.
		$("#myAddress").on("click", function(){
			var address = "${sessionScope.user.address}";
			var isChecked = $("#myAddress").is(":checked");
			//console.log(isChecked);
			//console.log(address);
			if(isChecked){
				$("#sample3_address").val(address);
			}else{
				$("#sample3_address").val("");
			}
		});
		//클릭하면 내 폰번호가 요청사항 아랫줄에 추가.
		function addPhone(){
			var content = $("#request").val();
			var phone = content + "\n핸드폰번호: " + "${sessionScope.user.phone}";
			$("#request").val(phone);
			
			//console.log($("#request").val());
		}
	</script>
</body>
</html>