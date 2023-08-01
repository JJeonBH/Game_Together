package com.koreaIT.Game_Together.sessionmanager;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

@Component
public class WebSocketSessionManager {
	
	//	WebSocket 세션을 저장하기 위한 Map
	private final Map<String, WebSocketSession> sessions = new ConcurrentHashMap<>();
	
	//	WebSocket 세션을 추가하는 메서드
    public void addSession(String sessionId, WebSocketSession session) {
        sessions.put(sessionId, session);
    }

    //	WebSocket 세션을 제거하는 메서드
    public void removeSession(String sessionId) {
        sessions.remove(sessionId);
    }
    
	//	sessionId에 해당하는 WebSocket 세션을 반환하는 메서드
	public WebSocketSession getSession(String sessionId) {
	    return sessions.get(sessionId);
	}
	
	//	현재 저장된 WebSocket 세션들의 수를 반환하는 메서드
    public int getSessionCount() {
        return sessions.size();
    }
    
    //	모든 WebSocket 세션을 반환하는 메서드
    public Map<String, WebSocketSession> getAllSessions() {
        return sessions;
    }
	
}