package com.koreaIT.Game_Together.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.Chat.MessageType;
import com.koreaIT.Game_Together.vo.ChatRoom;

@Mapper
public interface ChatRepository {
	
	public List<ChatRoom> getChatRooms();

	public void createChatRoom(int loginedMemberId, String name, int maxMemberCount);

	public int getLastInsertId();

	public void joinChatRoom(int chatRoomId, int loginedMemberId);

	public ChatRoom getChatRoomById(int chatRoomId);

	public void saveChat(LocalDateTime regDate, int chatRoomId, int memberId, String message, MessageType messageType);
    
    //	채팅방 유저 리스트 삭제
//    public void delUser(String roomId, String userUUID) {
//        ChatRoom room = chatRoomMap.get(roomId);
//        room.getUserlist().remove(userUUID);
//    }
    
    //	채팅방 userName 조회
//    public String getUserName(String roomId, String userUUID) {
//	    ChatRoom room = chatRoomMap.get(roomId);
//	    return room.getUserlist().get(userUUID);
//    }
    
    //	채팅방 전체 userlist 조회
//    public ArrayList<String> getUserList(String roomId) {
//    	
//        ArrayList<String> list = new ArrayList<>();
//
//        ChatRoom room = chatRoomMap.get(roomId);
//
//        //	hashmap 을 for 문을 돌린 후
//        //	value 값만 뽑아내서 list 에 저장 후 return
//        room.getUserlist().forEach((key, value) -> list.add(value));
//        
//        return list;
//        
//    }

}