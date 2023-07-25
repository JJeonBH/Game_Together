package com.koreaIT.Game_Together.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.Chat.MessageType;
import com.koreaIT.Game_Together.vo.ChatRoom;
import com.koreaIT.Game_Together.vo.Member;

@Mapper
public interface ChatRepository {
	
	public List<ChatRoom> getChatRooms();

	public void createChatRoom(int loginedMemberId, String name, int maxMemberCount, String status, String password);

	public int getLastInsertId();

	public void joinChatRoom(int chatRoomId, int loginedMemberId);

	public ChatRoom getChatRoomById(int chatRoomId);

	public void saveChat(LocalDateTime regDate, int chatRoomId, int memberId, String message, MessageType messageType);

	public List<Member> getMemberList(int chatRoomId);

	public void exitChatRoom(int chatRoomId, int memberId);

	public void deleteChatRoom(int chatRoomId);

	public void deleteChat(int chatRoomId);

}