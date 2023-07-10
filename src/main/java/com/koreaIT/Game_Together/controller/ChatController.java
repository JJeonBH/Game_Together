package com.koreaIT.Game_Together.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.koreaIT.Game_Together.repository.ChatRepository;
import com.koreaIT.Game_Together.vo.Chat;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class ChatController {
	
	private final SimpMessageSendingOperations template;
	private ChatRepository chatRepository;
	
	@Autowired
	public ChatController(SimpMessageSendingOperations template, ChatRepository chatRepository) {
		this.template = template;
		this.chatRepository = chatRepository;
	}
	
	//	MessageMapping 을 통해 webSocket 로 들어오는 메시지를 발신 처리한다.
    //	이때 클라이언트에서는 /pub/chat/message 로 요청하게 되고 이것을 controller 가 받아서 처리한다.
    //	처리가 완료되면 /sub/chat/room/roomId 로 메시지가 전송된다.
    @MessageMapping("/chat/enterMember")
    public void enterMember(@Payload Chat chat, SimpMessageHeaderAccessor headerAccessor) {

	    //	채팅방 멤버 + 1
    	chatRepository.plusMemberCnt(chat.getRoomId());
	
	    //	채팅방에 멤버 추가 및 memberUUID 반환
	    String memberUUID = chatRepository.addMember(chat.getRoomId(), chat.getSender());
	
	    //	반환 결과를 socket session 에 memberUUID 로 저장
	    headerAccessor.getSessionAttributes().put("memberUUID", memberUUID);
	    headerAccessor.getSessionAttributes().put("roomId", chat.getRoomId());
	
	    chat.setMessage(chat.getSender() + " 님 입장!!");
	    
	    template.convertAndSend("/sub/chat/room/" + chat.getRoomId(), chat);

    }
    
    //	해당 멤버
    @MessageMapping("/chat/sendMessage")
    public void sendMessage(@Payload Chat chat) {
    	
        log.info("CHAT {}", chat);
        chat.setMessage(chat.getMessage());
        template.convertAndSend("/sub/chat/room/" + chat.getRoomId(), chat);

    }
    
    //	멤버 퇴장 시에는 EventListener 을 통해서 멤버 퇴장을 확인
    @EventListener
    public void webSocketDisconnectListener(SessionDisconnectEvent event) {
        log.info("DisConnEvent {}", event);

        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

        //	stomp 세션에 있던 uuid 와 roomId 를 확인해서 채팅방 멤버 리스트와 room 에서 해당 멤버를 삭제
        String memberUUID = (String) headerAccessor.getSessionAttributes().get("memberUUID");
        String roomId = (String) headerAccessor.getSessionAttributes().get("roomId");

        log.info("headAccessor {}", headerAccessor);

        //	채팅방 멤버 -1
        chatRepository.minusMemberCnt(roomId);

        //	채팅방 멤버 리스트에서 UUID 멤버 닉네임 조회 및 리스트에서 멤버 삭제
        String memberNickname = chatRepository.getMemberNickname(roomId, memberUUID);
        chatRepository.delMember(roomId, memberUUID);

        if (memberNickname != null) {
        	log.info("User Disconnected : " + memberNickname);

            //	builder 어노테이션 활용
            Chat chat = Chat.builder()
                    .type(Chat.MessageType.LEAVE)
                    .sender(memberNickname)
                    .message(memberNickname + " 님 퇴장!!")
                    .build();

            template.convertAndSend("/sub/chat/room/" + roomId, chat);
            
        }
        
    }
    
    //	채팅에 참여한 멤버 리스트 반환
    @RequestMapping("/chat/memberList")
    @ResponseBody
    public ArrayList<String> memberList(String roomId) {
    	return chatRepository.getMemberList(roomId);
    }

    //	채팅에 참여한 멤버 닉네임 중복 확인
    @RequestMapping("/chat/duplicateName")
    @ResponseBody
    public String isDuplicateName(@RequestParam("roomId") String roomId, @RequestParam("memberNickname") String memberNickname) {

        // 멤버 닉네임 확인
        String nickName = chatRepository.isDuplicateNickname(roomId, memberNickname);
        log.info("동작확인 {}", nickName);

        return nickName;
        
    }

}