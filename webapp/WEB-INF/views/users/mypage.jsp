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
<title>MyPage</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.1.1/minty/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4eGtnTOp6je5m6l1Zcp2WUGR9Y7kJZuAiD3Pk2GAW3uNRgHQSIqcrcAxBipzlbWP"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css" />
<style>
.paging{
	display:inline-block;
}
</style>
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
		<h3 class="text-center">정보 확인/변경</h3><br /><br />
			<form:form action="/user/mypage" method="post" modelAttribute="user" style="font-size:10pt;">
  <fieldset>
	<div class="form-group row">
      <label for="id" class="col-sm-2">ID</label>
      <div class="col-sm-6">
      	<form:input type="text" class="form-control" id="id" path="id" readonly="true"/>
      </div>
      <div class="col-sm-1">
      	<button class="btn btn-outline-primary btn-sm" type="button" onclick="enabled();">정보변경</button>
      </div>
    </div>
    <div class="form-group row">
      <label for="nickname" class="col-sm-2">Nick Name</label>
      <div class="col-sm-6">
      	<form:input type="text" class="form-control" id="nickname" path="nickname" placeholder="Enter NickName" readonly="true"/>
      	<form:errors path="nickname" class="error"/>
      </div>
      <div class="col-sm-1">
      	<button class="btn btn-outline-primary btn-sm" id="nickcheck" type="button" onclick="nickCheck();" disabled="disabled">중복확인</button>
      </div>
      <div class="col-sm-3 text-center" id="nickCheck"></div>
    </div>
    <div class="form-group row">
      <label for="email" class="col-sm-2">Email address</label>
	  <div class="col-sm-6">
	      <form:input type="text" class="form-control" id="email" path="email" readonly="true" aria-describedby="emailHelp" placeholder="Enter email"/>
	      <form:errors path="email" class="error"/>
      </div>
      <div class="col-sm-1">
      	<button type="button" id="emailcheck" class="btn btn-outline-primary btn-sm" disabled="disabled" onclick="emailCheck();">중복확인</button>
      </div>
      <div class="col-sm-3 text-center" id="emailCheck">
      </div>
    </div>
    <div class="form-group row">
    	<label for="" class="col-sm-2">Password</label>
    	<div class="col-sm-6">
    		<button type="button" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#changePwd">비밀번호 변경</button>
    	</div>
    </div>
    <div class="form-group row">
      <label for="phone" class="col-sm-2">Phone</label>
      <div class="col-sm-6">
      	<form:input type="text" class="form-control" id="phone" path="phone" placeholder="ex)010-1234-5678" readonly="true"/>
      	<small class="form-text text-muted">도서 거래 시 거래자와 직접 연락을 할 수 있습니다.</small>
      	<form:errors path="phone" class="error"/>
      </div>
    </div>
    <div class="form-group">
    	<div class="row">
    	<label for="" class="col-sm-2">Address</label>
    	<!-- <input type="text" id="sample3_postcode" class="form-control" placeholder="postcode"> -->
		<div class="col-sm-2"><input type="button" onclick="sample3_execDaumPostcode()" class="btn btn-primary btn-sm" value="우편번호" id="postCode" disabled="disabled"></div>
			<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
				<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
			</div>
			<br />
		</div>
		<div class="col-sm-10">
		<form:input type="text" id="sample3_address" path="address" class="d_form large form-control" placeholder="우편번호 버튼을 눌러 주소를 입력해주세요." readonly="true"/>
		<small class="form-text text-muted">택배 거래 시 배송지를 쉽게 입력할 수 있습니다.</small>
		</div>
    </div>
    <div class="row">
    	<div class="col-sm-12 text-center">
    		<button type="submit" class="btn btn-primary btn-sm" id="submitBtn" disabled="disabled">수정완료</button>
    	</div>
    </div>
  </fieldset>
</form:form>
	<div class="row">
		<div class="col-sm-12">
			<br />
			<hr />
			<br />
			<h3 class="text-center">내 구매목록</h3>
			<br />
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<table class="table table-hover" style="font-size:10pt;">
  <thead>
    <tr class="table-primary">
      <th scope="col" width="20%" class="text-center">구매정보</th>
      <th scope="col" width="40%" class="text-center">도서정보</th>
      <th scope="col" width="20%" class="text-center">구매상태</th>
      <th scope="col" width="20%" class="text-center">상태변경</th>
    </tr>
  </thead>
  <tbody>
  	<c:if test="${empty cartList}">
    <tr class="table-active">
      <td colspan="4">구매한 도서가 없습니다.</td>
    </tr>
    </c:if>
    <c:forEach var="cart" items="${cartList }">
    <tr class="table-default">
      <td class="text-center">
      	<button type="button" class='btn btn-secondary btn-sm' data-toggle="modal" data-target="#cartView${cart.num}">신청내역</button>
      </td>
      <td>
      	<button type="button" class="btn btn-link" data-toggle="modal" data-target="#bookView${cart.num}">${cart.book.title }</button>
      	<br />
      	판매가: ${cart.book.price} + 배송비: ${cart.book.fee } = 총 금액 ${cart.book.price + cart.book.fee }원
      </td>
      <td class="text-center">
      	<c:if test="${cart.status == 'request'}">신청중</c:if>
      	<c:if test="${cart.status == 'deal'}">거래중</c:if>
      	<c:if test="${cart.status == 'complete'}">거래완료</c:if>
      	<c:if test="${cart.status == 'cancel'}">구매취소</c:if>
      </td>
      <td class="text-center">
      	<c:if test="${cart.status == 'request' || cart.status == 'deal'}">
      	<button type="button" class='btn btn-secondary btn-sm' id="change${cart.num}" onclick="change(${cart.num}, '${cart.status}');">
      		<c:if test="${cart.status == 'request'}">구매취소</c:if>
      		<c:if test="${cart.status == 'deal'}">거래완료</c:if>
      	</button>
      	</c:if>
      </td>
    </tr>
<div class="modal" id="cartView${cart.num}">
  <div class="modal-dialog" role="dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">구매신청서</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
        	<div class="col-sm-3">닉네임</div>
        	<div class="col-sm-9">${cart.nickname}</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">수령자성명</div>
        	<div class="col-sm-9">${cart.name}</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">주소</div>
        	<div class="col-sm-9">${cart.address}</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">거래유형</div>
        	<div class="col-sm-9">
        		<c:if test="${cart.d_type == 'start'}">택배(선불)</c:if>
		      	<c:if test="${cart.d_type == 'direct'}">직거래</c:if>
		      	<c:if test="${cart.d_type == 'end'}">택배(후불)</c:if>
        	</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">요청사항</div>
        	<div class="col-sm-9">${cart.request}</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">신청일자</div>
        	<div class="col-sm-9">${cart.regdate}</div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<div class="modal" id="bookView${cart.num}">
  <div class="modal-dialog" role="dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">도서정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
        	<div class="col-sm-3">제목</div>
        	<div class="col-sm-9">${cart.book.title}</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">판매자</div>
        	<div class="col-sm-4">${cart.book.nickname}</div>
        	<div class="col-sm-5">
        		<button type="button" class="btn btn-outline-info btn-sm" onclick="getSeller('${cart.book.nickname}', ${cart.num })">Info</button>
        	</div>
        </div>
        <div class="row">
        	<div class="col-sm-3"></div>
        	<div class="col-sm-9" id="${cart.num}"></div>
        </div>
        <div class="row">
        	<div class="col-sm-3">등록일</div>
        	<div class="col-sm-9">${cart.book.regdate}</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">책상태</div>
	        <div class="col-sm-9">
				<c:if test="${cart.book.status == 'a'}">최상</c:if>
				<c:if test="${cart.book.status == 'b'}">상</c:if>
				<c:if test="${cart.book.status == 'c'}">중상</c:if>
				<c:if test="${cart.book.status == 'd'}">중</c:if>
				<c:if test="${cart.book.status == 'e'}">중하</c:if>
				<c:if test="${cart.book.status == 'f'}">하</c:if>
        	</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">저자</div>
        	<div class="col-sm-9">${cart.book.author}</div>
        </div>
        <div class="row">
        	<div class="col-sm-3">분류</div>
        	<div class="col-sm-9">${cart.book.b_category}/${cart.book.s_category }</div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
    </c:forEach>
  </tbody>
</table> 
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12 text-center">
			<div class="paging">
				<ul class="pagination pagination-sm text-center">
					${paging }
				</ul>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<br />
			<hr />
			<br />
			<h3 class="text-center">내 판매목록</h3>
			<br />
		</div>
		<div class="col-sm-12">
			<table class="table table-hover" style="font-size:10pt;">
			  <thead>
			    <tr class="table-primary">
			      <th scope="col" width="20%" class="text-center">도서명</th>
			      <th scope="col" width="40%" class="text-center">신청정보</th>
			      <th scope="col" width="20%" class="text-center">판매상태</th>
			      <th scope="col" width="20%" class="text-center">상태변경</th>
			    </tr>
			  </thead>
			  <tbody id="saleList">
			  </tbody>
			 </table>
		</div>
		<div class="row">
			<div class="col-sm-12" >
				<div class="paging text-center">
					<ul class="pagination pagination-sm text-center" id="salePaging">
						<!-- saleList 페이징 -->
					</ul>
				</div>
			</div>
		</div>
	</div>
		</div>
		<div class="col-sm-3">
		<jsp:include page="../include/right.jsp"/>
		</div>
	</div>
</div>
<!-- modal -->
<div class="modal" id="changePwd">
  <div class="modal-dialog" role="dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">비밀번호 변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="form-group row">
      <label for="password" class="col-sm-4">Password</label>
      <div class="col-sm-6">
      	 <input type="password" class="form-control" id="password" name="password" placeholder="Password"/>
      </div>
    </div>
    <div class="form-group row">
      <label for="passwordConfirm" class="col-sm-4">Password 확인</label>
      <div class="col-sm-6">
      	 <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" placeholder="Password Confirm"/>
      </div>
      <div class="col-sm-2">
      	<button type="button" class="btn btn-secondary btn-sm" onclick="updatePwd();">전송</button>
      </div>
    </div>
    <div class="form-group row">
      <label for="" class="col-sm-4">변경결과 : </label>
      <div class="col-sm-8" id="updatePwd">
      </div>
    </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../include/footer.jsp"/>
<!-- script library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script>
	
	$(function(){
		//판매목록출력
		
		var salePage = "/cart/sale/"+1;
		printPage(salePage);
		
	});
	
	function printPage(salePage){
		var str = "";
		$.getJSON(salePage, function(data){
			if(data.saleList.length == 0){
				//받아온 데이터가 없으면.
				str = "<tr class='table-secondary'><td colspan='4'>판매 요청된 도서가 없습니다.</td></tr>";
			}else{
				$(data.saleList).each(function(){
					var type ="";

					switch (this.d_type){
					case 'start' : type="택배(선불)"; break;
					case 'end' : type="택배(후불)" ;break;
					case 'direct' :type="직거래";break;
					default : type=this.d_type;
					}
					var order = "닉네임 : " + this.nickname + "<br/>" + 
								"수령자 : " + this.name + "<br/>" + 
								"주소 : " + this.address + "<br/>" +
								"거래유형 : " + type + "<br/>" + 
								"요청사항 : " + this.request + "<br/>" +
								"신청일자 : " + this.regdate;
					
					//거래상태 - 요청(request), 거래중(deal), 완료(complete), 취소(cancel)
					//select태그 생성
					var select = "<select class='custom-select' id='status" + this.num + "'>"+
								"<option value='request'" + (this.status == 'request' ? "selected" : "") +">거래요청</option>" + 
								"<option value='deal'" + (this.status == 'deal' ? "selected" : "") +">거래중</option>" +
								"<option value='cancel'" + (this.status == 'cancel' ? "selected" : "") +">거래취소</option>" +
								"</select>";
					var button = "<button type='button' class='btn btn-secondary btn-sm' onclick='accept("+ this.num +")'>변경</button>";
					var status = "";
					if(this.status == 'complete'){
						//거래 완료가 되면 거래완료 표시만 하고, select박스를 없앤다.
						status = "거래완료";
						select="";
						button="";
					}
					str += "<tr class='table-secondary text-center'>" +
						  	"<td>" + this.book.title + "</td>" + 
						  	"<td class='text-left'>" + order + "</td>" +
						  	"<td>" + status + select + "</td>" +
						  	"<td>" + button + "</td>" +
				  		  "</tr>";
				});
			}
			
			$("#saleList").html(str);
			//console.log(data.paging);
			$("#salePaging").html(data.paging);
		});
	}
	
	$("#salePaging").on("click", "li a", function(event){
		event.preventDefault();
		salePage = $(this).attr("href");
		printPage(salePage);
	});
	
	function accept(num){
		var id = "#status" + num;
		
		$.ajax({
			url:"/cart/dealAccept",
			type:"post",
			data:{num:num, status:$(id).val()},
			success:function(result){
				if(result=="success"){
					alert("정상 처리되었습니다.");
					location.href("/user/mypage");
				}else{
					alert("서버 오류입니다.");
				}
			}
		});
	}
	//판매자 정보 보기
	function getSeller(nickname, cartnum){
		$.ajax({
			url:"/cart/getSeller",
			type:"post",
			data:{nickname:nickname},
			success:function(user){
				var id= "#" + cartnum;
				if(user == null){
					$(id).text("판매자의 정보를 찾지 못했습니다.");
				}else{

					var info = "아이디: " + user.id + "<br>" +
								"전화번호: " + user.phone + "<br/>" + 
								"주소: " + user.address + "<br/>" + 
								"이메일: " + user.email + "<br/>" + 
								"<b style='font-size:9pt;color:red'>** 주소나 전화번호가 없는 판매자와는 거래하지 마세요. **</b>";
					$(id).html(info);
				}
			}
		});
	}

	//구매취소 버튼 눌렀을 시 구매상태를 취소로 바꿔준다.
	//거래중 상태에서는 구매완료로 바뀌며, 버튼을 누르면 구매상태를 거래완료로 바꿔준다.
	function change(num, status){
		if(confirm('상태를 변경하시겠습니까?')){
			$.ajax({
				url:"/cart/statusChange",
				type:"post",
				data:{num:num, status:status},
				success:function(result){
					if(result=='success'){
						alert('정상 처리되었습니다.');
						location.href="/user/mypage";
					}else{
						alert('서버 오류입니다.');
					}
				}
			});
		}
	}
	
	//원래 닉네임과 이메일 값을 변수에 저장.
	var myNick = $("#nickname").val();
	var myEmail = $("#email").val();
	//정보변경 버튼 눌렀을 시 input창과 버튼 활성화
	function enabled(){
		$("#nickname").removeAttr("readonly");
		$("#email").removeAttr("readonly");
		$("#phone").removeAttr("readonly");
		$("#sample3_address").removeAttr("readonly");
		$("#nickcheck").removeAttr("disabled");
		$("#emailcheck").removeAttr("disabled");
		$("#postCode").removeAttr("disabled");
		$("#submitBtn").removeAttr("disabled");
	}
	//닉네임 중복확인코드
	function nickCheck(){
		var nickname = $("#nickname").val();
		if(myNick == nickname){
			$("#nickCheck").text("변경하지 않은 닉네임입니다.");
			return;
		}
		$.ajax({
			url:"/user/nickCheck",
			type:"post",
			data:{nickname:nickname},
			success:function(result){
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
	//이메일 중복확인코드
	function emailCheck(){
		var email = $("#email").val();
		if(myEmail == email){
			$("#emailCheck").text("변경하지 않은 이메일입니다.");
			return;
		}
		$.ajax({
			url:"/user/emailCheck",
			type:"post",
			data:{email:email},
			success:function(result){
				if(result == 'n'){
					$("#emailCheck").text("사용가능한 이메일");
				}else if(result == 'y'){
					$("#emailCheck").text("중복되는 이메일");
				}else if(result == 'incorrect'){
					$("#emailCheck").text("형식에 맞지 않습니다.");
				}else{
					$("#emailCheck").text("잠시후 다시 시도해주세요.");
				}
			}
		});
	}
	
	//비밀번호 변경 코드
	function updatePwd(){
		var id = $("#id").val();
		var password = $("#password").val();
		var passwordConfirm = $("#passwordConfirm").val();
		$.ajax({
			url:"/user/updatePwd",
			type:"post",
			data:{id:id, password:password, passwordConfirm:passwordConfirm},
			success:function(result){
				if(result == 'incorrect'){
					$("#updatePwd").text("영문자+숫자 4자 이상 20자 이하로 비밀번호를 입력해주세요.");
				}else if(result == 'null'){
					$("#updatePwd").text("변경할 비밀번호를 입력해주세요.");
				}else if(result == 'notEqual'){
					$("#updatePwd").text("두 비밀번호가 일치하지 않습니다.");
				}else if(result == 'success'){
					$("#updatePwd").text("비밀번호 변경에 성공했습니다.");
				}else{
					$("#updatePwd").text("서버 오류입니다.");
				}
			}
		});
	}
</script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="/js/address.js"></script>
</body>
</html>