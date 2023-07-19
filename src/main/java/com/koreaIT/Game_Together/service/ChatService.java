package com.koreaIT.Game_Together.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.ChatRepository;
import com.koreaIT.Game_Together.vo.Chat.MessageType;
import com.koreaIT.Game_Together.vo.ChatRoom;
import com.koreaIT.Game_Together.vo.Member;

@Service
public class ChatService {
	
	private ChatRepository chatRepository;
	
	@Autowired
	public ChatService(ChatRepository chatRepository) {
		this.chatRepository = chatRepository;
	}
	
	//	전체 채팅방 조회
	public List<ChatRoom> getChatRooms() {
		return chatRepository.getChatRooms();
	}
	
	//	채팅방 만들기(chatRoom 테이블에 채팅방 저장)
	public void createChatRoom(int loginedMemberId, String name, int maxMemberCount) {
		chatRepository.createChatRoom(loginedMemberId, name, maxMemberCount);
	}

	public int getLastInsertId() {
		return chatRepository.getLastInsertId();
	}
	
	//	채팅방 입장(chatRoomMember 테이블에 입장한 멤버 저장)
	public void joinChatRoom(int chatRoomId, int loginedMemberId) {
		chatRepository.joinChatRoom(chatRoomId, loginedMemberId);
	}
	
	//	채팅방 찾기(chatRoom 테이블에서 id로 채팅방 가져오기)
	public ChatRoom getChatRoomById(int chatRoomId) {
		return chatRepository.getChatRoomById(chatRoomId);
	}
	
	//	채팅 저장(chat 테이블에 채팅 저장)
	public void saveChat(LocalDateTime regDate, int chatRoomId, int memberId, String message, MessageType messageType) {
		chatRepository.saveChat(regDate, chatRoomId, memberId, message, messageType);
	}
	
	//	채팅방에 입장한 멤버 리스트 가져오기
	public List<Member> getMemberList(int chatRoomId) {
		return chatRepository.getMemberList(chatRoomId);
	}
	
	//	채팅방 퇴장(chatRoomMember 테이블에서 퇴장한 멤버 삭제)
	public void exitChatRoom(int chatRoomId, int memberId) {
		chatRepository.exitChatRoom(chatRoomId, memberId);
	}
	
	//	채팅방 삭제(chatRoom 테이블에서 채팅방 삭제)
	public void deleteChatRoom(int chatRoomId) {
		chatRepository.deleteChatRoom(chatRoomId);
	}
	
	//	채팅 삭제(chat 테이블에서 채팅 삭제)
	public void deleteChat(int chatRoomId) {
		chatRepository.deleteChat(chatRoomId);
	}

}