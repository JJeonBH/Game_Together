package com.koreaIT.Game_Together.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.ChatService;
import com.koreaIT.Game_Together.service.MemberService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Chat;
import com.koreaIT.Game_Together.vo.ChatRoom;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.ResultData;

@Controller
public class ChatController {
	
	private final SimpMessageSendingOperations template;
	private ChatService chatService;
	private MemberService memberService;
	
	@Autowired
	public ChatController(SimpMessageSendingOperations template, ChatService chatService, MemberService memberService) {
		this.template = template;
		this.chatService = chatService;
		this.memberService = memberService;
	}
	
	//	MessageMapping 을 통해 webSocket 로 들어오는 메시지를 발신 처리한다.
	//	이때 클라이언트에서는 /pub/usr/chat/sendMessage 로 요청하게 되고 이것을 controller 가 받아서 처리한다.
	//	처리가 완료되면 /sub/usr/chat/joinChatRoom/chatRoomId 로 메시지가 전송된다.
	@MessageMapping("/usr/chat/enterMember")
	public void enterMember(@Payload Chat chat, SimpMessageHeaderAccessor headerAccessor) {
		
		LocalDateTime now = LocalDateTime.now();
		chat.setRegDate(now);
		chat.setFormatRegDate(Util.formatRegDateVer1(chat.getRegDate()));
		
		chatService.joinChatRoom(chat.getChatRoomId(), chat.getMemberId(), headerAccessor.getSessionId());
		chatService.saveChat(chat.getRegDate(), chat.getChatRoomId(), chat.getMemberId(), chat.getMessage(), chat.getRecipientId(), chat.getBanMemberId(), chat.getMessageType());
		
		headerAccessor.getSessionAttributes().put("memberId", chat.getMemberId());
		headerAccessor.getSessionAttributes().put("chatRoomId", chat.getChatRoomId());
		
		template.convertAndSend("/sub/usr/chat/joinChatRoom/" + chat.getChatRoomId(), chat);
	
	}
    
    @MessageMapping("/usr/chat/sendMessage")
    public void sendMessage(@Payload Chat chat) {
    	
    	String recipientNickname = chat.getRecipientNickname();
    	
    	if (recipientNickname != null) {
    		Member member = memberService.getMemberByNickname(recipientNickname);
    		chat.setRecipientId(member.getId());
    		chat.setMessage(chat.getMessage().substring(chat.getMessage().indexOf(chat.getMessage().split(" ")[2])));
    	}
    	
    	LocalDateTime now = LocalDateTime.now();
		chat.setRegDate(now);
		chat.setFormatRegDate(Util.formatRegDateVer1(chat.getRegDate()));
    	
    	chatService.saveChat(chat.getRegDate(), chat.getChatRoomId(), chat.getMemberId(), chat.getMessage(), chat.getRecipientId(), chat.getBanMemberId(), chat.getMessageType());
    	
        template.convertAndSend("/sub/usr/chat/joinChatRoom/" + chat.getChatRoomId(), chat);
        
    }
    
    @MessageMapping("/usr/chat/exitMember")
    public void exitMember(@Payload Chat chat, SimpMessageHeaderAccessor headerAccessor) {
    	
		//	stomp 세션에 있던 memberId 와 chatRoomId 를 확인해서 채팅방 멤버 리스트와 채팅방에서 해당 멤버를 삭제
		int memberId = (int) headerAccessor.getSessionAttributes().get("memberId");
		int chatRoomId = (int) headerAccessor.getSessionAttributes().get("chatRoomId");
		
		chatService.exitChatRoom(chatRoomId, memberId);
		ChatRoom chatRoom = chatService.getChatRoomById(chatRoomId);
		
		if (chatRoom.getCurrentMemberCount() == 0) {
			chatService.deleteChatRoom(chatRoomId);
			chatService.deleteChat(chatRoomId);
			return;
		}
		
		//	퇴장한 멤버가 방장일 때 입장해 있는 멤버 중 가장 빨리 들어온 멤버가 자동으로 방장이 되게 함
		if (chatRoom.getMemberId() == memberId) {
			chatService.modifyChatRoom(chatRoomId);
		}
		
    	LocalDateTime now = LocalDateTime.now();
    	chat.setRegDate(now);
    	chat.setFormatRegDate(Util.formatRegDateVer1(chat.getRegDate()));
    	
    	chatService.saveChat(chat.getRegDate(), chat.getChatRoomId(), chat.getMemberId(), chat.getMessage(), chat.getRecipientId(), chat.getBanMemberId(), chat.getMessageType());
    	
    	template.convertAndSend("/sub/usr/chat/joinChatRoom/" + chat.getChatRoomId(), chat);
    	
    }
    
    @MessageMapping("/usr/chat/banMember")
    public void banMember(@Payload Chat chat) {
    	
    	String sessionId = chat.getSessionId();
    	
    	Member member = chatService.getMemberBySessionId(sessionId);
    	
    	chat.setBanMemberId(member.getId());
    	
    	chatService.exitChatRoom(chat.getChatRoomId(), chat.getBanMemberId());
    	
    	LocalDateTime now = LocalDateTime.now();
    	chat.setRegDate(now);
    	chat.setFormatRegDate(Util.formatRegDateVer1(chat.getRegDate()));
    	
    	chat.setMessage(member.getNickname() + " 님이 강제 퇴장되었습니다.");
    	chat.setBanMemberNickname(member.getNickname());
    	
    	chatService.saveChat(chat.getRegDate(), chat.getChatRoomId(), chat.getMemberId(), chat.getMessage(), chat.getRecipientId(), chat.getBanMemberId(), chat.getMessageType());
    	
    	template.convertAndSend("/sub/usr/chat/joinChatRoom/" + chat.getChatRoomId(), chat);
    	
    }
    
    @MessageMapping("/usr/chat/changeHost")
    public void changeHost(@Payload Chat chat) {
    	
    	chatService.changeHost(chat.getChatRoomId(), chat.getChangeHostId());
    	
    	LocalDateTime now = LocalDateTime.now();
    	chat.setRegDate(now);
    	chat.setFormatRegDate(Util.formatRegDateVer1(chat.getRegDate()));
    	
    	chatService.saveChat(chat.getRegDate(), chat.getChatRoomId(), chat.getMemberId(), chat.getMessage(), chat.getRecipientId(), chat.getBanMemberId(), chat.getMessageType());
    	
    	template.convertAndSend("/sub/usr/chat/joinChatRoom/" + chat.getChatRoomId(), chat);
    	
    }
    
    //	채팅방에 참여한 멤버 리스트 반환
    @RequestMapping("/usr/chat/memberList")
    @ResponseBody
    public List<Member> memberList(int chatRoomId) {
        return chatService.getMemberList(chatRoomId);
    }
    
    //	퇴장한 멤버가 방장이면 입장해 있는 멤버 중 가장 빨리 들어온 멤버가 자동으로 방장이 됨
    //	이때 채팅방에서 방장 닉네임이 바뀌어야 하므로 채팅방 정보를 넘김
    @RequestMapping("/usr/chat/getChatRoom")
    @ResponseBody
    public ChatRoom getChatRoom(int chatRoomId) {
    	return chatService.getChatRoomById(chatRoomId);
    }
    
    //	귓속말 보낼 때 채팅방에 해당 닉네임을 가진 멤버가 참여 중인지 판단
    @SuppressWarnings("rawtypes")
	@RequestMapping("/usr/chat/getMember")
    @ResponseBody
    public ResultData getMember(int chatRoomId, String nickname) {
        return chatService.getMember(chatRoomId, nickname);
    }

}