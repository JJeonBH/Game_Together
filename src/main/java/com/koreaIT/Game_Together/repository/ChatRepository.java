package com.koreaIT.Game_Together.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.ChatRoom;

@Mapper
public interface ChatRepository {
	
	public List<ChatRoom> getChatRooms();

	public void createChatRoom(int loginedMemberId, String name, int maxMemberCount);

	public int getLastInsertId();

	public void joinChatRoom(int chatRoomId, int loginedMemberId);

	public ChatRoom getChatRoomById(int chatRoomId);
    
	//	채팅방 인원+1
//    public void plusUserCnt(String roomId) {
//        ChatRoom room = chatRoomMap.get(roomId);
//        room.setUserCount(room.getUserCount()+1);
//    }
    
    //	채팅방 인원-1
//    public void minusUserCnt(String roomId) {
//	    ChatRoom room = chatRoomMap.get(roomId);
//	    room.setUserCount(room.getUserCount()-1);
//    }
    
    //	채팅방 유저 리스트에 유저 추가
//    public String addUser(String roomId, String userName) {
//    	
//        ChatRoom room = chatRoomMap.get(roomId);
//        String userUUID = UUID.randomUUID().toString();

        // 아이디 중복 확인 후 userList 에 추가
//        room.getUserlist().put(userUUID, userName);
//
//        return userUUID;
//        
//    }
	
    //	채팅방 유저 이름 중복 확인
//    public String isDuplicateName(String roomId, String username) {
//    	
//        ChatRoom room = chatRoomMap.get(roomId);
//        String tmp = username;

        // 만약 userName 이 중복이라면 랜덤한 숫자를 붙임
        // 이때 랜덤한 숫자를 붙였을 때 getUserlist 안에 있는 닉네임이라면 다시 랜덤한 숫자 붙이기!
//        while(room.getUserlist().containsValue(tmp)){
//            int ranNum = (int) (Math.random()*100)+1;
//
//            tmp = username+ranNum;
//        }
//
//        return tmp;
//        
//    }
    
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