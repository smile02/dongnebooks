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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	<input type="text" id="message" />
	<button type="button" id="sendBtn">전송</button>

<!--스크립트 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function(){
		$("#sendBtn").click(function(){sendMessage();});
	});
	
	var wsocket;
	function sendMessage(){
		wsocket = new WebSocket("ws://localhost:9090/test");
		wsocket.onmessage = onMessage;
		wsocket.onclose = onClose;
		wsocket.onopen = function(){
			wsocket.send($("#message").val());
		}
	}
	
	function onMessage(event){
		var data = event.data;
		alert("서버에서 데이터 받음 : "+data);
		wsocket.close();
	}
	
	function onClose(event){
		alert("연결 끊김");
	}
</script>
</body>
</html>