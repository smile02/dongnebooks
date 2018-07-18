<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="height: 100%;">
<div class="card border-primary mb-3" style="max-width: 20rem;">
  <div class="card-header">Sign In</div>
  <div class="card-body">
  <c:if test="${sessionScope.user == null }">
  
    <form action="/user/signin" method="post" class="form">
	    <div class="form-group">
		   <label for="u_id" class="control-label">ID </label>
		   <input type="text" class="form-control form-control-sm" id="u_id" placeholder="Enter ID" name="id" value="${id}">
		</div>
		<div class="form-group">
		   <label for="u_password" class="control-label">Password</label>
		   <input type="password" class="form-control form-control-sm" id="u_password" placeholder="Password" name="password">
		</div>
		<div class="form-group text-center">
			<label><input type="checkbox" id="useCookie"/>Remember ID</label>
		</div>
		<div class="text-center">
		    <button type="button" class="btn btn-primary btn-sm" onclick="login();">Sign in</button>
		    <button type="button" class="btn btn-primary btn-sm" onclick="location.href='/user/signup'">Sign up</button>
		</div>
		<div class="text-center" style="padding-top: 5px;">
		    <button type="button" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#modalPopup">Id/Pwd find</button>
		</div>
	</form>
<div class="modal" id="modalPopup">
  <div class="modal-dialog" role="dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ID/비밀번호 찾기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="form-group">
        	<div class="row">
        		<div class="col-sm-12"><label for="myEmail" class="control-label">ID 찾기: 등록된 이메일을 입력해주세요.</label></div>
        	</div>
		   <div class="row">
		   		<div class="col-sm-6">
		   			<input type="text" class="form-control form-control-sm" id="myEmail" placeholder="Enter Email">
		   		</div>
		   		<div class="col-sm-3">
		   			<button type="button" class="btn btn-primary btn-sm" onclick="findId();">Find</button>
		   		</div>
		   </div>
		   <div class="row">
		   		<div class="col-sm-12" id="findID"></div>
		   </div>
		</div>
		<div class="form-group">
        	<div class="row">
        		<div class="col-sm-12">비밀번호 찾기: 등록된 ID와 이메일을 입력해주세요.</div>
        	</div>
		   <div class="row">
		   		<div class="col-sm-8">
		   			<div class="row">
						<div class="col-sm-4">
							<label for="f_id" class="control-label">ID</label>
						</div>
						<div class="col-sm-8">
							<input type="text" class="form-control form-control-sm" id="f_id" placeholder="Enter ID">
						</div>
		   			</div>
		   		</div>
		   </div>
		   <div class="row">
		   		<div class="col-sm-8">
		   			<div class="row">
						<div class="col-sm-4">
							<label for="f_email" class="control-label">Email</label>
						</div>
						<div class="col-sm-8">
							<input type="text" class="form-control form-control-sm" id="f_email" placeholder="Enter Email">
						</div>
		   			</div>
		   		</div>
		   		<div class="col-sm-2">
		   			<button type="button" class="btn btn-primary btn-sm" onclick="sendCode(this);">인증요청</button>
		   		</div>
		   		<div class="col-sm-1"><div id="f_loader"></div></div>
		   </div>
		   <div class="row">
		   		<div class="col-sm-8">
		   			<div class="row">
						<div class="col-sm-4">
							<label for="f_code" class="control-label">인증번호</label>
						</div>
						<div class="col-sm-8">
							<input type="text" class="form-control form-control-sm" id="f_code" placeholder="Enter Code">
						</div>
		   			</div>
		   		</div>
		   		<div class="col-sm-4">
		   			<button type="button" class="btn btn-primary btn-sm" onclick="findPwd();">비번찾기</button>
		   		</div>
		   </div>
		   <div class="row">
		   		<div class="col-sm-12" id="tempPwd" style="font-size:9pt;">
		   		</div>
		   </div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
  </c:if>
  <c:if test="${sessionScope.user != null}">
  	<div class="text-center">
  		${sessionScope.user.nickname}님<br />
  		환영합니다.
  		<br />
  		<br />
  		<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='/user/mypage'">MyPage</button>
  		<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='/user/signout'">Sign Out</button>
  	</div>
  </c:if>
  </div>
</div>
</div>
<script>
	function login(){
		var id = $("#u_id").val();
		var password = $("#u_password").val();
		var useCookie = null;
		if($("#useCookie").is(":checked")){
			useCookie = "SaveCookie";
		}
		console.log(useCookie);
		$.ajax({
			url:"/user/signin",
			type:"post",
			data:{id:id, password:password, useCookie:useCookie},
			success:function(result){
				if(result == "null"){
					alert('존재하지 않는 아이디입니다.');
				}else if(result == "pass"){
					alert('비밀번호가 틀렸습니다.');
				}else if(result == "success"){
					alert('로그인 되었습니다.');
					location.href="/main";
				}
			}
		});
	}
	
	function findId(){
		var email = $("#myEmail").val();
		$.ajax({
			url:"/user/findId",
			type:"post",
			data:{email:email},
			success:function(result){
				if(result == 'null'){
					$("#findID").text("이메일을 입력해주세요");
				}else if(result == 'incorrect'){
					$("#findID").text("형식에 맞지 않는 메일주소입니다.");
				}else if(result == 'notfound'){
					$("#findID").text("검색결과 일치하는 아이디가 없습니다.");
				}else{
					$("#findID").text("검색된 ID: " + result);
				}
				
			}
		});
	}
	
	function sendCode(button){
		var id = $("#f_id").val();
		var email = $("#f_email").val();
		$("#f_loader").addClass("loader"); //회원가입 창의 loader와 겹칠 수 있으므로 id다르게 설정.
		$(button).attr("disabled", "disabled");
		$.ajax({
			url:"/user/sendCode",
			type:"post",
			data:{id:id, email:email},
			success:function(result){
				$(button).removeAttr("disabled");
				$("#f_loader").removeClass("loader");
				if(result == 'success'){
					alert("메일 발송완료");
				}else if(result == 'notfound'){
					alert("일치하는 정보를 찾지 못했습니다.");
				}else if(result == 'error'){
					alert('서버 오류입니다.');
				}else if(result == 'null'){
					alert('아이디와 이메일을 입력해 주세요.');
				}
			}
		});
	}
	
	function findPwd(){
		var code = $("#f_code").val();
		$.ajax({
			url:"/user/findPwd",
			type:"post",
			data:{code:code},
			success:function(result){
				if(result == 'fail'){
					$("#tempPwd").text("인증실패, 코드를 다시 확인해주세요.");
				}else if(result == 'error'){
					$("#tempPwd").text("서버에서 오류가 발생했습니다.");
				}else{
					$("#tempPwd").text("임시비밀번호 :" + result + "입니다. 로그인 후 비밀번호를 변경하세요.");
				}
			}
		});
	}
</script>