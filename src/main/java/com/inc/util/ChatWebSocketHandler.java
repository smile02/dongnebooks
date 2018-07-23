package com.inc.util;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.DecodeException;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.inc.domain.Message;

public class ChatWebSocketHandler extends TextWebSocketHandler{
	
	private Map<String, WebSocketSession> users = new ConcurrentHashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log(session.getId()+"연결 됨");
		users.put(session.getId(), session); //session.getid()는 사용자의 세션ID
		System.out.println("들어온 유저 수 :"+users.size());
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log(session.getId() + "종료 됨");
		users.remove(session.getId());
		System.out.println("나간 유저 수 :"+users.size());
	}
	
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		log(session.getId()+"로 부터 메세지 수신 : "+message.getPayload());
		
		for(WebSocketSession s: users.values() ) {
			s.sendMessage(message);
			log(s.getId()+"에 메세지 발송"+message.getPayload());
		}
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId()+" 익셉션 발생 : "+exception.getMessage());
	}
	
	private void log(String logmsg) {
		System.out.println(new Date()+" : "+logmsg);
	}
}
