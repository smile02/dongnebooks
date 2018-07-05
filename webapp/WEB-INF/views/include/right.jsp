<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="height: 100%;">
<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
  <div class="card-header">Sign In</div>
  <div class="card-body">
  <c:if test="${sessionScope.user == null }">
    <form action="/user/signin" method="post" class="form form-horizontal">
	    <div class="form-group">
		   <label for="u_id" class="control-label">ID</label>
		   <input type="text" class="form-control form-control-sm" id="u_id" placeholder="Enter ID" name="id">
		</div>
		<div class="form-group">
		   <label for="u_password" class="control-label">Password</label>
		   <input type="password" class="form-control form-control-sm" id="u_password" placeholder="Password" name="password">
		</div>
		<div class="text-center">
		    <button type="button" class="btn btn-secondary btn-sm" onclick="login();">Sign in</button>
		    <button type="button" class="btn btn-secondary btn-sm" onclick="location.href='/user/signup'">Sign up</button>
		</div>
	</form>
  </c:if>
  <c:if test="${sessionScope.user != null}">
  	<div class="text-center">
  		${sessionScope.user.nickname}님<br />
  		환영합니다.
  		<br />
  		<br />
  		<button type="button" class="btn btn-secondary btn-sm">MyPage</button>
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
		$.ajax({
			url:"/user/signin",
			type:"post",
			data:{id:id, password:password},
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
</script>