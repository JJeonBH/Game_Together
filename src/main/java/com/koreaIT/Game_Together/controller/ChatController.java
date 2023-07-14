package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import com.koreaIT.Game_Together.service.ChatService;
import com.koreaIT.Game_Together.vo.Chat;
import com.koreaIT.Game_Together.vo.Request;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	
	private final SimpMessageSendingOperations template;
	private ChatService chatService;
	
	@Autowired
	public ChatController(SimpMessageSendingOperations template, ChatService chatService, Request rq) {
		this.template = template;
		this.chatService = chatService;
	}
	
	//	MessageMapping 을 통해 webSocket 로 들어오는 메시지를 발신 처리한다.
	//	이때 클라이언트에서는 /pub/usr/chat/sendMessage 로 요청하게 되고 이것을 controller 가 받아서 처리한다.
	//	처리가 완료되면 /sub/usr/chat/joinChatRoom/chatRoomId 로 메시지가 전송된다.
	@MessageMapping("/usr/chat/enterMember")
	public void enterMember(@Payload Chat chat, SimpMessageHeaderAccessor headerAccessor) {
		
		chatService.joinChatRoom(chat.getChatRoomId(), chat.getMemberId());
		chatService.saveChat(chat.getRegDate(), chat.getChatRoomId(), chat.getMemberId(), chat.getMessage(), chat.getMessageType());
		
		headerAccessor.getSessionAttributes().put("memberId", chat.getMemberId());
		headerAccessor.getSessionAttributes().put("chatRoomId", chat.getChatRoomId());
		
		System.out.println(chat);
		
		template.convertAndSend("/sub/usr/chat/joinChatRoom/" + chat.getChatRoomId(), chat);
	
	}
    
    @MessageMapping("/usr/chat/sendMessage")
    public void sendMessage(@Payload Chat chat) {
    	
    	chatService.saveChat(chat.getRegDate(), chat.getChatRoomId(), chat.getMemberId(), chat.getMessage(), chat.getMessageType());
    	
    	System.out.println(chat);
    	
        template.convertAndSend("/sub/usr/chat/joinChatRoom/" + chat.getChatRoomId(), chat);
        
    }
    
    //	유저 퇴장 시에는 EventListener 을 통해서 유저 퇴장을 확인
//    @EventListener
//    public void webSocketDisconnectListener(SessionDisconnectEvent event) {
//    	
//        log.info("DisConnEvent {}", event);
//
//        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

        //	stomp 세션에 있던 uuid 와 roomId 를 확인해서 채팅방 유저 리스트와 room 에서 해당 유저를 삭제
//        String userUUID = (String) headerAccessor.getSessionAttributes().get("userUUID");
//        String roomId = (String) headerAccessor.getSessionAttributes().get("roomId");
//
//        log.info("headAccessor {}", headerAccessor);

        //	채팅방 유저 -1
//        chatRepository.minusUserCnt(roomId);

        //	채팅방 유저 리스트에서 UUID 유저 닉네임 조회 및 리스트에서 유저 삭제
//        String username = chatRepository.getUserName(roomId, userUUID);
//        chatRepository.delUser(roomId, userUUID);

//        if (username != null) {
//            log.info("User Disconnected : " + username);

            // builder 어노테이션 활용
//            Chat chat = Chat.builder()
//                    .type(Chat.MessageType.LEAVE)
//                    .sender(username)
//                    .message(username + " 님 퇴장!!")
//                    .build();
//
//            template.convertAndSend("/sub/chat/room/" + roomId, chat);
//            
//        }
//        
//    }
    
    //	채팅에 참여한 유저 리스트 반환
//    @RequestMapping("/chat/userlist")
//    @ResponseBody
//    public ArrayList<String> userList(String roomId) {
//        return chatRepository.getUserList(roomId);
//    }

}