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
		<div class="col-sm-6">
			<input type="hidden" id="nick" value="${loginUser.nickname}" />		
			<p id="outNick" class="control-label bold"></p>
			접속자 수 : <label id="cnt" for=""></label>
		</div>					
	</div>
		   <br />
		   <div class="row well">
			   <span class="col-sm-6 text-center" style="font-size:20pt"><strong>동네북스 오픈채팅방</strong></span>
			   <span class="col-sm-6 text-center" style="font-size:20pt"><strong>사용자 목록</strong></span>
		   </div>	   
		   <br />
		<!-- 결과 메시지 보여주는 창 -->
		
	<div class="row">
		<div id="textbox" class="panel panel-default col-sm-7"
		 style="height:500px; padding-left:20px; overflow:auto; border: 1px solid black;"></div>
		 <div id="userBox" class="panel panel-default col-sm-3"
		 style="height:500px; padding-left:20px; overflow:auto; border: 1px solid black; margin-left:40px;"></div>
	</div>
		<br />
	<div class="row">			
		<div class="col-sm-5">
			<textarea id="message" cols="30" rows="3" class="form-control"
			placeholder="글을 입력해주세요!" onkeypress="sendMessage(event);"></textarea>
		</div>
					
		<div class="col-sm-2">	
			<button id="sendBtn" type="button" onclick="sendMessage(event)" class="btn btn-info form-control">전송</button>
		</div>
	</div>
		<br />
		 <div class="form-group">			
		    <div class="col-sm-6">
		    	<!-- <label for="" class="control-label" style="display:block;">to</label> -->
		    	<input id="to" type="hidden" class="form-control">
		    </div>			    
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
    	var ws;
    	var check = false;
    	
    	//닉네임 : 
    	console.log(typeof name);
    	$(document).ready(function(){
    		if(name == ' ' || name == null || name.length == 0){
    			var loginCheck = confirm("로그인 후 이용가능한 페이지입니다. \n로그인페이지로 이동하겠습니다.");
	    			if(loginCheck){
	    				location.href="/main";
	    			}else{
	    				alert("로그인을 하지 않을시 채팅이용이 제한됩니다.");
	    				$("#sendBtn").attr("disabled","true");
	    			}
	    			return;
    		}
    		$("#outNick").html(name+"님 환영합니다~!!");
    		//WebSocketEx는 프로젝트 이름
            //websocket 클래스 이름
             ws = new WebSocket("ws://192.168.0.56:9090/chat");
    		
           //웹 소켓이 연결되었을 때 호출되는 이벤트
             ws.onopen = function(message){
             	ws.send(JSON.stringify({from:name, to:"", msg:"님이 입장하셨습니다.",userCnt:1}));
         	   check = true;
             };
             
             //웹 소켓이 에러가 났을 때 호출되는 이벤트
             ws.onerror = function(message){
             	textbox.val(textbox.val() + "error...\n");
             };
             
           //웹 소켓이 닫혔을 때 호출되는 이벤트
               
             
             //웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
             ws.onmessage = function(message){        	   	
             	console.log(message.data);             	
             	var json = JSON.parse(message.data);
             	console.log(json.userCnt);
             	$("#cnt").html(json.userCnt);
             	$("#userBox").empty();
             	console.log(json.userList);
		        	for(var user of json.userList){
		        		var $user_div = $("<div>").addClass("row");
		            	var $user_p = $("<p>").text(user);
		            	
		            	if(check){
		            		$user_div.append($user_p);
		            	}else{
		            		$user_p.text("");
		            		$user_div.append($user_p);
		            	}		            	
		            	$("#userBox").append($user_div);
		        	}
             	
             	var $item = $("<div>").addClass("row");
             	var $entity = $("<p class='col-sm-12'>");
             	if(json.msg.indexOf("입장하셨습니다.") != -1){
             		$entity.text(json.from+json.msg);      
             	}else if(json.msg.indexOf("퇴장하셨습니다.") != -1){
             		$entity.text(json.from+json.msg);           		
             	}else{
                 	$entity.text(json.from+" : "+json.msg);
                 	if(json.from == name){            		
             			$entity.css("text-align","right");
             		}
             	}        	
             	$item.html($entity);
             	textbox.append($item);
             	$("#textbox").scrollTop($("#textbox")[0].scrollHeight);
             };
    	});
    	
        //Websocket클래스에서 바인딩주소를 ws로 해서 가능
        var textbox = $("#textbox");
        
        
        //Send 버튼을 누르면 실행되는 함수
        function sendMessage(event){
            //웹소켓으로 textMessage객체의 값을 보낸다.
            if(event.type == "click" || event.type == "keypress" && event.key =="Enter"){
            	ws.send(JSON.stringify({from:name, to:$("#to").val(), msg:$("#message").val(),userCnt:0}));
            	event.preventDefault();
                $("#message").val('');	
            }            
        }
         window.onbeforeunload = function(){
            ws.send(JSON.stringify({from:name, to:"", msg:"님이 퇴장하셨습니다.",userCnt:-1}));
            check = false;
            ws.onclose = function(message){
            		
               };
        } 
       
    </script>
</body>
</html>