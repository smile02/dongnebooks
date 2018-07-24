package com.inc.util;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.inc.domain.Message;

@ServerEndpoint(value="/chat", encoders=MessageEncoder.class, decoders=MessageDecoder.class)
public class WebSocket {
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	@OnOpen
	public void handleOpen(Session session){
		System.out.println("New client is connected...");
		clients.add(session);
	}
	
	@OnMessage
	public void handleMessage(Message message, Session session) throws EncodeException, IOException{
		System.out.println("to:"+message.getTo());
		synchronized (clients) {
			for(Session client : clients) {
				//client.getBasicRemote().sendText(message);
				client.getBasicRemote().sendObject(message);
			}
		}
	}
	
	@OnClose
    public void handleClose(Session session){
        System.out.println("client is now disconnected...");
        clients.remove(session);
    }

	@OnError
    public void handleError(Throwable t){
        t.printStackTrace();
    }

}

