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

	public Message decode(String jsonMessage) throws DecodeException {
		JSONParser parser = new JSONParser();
		JSONObject jsonObject;
		Message message = null;
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
