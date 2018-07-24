<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>동네북스 오픈채팅방</title>
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
					<p id="nick" class="control-label">닉네임 : ${loginUser.nickname }</p>
				</div>					
				
			    <br />
			    <h2 class="text-muted text-center">의사소통 공간</h2>
				<!-- 결과 메시지 보여주는 창 -->
				<div class="form-group">
					<div class="col-sm-6 col-sm-offset-3">
						<div id="textbox" class="panel panel-default"
						 style="width:600px; height:400px; padding:30px; overflow:auto; border: 1px solid black"></div>
					 </div>
				</div>
				<div class="form-group">
					<div class="col-sm-5">
						<input id="message" type="text" class="form-control" placeholder="글을 입력해주세요!" style="display:inline"
							onkeypress="sendMessage(event);">												
					</div>
					<div class="col-sm-2">
						<button type="button" onclick="sendMessage(event)" class="btn btn-info form-control" style="display:inline">전송</button>
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
    	var nick = $("#nick").html();
    	console.log("name : "+nick);
    	//닉네임 : 
    	var name = nick.substring(6,nick.length);
    	$(document).ready(function(){
    		if(name == '' || name == null){
    			console.log("들어오나");
    			var loginCheck = confirm("로그인 후 이용가능한 페이지입니다. \n로그인페이지로 이동하겠습니다.");
	    			if(loginCheck){
	    				location.href="/main";
	    			}else{
	    				alert("로그인을 하지 않을시 채팅이용이 제한됩니다.");	    				
	    			}
	    			return;
    		}
    	});
    	//WebSocketEx는 프로젝트 이름
        //websocket 클래스 이름
        var ws = new WebSocket("ws://localhost:9090/chat");
        //Websocket클래스에서 바인딩주소를 ws로 해서 가능
        var textbox = $("#textbox");
        
        //웹 소켓이 연결되었을 때 호출되는 이벤트
        ws.onopen = function(message){
        	ws.send(JSON.stringify({from:name, to:"", msg:"님이 입장하셨습니다."}));
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
        	var $div = $("<div>").addClass("row");
        	var $p = $("<p>").text('');
        	if(json.msg.indexOf("입장하셨습니다.") != -1){
        		$p.text(json.from+json.msg); 		
        	}else if(json.to.length == 0 || json.to == name){ //사용자가 to에 아무것도 입력하지 않았을 때
        		console.log("json.from : "+json.from);
        		console.log("name : "+name);
        		$p.text(json.from+" : "+json.msg);
            	if(json.from == name){            		
        			$p.css("text-align","right");
        		}
        	}
        	$div.append($p);
        	textbox.append($div);
        	$("#textbox").scrollTop($("#textbox")[0].scrollHeight);
        };
        //Send 버튼을 누르면 실행되는 함수
        function sendMessage(event){
            //웹소켓으로 textMessage객체의 값을 보낸다.
            if(event.type == "click" || event.type == "keypress" && event.key =="Enter"){
            	ws.send(JSON.stringify({from:name, to:$("#to").val(), msg:$("#message").val()}));
                $("#message").val('');	
            }            
        }
        //웹소켓 종료
        function disconnect(){
            ws.close();
        }
    	
        
    </script>
</body>
</html>