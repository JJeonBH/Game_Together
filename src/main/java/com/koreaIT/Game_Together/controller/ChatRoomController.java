package com.koreaIT.Game_Together.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreaIT.Game_Together.service.ChatService;
import com.koreaIT.Game_Together.vo.ChatRoom;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.Request;

@Controller
public class ChatRoomController {
	
	private ChatService chatService;
	private Request rq;
	
	@Autowired
	public ChatRoomController(ChatService chatService, Request rq) {
		this.chatService = chatService;
		this.rq = rq;
	}
	
    //	채팅방 리스트 화면
    //	/usr/chat/chatRoomList 로 요청이 들어오면 전체 채팅방 리스트를 담아서 return
	@RequestMapping("/usr/chat/chatRoomList")
    public String showChatRoomList(Model model) {
		
		List<ChatRoom> chatRooms = chatService.getChatRooms();

        model.addAttribute("chatRooms", chatRooms);
        
        return "usr/chat/chatRoomList";
        
    }
	
	//	채팅방 생성 페이지(제목, 최대 인원수 등 입력)
	@RequestMapping("/usr/chat/createChatRoomForm")
    public String createChatRoomForm() {
        return "usr/chat/createChatRoomForm";
    }
	
	//	채팅방 생성
	//	채팅방 생성 후 /usr/chat/joinChatRoom 로 redirect
	@RequestMapping("/usr/chat/createChatRoom")
    public String createChatRoom(RedirectAttributes redirect, String name, int maxMemberCount) {
		
        chatService.createChatRoom(rq.getLoginedMemberId(), name, maxMemberCount);
        
        int chatRoomId = chatService.getLastInsertId();
        
        redirect.addAttribute("chatRoomId", chatRoomId);
        
        return "redirect:/usr/chat/joinChatRoom";
        
    }
	
	//	채팅방 입장 화면
	//	파라미터로 넘어오는 chatRoomId 를 확인후 해당 chatRoomId 를 기준으로
	//	채팅방을 찾아서 클라이언트를 채팅방으로 보낸다.
	@RequestMapping("/usr/chat/joinChatRoom")
	public String joinChatRoom(Model model, @RequestParam("chatRoomId") int chatRoomId) {
		
		ChatRoom chatRoom = chatService.getChatRoomById(chatRoomId);
		Member member = rq.getLoginedMember();
		
	    model.addAttribute("chatRoom", chatRoom);
	    model.addAttribute("member", member);
	    
	    return "usr/chat/chatRoom";
	    
	}
	
	//	채팅방 삭제
	//	채팅방 삭제 후 /usr/chat/chatRoomList 로 redirect
	@RequestMapping("/usr/chat/deleteChatRoom")
    public String deleteChatRoom(@RequestParam("chatRoomId") int chatRoomId) {
		
        chatService.deleteChatRoom(chatRoomId);
        
        return "redirect:/usr/chat/chatRoomList";
        
    }

}