package com.koreaIT.Game_Together.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.ChatRepository;
import com.koreaIT.Game_Together.vo.Chat.MessageType;
import com.koreaIT.Game_Together.vo.ChatRoom;

@Service
public class ChatService {
	
	private ChatRepository chatRepository;
	
	@Autowired
	public ChatService(ChatRepository chatRepository) {
		this.chatRepository = chatRepository;
	}

	public List<ChatRoom> getChatRooms() {
		return chatRepository.getChatRooms();
	}

	public void createChatRoom(int loginedMemberId, String name, int maxMemberCount) {
		chatRepository.createChatRoom(loginedMemberId, name, maxMemberCount);
	}

	public int getLastInsertId() {
		return chatRepository.getLastInsertId();
	}

	public void joinChatRoom(int chatRoomId, int loginedMemberId) {
		chatRepository.joinChatRoom(chatRoomId, loginedMemberId);
	}

	public ChatRoom getChatRoomById(int chatRoomId) {
		return chatRepository.getChatRoomById(chatRoomId);
	}

	public void saveChat(LocalDateTime regDate, int chatRoomId, int memberId, String message, MessageType messageType) {
		chatRepository.saveChat(regDate, chatRoomId, memberId, message, messageType);
	}

}