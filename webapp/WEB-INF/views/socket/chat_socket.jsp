<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.1.1/minty/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4eGtnTOp6je5m6l1Zcp2WUGR9Y7kJZuAiD3Pk2GAW3uNRgHQSIqcrcAxBipzlbWP"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css" />
<style>
#chatArea{
	width:200px; height:100px; overflow-y:auto; border: 1px solid black;
}
#message{
	width:45%;
}
</style>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<form action="" class="form-control" onsubmit="return false">
		작성자 : <p id="nickname" style="display:inline;">${loginUser.nickname }</p>		
			<h1>의사소통 공간</h1>
		<textarea id="chatMessageArea" cols="100" rows="20" readonly="readonly"></textarea>
		<br />
		<input type="text" id="message"/>
		<button type="button" id="sendBtn">전송</button>
	</form>
	
	<jsp:include page="../include/footer.jsp" />
<!--스크립트 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
	var wsocket;
	var chatArea = $("#chatMessageArea");
	var nick = $("#nickname").html();
		
	 function onOpen(event){
		wsocket.send(nick+"님이 입장하셨습니다.");		
	} 
	
	function onMessage(event){
		var data = event.data;
		console.log(data);
		if(data.substring(0,4) == "msg:"){
			appendMessage(data.substring(4));
		}else{
			appendMessage(data);
		}
	}
	
	function onClose(event){
		wsocket.send(nick+"님이 퇴장하셨습니다.");
	}
	
	function send(){
		var nickname = nick;
		console.log(":"+nickname);
		var msg = $("#message").val();
		console.log("msg:"+nickname+":"+msg);
		wsocket.send("msg:"+nickname+":"+msg);
		$("#message").val("");
	}
	
	function appendMessage(msg){
		chatArea.val(chatArea.val()+msg+"\n");
	}
	
	$(window).on("beforeunload", function(){
		wsocket.close();
	})
	
	$(document).ready(function(){
		console.log("nick :"+nick);
		
		if(nick == '' || nick == null){
			var check = confirm("로그인 후 이용가능합니다.\n로그인페이지로 이동하시겠습니까?");
			if(check){
				location.href="/main";
			}
			return;
		}
		wsocket = new WebSocket("ws://192.168.0.23:9090/chat");
		wsocket.onopen=onOpen;
		wsocket.onmessage=onMessage;
		wsocket.onclose = onClose;
		
		 $("#message").keypress(function(event){
			var keycode = (event.keyCode == 13 ? event.keyCode : event.which);
			console.log(typeof keycode);
			console.log("key : "+keycode);
			console.log("event.which : "+event.which);
			if(event.keyCode == 13){
				send();
			}
			event.stopPropagation();
		});	 
		
		$("#sendBtn").click(function(){send();});		
	});
	
</script>

</body>
</html>