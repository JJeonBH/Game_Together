package com.koreaIT.Game_Together.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.Chat.MessageType;
import com.koreaIT.Game_Together.vo.ChatRoom;
import com.koreaIT.Game_Together.vo.Member;

@Mapper
public interface ChatRepository {
	
	public List<ChatRoom> getChatRooms(String searchKeywordType, String searchKeyword, int itemsInAPage, int limitStart);

	public void createChatRoom(int loginedMemberId, String name, int maxMemberCount, String status, String password);

	public int getLastInsertId();

	public void joinChatRoom(int chatRoomId, int loginedMemberId, String sessionId);

	public ChatRoom getChatRoomById(int chatRoomId);

	public void saveChat(LocalDateTime regDate, int chatRoomId, int memberId, String message, int recipientId, int banMemberId, MessageType messageType);

	public List<Member> getMemberList(int chatRoomId);

	public void exitChatRoom(int chatRoomId, int memberId);

	public void deleteChatRoom(int chatRoomId);

	public void deleteChat(int chatRoomId);

	public int alreadyJoinCheck(int memberId);

	public int alreadyCreateCheck(int memberId);

	public void modifyChatRoom(int chatRoomId, int memberId);

	public Member getMemberBySessionId(String sessionId);

	public Member getMember(int chatRoomId, String nickname);

	public int banCheck(int chatRoomId, int memberId);

	public void changeHost(int chatRoomId, int changeHostId);

	public int getChatRoomsCnt(String searchKeywordType, String searchKeyword);

}