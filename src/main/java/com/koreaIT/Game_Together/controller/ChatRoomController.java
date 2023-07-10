package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreaIT.Game_Together.repository.ChatRepository;
import com.koreaIT.Game_Together.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatRoomController {
	
	private ChatRepository chatRepository;
	
	// ChatRepository Bean 가져오기
	@Autowired
	public ChatRoomController(ChatRepository chatRepository) {
		this.chatRepository = chatRepository;
	}
	
    //	채팅방 리스트 화면
    //	/usr/chat/chatRoomList 로 요청이 들어오면 전체 채팅방 리스트를 담아서 return
	@RequestMapping("/usr/chat/chatRoomList")
    public String showChatRoomList(Model model) {

        model.addAttribute("chatRoomList", chatRepository.findAllChatRoom());
        //	model.addAttribute("user", "hey");
        log.info("SHOW ALL ChatList {}", chatRepository.findAllChatRoom());
        
        return "usr/chat/chatRoomList";
        
    }
	
	// 채팅방 생성
	// 채팅방 생성 후 다시 /usr/chat/chatRoomList 로 return
	@RequestMapping("/usr/chat/createChatRoom")
    public String createChatRoom(@RequestParam String roomName, RedirectAttributes rttr) {
		
        ChatRoom room = chatRepository.createChatRoom(roomName);
        log.info("CREATE Chat Room {}", room);
        rttr.addFlashAttribute("roomName", room);
        
        return "redirect:/usr/chat/chatRoomList";
        
    }
	
	// 채팅방 입장 화면
	// 파라미터로 넘어오는 roomId 를 확인후 해당 roomId 를 기준으로
	// 채팅방을 찾아서 클라이언트를 chatroom 으로 보낸다.
	@RequestMapping("/usr/chat/chatRoom")
	public String showChatRoom(Model model, String roomId) {
	
	    log.info("roomId {}", roomId);
	    model.addAttribute("room", chatRepository.findChatRoomById(roomId));
	    
	    return "usr/chat/chatRoom";
	    
	}

}