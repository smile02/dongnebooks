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
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container">
	<div class="row">
		<form class="form-control form-horizontal">
				<div class="col-sm-6">
					<label for="" class="control-label">닉네임 : </label>
					<label id="nick" for="" class="control-label">${loginUser.nickname } </label>
				</div>					
				
			    <br />
				<!-- 결과 메시지 보여주는 창 -->
				<div class="col-sm-7">
					<textarea id="textbox" rows="20" cols="50" class="form-control" readonly="readonly"></textarea>
				</div>
				<div class="form-group">
					<div class="col-sm-5">
						<input id="message" type="text" class="form-control" placeholder="글을 입력해주세요!" style="display:inline">												
					</div>
					<div class="col-sm-2">
						<button type="button" onclick="sendMessage()" class="btn btn-info form-control" style="display:inline">전송</button>
					</div>
				</div>
				<div class="form-group">			
				    <div class="col-sm-6">
				    	<label for="" class="control-label" style="display:block;">to</label>
				    	<input id="to" type="text" class="form-control">
				    </div>			    
				</div>		
	    </form>    
	    </div>
  </div>
   <jsp:include page="../include/footer.jsp" />

<!--스크립트 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script>
    	var name = $("#nick").val();
	
        //WebSocketEx는 프로젝트 이름
        //websocket 클래스 이름
        var ws;
        //Websocket클래스에서 바인딩주소를 ws로 해서 가능
        var textbox = $("#textbox");
        
      	//웹 소켓이 연결되었을 때 호출되는 이벤트
        function onOpen(){
			var nickname = $("#nick").html();
        	textbox.val(textbox.val() + nickname+"님이 입장하셨습니다.\n");
        }
      
        //웹 소켓이 닫혔을 때 호출되는 이벤트      
      	function onClose(){
      		var nickname = $("#nick").html();
      		textbox.val(textbox.val() + name+"님이 퇴장하셨습니다.\n");
      		disconnect();
      	}
        
        /* //웹 소켓이 에러가 났을 때 호출되는 이벤트
        ws.onerror = function(message){
        	textbox.val(textbox.val() + "error...\n");
        }; */

        //웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
        function onMessage(message){
        	console.log(message.data);
        	var json = JSON.parse(message.data);
        	if(json.to.length == 0 || json.to == name){
        		textbox.val(textbox.val() + json.from+" : "+json.msg+"\n");
        	}
        }
       
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
        $(document).ready(function(){
        	if(name == '' || name == null){
    			var check = confirm("로그인 후 이용가능합니다.\n로그인페이지로 이동하시겠습니까?");
    			if(check){
    				location.href="/main";
    			}
    			return;
    		}
        	
        	ws  = new WebSocket("ws://localhost:9090/chat");
    		ws.onopen=onOpen;
    		ws.onmessage=onMessage;
    		ws.onclose = onClose;
    		
    		 $("#message").keypress(function(event){
    			var keycode = (event.keyCode == 13 ? event.keyCode : event.which);    		
    			if(event.keyCode == 13){
    				sendMessage();
    			}
    			event.stopPropagation();
    		});
    	});
    </script>
</body>
</html>