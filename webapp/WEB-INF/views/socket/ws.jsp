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
	<form>
		<label for="">to</label>
		<input id="to" type="text">
		<br />
        <input id="message" type="text">
        <input onclick="sendMessage()" value="Send" type="button">
        <input onclick="disconnect()" value="Disconnect" type="button">
    </form>
    <br />
    <!-- 결과 메시지 보여주는 창 -->
    <textarea id="textbox" rows="10" cols="50"></textarea>

<!--스크립트 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
    	var name = "";
    	console.log(name.length);
		while(name.length == 0){
			name = prompt("이름을 입력해 주세요!");
		}
		
        //WebSocketEx는 프로젝트 이름
        //websocket 클래스 이름
        var ws = new WebSocket("ws://localhost:9090/ws");
        //Websocket클래스에서 바인딩주소를 ws로 해서 가능
        var textbox = $("#textbox");
        
        //웹 소켓이 연결되었을 때 호출되는 이벤트
        ws.onopen = function(message){
        	textbox.val(textbox.val() + "Server Connect...\n");
        };
        //웹 소켓이 닫혔을 때 호출되는 이벤트
        ws.onclose = function(message){
        	textbox.val(textbox.val() + "Server Disconnect...\n");
        };
        //웹 소켓이 에러가 났을 때 호출되는 이벤트
        ws.onerror = function(message){
        	textbox.val(textbox.val() + "error...\n");
        };
        //웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
        ws.onmessage = function(message){
        	console.log(message.data);
        	var json = JSON.parse(message.data);
        	if(json.to.length == 0 || json.to == name){
        		textbox.val(textbox.val() + json.from+" : "+json.msg+"\n");
        	}
        };
        //Send 버튼을 누르면 실행되는 함수
        function sendMessage(){
            //웹소켓으로 textMessage객체의 값을 보낸다.
            ws.send(JSON.stringify({from:name, to:$("#to").val(), msg:$("#message").val()}));
            $("#message").val('');
        }
        //웹소켓 종료
        function disconnect(){
            ws.close();
        }
    </script>
</body>
</html>