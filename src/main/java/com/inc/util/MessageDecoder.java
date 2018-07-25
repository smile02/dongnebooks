package com.inc.util;

import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.inc.domain.Message;

public class MessageDecoder implements Decoder.Text<Message> {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void init(EndpointConfig ec) {

	}
	//ws.html에서 보내준 키값에 대한 값들을 받는 메서드
	public Message decode(String jsonMessage) throws DecodeException {
		JSONParser parser = new JSONParser();
		JSONObject jsonObject;
		Message message = null; //to, from, message를 담는 Vo객체
		try {
			jsonObject = (JSONObject) parser.parse(jsonMessage);
			message = new Message();
			message.setFrom((String)jsonObject.get("from"));
			message.setTo((String)jsonObject.get("to"));
			message.setMsg((String)jsonObject.get("msg"));
		} catch (ParseException e) {
			e.printStackTrace();
			throw new DecodeException(jsonMessage,e.getMessage());
			
		}
		return message;

	}

	@Override
	public boolean willDecode(String jsonMessage) {
		//들어온 문자열이 디코딩 가능한지 아닌지 판단(JSON)으로 변환이 가능한지
		try {
			// Check if incoming message is valid JSON
			JSONParser parser = new JSONParser();
			parser.parse(jsonMessage);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
