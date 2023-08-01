package com.koreaIT.Game_Together.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.ChatRepository;
import com.koreaIT.Game_Together.vo.Chat.MessageType;
import com.koreaIT.Game_Together.vo.ChatRoom;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.ResultData;

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
	public void createChatRoom(int loginedMemberId, String name, int maxMemberCount, String status, String password) {
		chatRepository.createChatRoom(loginedMemberId, name, maxMemberCount, status, password);
	}

	public int getLastInsertId() {
		return chatRepository.getLastInsertId();
	}
	
	//	채팅방 입장(chatRoomMember 테이블에 입장한 멤버 저장)
	public void joinChatRoom(int chatRoomId, int loginedMemberId, String sessionId) {
		chatRepository.joinChatRoom(chatRoomId, loginedMemberId, sessionId);
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
	
	//	비공개 채팅방 입장 시 입력한 비밀번호가 일치하는지 체크
	@SuppressWarnings("rawtypes")
	public ResultData passwordCheck(int chatRoomId, String password) {
		
		ChatRoom chatRoom = chatRepository.getChatRoomById(chatRoomId);
		
		if (chatRoom.getId() == 0) {
			return ResultData.resultFrom("F-1", "채팅방이 존재하지 않습니다.");
		} else if (!chatRoom.getPassword().equals(password)) {
			return ResultData.resultFrom("F-2", "비밀번호가 일치하지 않습니다.");
		} else {
			return ResultData.resultFrom("S-1", "비밀번호 일치");
		}
		
	}
	
	//	채팅방 입장 시 이미 다른 채팅방에 입장해 있는지, 인원수 꽉 차 있는지 체크
	@SuppressWarnings("rawtypes")
	public ResultData canJoin(int chatRoomId, int memberId) {
		
		int count = chatRepository.alreadyJoinCheck(memberId);
		
		if (count == 1) {
			return ResultData.resultFrom("F-1", "이미 다른 채팅방에 입장 중입니다.");
		}
		
		ChatRoom chatRoom = chatRepository.getChatRoomById(chatRoomId);
		
		if (chatRoom.getMaxMemberCount() == chatRoom.getCurrentMemberCount()) {
			return ResultData.resultFrom("F-2", "채팅방 정원 초과로 채팅방에 입장할 수 없습니다.");
		}
		
		return ResultData.resultFrom("S-1", "입장 가능");
		
	}
	
	//	채팅방 생성 버튼 누를 때 이미 채팅방을 생성 했는지, 다른 채팅방에 입장해 있는지 체크
	@SuppressWarnings("rawtypes")
	public ResultData canCreate(int memberId) {
		
		int count = chatRepository.alreadyCreateCheck(memberId);
		
		if (count == 1) {
			return ResultData.resultFrom("F-1", "이미 다른 채팅방을 생성했습니다.");
		}
		
		count = chatRepository.alreadyJoinCheck(memberId);
		
		if (count == 1) {
			return ResultData.resultFrom("F-2", "이미 다른 채팅방에 입장 중입니다.");
		}
		
		return ResultData.resultFrom("S-1", "생성 가능");
		
	}
	
	//	퇴장한 멤버가 방장일 때 입장해 있는 멤버 중 가장 빨리 들어온 멤버가 자동으로 방장이 되게 함
	public void modifyChatRoom(int chatRoomId) {
		
		List<Member> members = chatRepository.getMemberList(chatRoomId);
		
		Member member = members.get(0);
		
		chatRepository.modifyChatRoom(chatRoomId, member.getId());
		
	}

}