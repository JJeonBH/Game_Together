package com.koreaIT.Game_Together.repository;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Repository;

import com.koreaIT.Game_Together.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;

//	추후 DB 와 연결 시 Service 와 Repository(DAO) 로 분리 예정
@Repository
@Slf4j
public class ChatRepository {
	
	private Map<String, ChatRoom> chatRoomMap;

    @PostConstruct
    private void init() {
        chatRoomMap = new LinkedHashMap<>();
    }
    
    //	전체 채팅방 조회
	public List<ChatRoom> findAllChatRoom() {
		
		//	채팅방 생성 순서를 최근순으로 반환
		List<ChatRoom> chatRooms = new ArrayList<>(chatRoomMap.values());
		Collections.reverse(chatRooms);
		
		return chatRooms;
	    
	}
	
	//	roomID 기준으로 채팅방 찾기
    public ChatRoom findChatRoomById(String roomId) {
        return chatRoomMap.get(roomId);
    }
    
    //	roomName 로 채팅방 만들기
    public ChatRoom createChatRoom(String roomName) {
    	
    	ChatRoom chatRoom = new ChatRoom().createChatRoom(roomName); //  채팅방 이름으로 채팅방 생성 후

		//	map 에 채팅방 아이디와 만들어진 채팅방을 저장
		chatRoomMap.put(chatRoom.getRoomId(), chatRoom);

		return chatRoom;
		
    }
    
    //	채팅방 인원 + 1
    public void plusMemberCnt(String roomId) {
	    ChatRoom room = chatRoomMap.get(roomId);
	    room.setMemberCount(room.getMemberCount() + 1);
    }
    
    //	채팅방 인원 - 1
    public void minusMemberCnt(String roomId) {
        ChatRoom room = chatRoomMap.get(roomId);
        room.setMemberCount(room.getMemberCount() - 1);
    }
    
    //	채팅방 멤버 리스트에 멤버 추가
	public String addMember(String roomId, String memberNickname) {
		
	    ChatRoom room = chatRoomMap.get(roomId);
	    String memberUUID = UUID.randomUUID().toString();
	
	    // 아이디 중복 확인 후 memberList 에 추가
	    room.getMemberList().put(memberUUID, memberNickname);
	
	    return memberUUID;
	    
	}
	
	//	채팅방 멤버 이름 중복 확인
	public String isDuplicateNickname(String roomId, String memberNickname) {
		
	    ChatRoom room = chatRoomMap.get(roomId);
	    String tmp = memberNickname;
	
	    //	만약 memberNickname 이 중복이라면 랜덤한 숫자를 붙임
	    //	이때 랜덤한 숫자를 붙였을 때 getMemberList 안에 있는 닉네임이라면 다시 랜덤한 숫자 붙이기!
	    while(room.getMemberList().containsValue(tmp)){
	        int ranNum = (int) (Math.random() * 100) + 1;
	        tmp = memberNickname + ranNum;
	    }
	
	    return tmp;
	    
	}
	
	//	채팅방 멤버 리스트 삭제
    public void delMember(String roomId, String memberUUID) {
	    ChatRoom room = chatRoomMap.get(roomId);
	    room.getMemberList().remove(memberUUID);
    }
    
    //	채팅방 memberNickname 조회
    public String getMemberNickname(String roomId, String memberUUID) {
        ChatRoom room = chatRoomMap.get(roomId);
        return room.getMemberList().get(memberUUID);
    }
    
    //	채팅방 전체 memberList 조회
    public ArrayList<String> getMemberList(String roomId) {
    	
        ArrayList<String> list = new ArrayList<>();

        ChatRoom room = chatRoomMap.get(roomId);

        // HashMap 을 for 문을 돌린 후
        // value 값만 뽑아내서 list 에 저장 후 return
        room.getMemberList().forEach((key, value) -> list.add(value));
        
        return list;
        
    }

}