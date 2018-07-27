package com.inc.util;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import org.json.simple.JSONObject;

import com.inc.domain.Message;

public class MessageEncoder implements Encoder.Text<Message> {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init(EndpointConfig ec) {
		
	}

	@Override
	public String encode(Message message) throws EncodeException {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("from", message.getFrom());
		jsonObject.put("to", message.getTo());
		jsonObject.put("msg", message.getMsg());
		jsonObject.put("userCnt", message.getUserCnt());
		jsonObject.put("userList", message.getUserList());
		return jsonObject.toJSONString();
	}
	
}
