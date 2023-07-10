package com.koreaIT.Game_Together.vo;

import java.util.HashMap;
import java.util.UUID;

import lombok.Data;

@Data
public class ChatRoom {

	private String roomId; //  채팅방 아이디
    private String roomName; //  채팅방 이름
    private long memberCount; //  채팅방 인원수
    private HashMap<String, String> memberList = new HashMap<String, String>();

    public ChatRoom createChatRoom(String roomName) {
    	
        ChatRoom chatRoom = new ChatRoom();
        chatRoom.roomId = UUID.randomUUID().toString();
        chatRoom.roomName = roomName;

        return chatRoom;
        
    }
	
}