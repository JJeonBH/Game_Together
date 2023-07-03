package com.koreaIT.Game_Together.service;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Service;

@Service
@ServerEndpoint(value="/chat")
public class WebSocketChatService {
	
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void onOpen(Session s) {
		if(!clients.contains(s)) {
			clients.add(s);
		}
	}
	
	@OnMessage
	public void onMessage(String msg, Session session) throws Exception {
		for(Session s : clients) {
			s.getBasicRemote().sendText(msg);
		}
	}
	
	@OnClose
	public void onClose(Session s) {
		clients.remove(s);
	}
	
}