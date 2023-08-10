package com.koreaIT.Game_Together.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreaIT.Game_Together.service.ChatService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.ChatRoom;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.Request;
import com.koreaIT.Game_Together.vo.ResultData;

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
    public String showChatRoomList(Model model,
    		@RequestParam(defaultValue = "1") int page,
    		@RequestParam(defaultValue = "name") String searchKeywordType,
    		@RequestParam(defaultValue = "") String searchKeyword) {
		
		if (page <= 0) {
			page = 1;
		}
		
		int chatRoomsCnt = chatService.getChatRoomsCnt(searchKeywordType, searchKeyword);
		int itemsInAPage = 10;
		List<ChatRoom> chatRooms = chatService.getChatRooms(searchKeywordType, searchKeyword, itemsInAPage, page);
		int pagesCount = (int) Math.ceil((double) chatRoomsCnt / itemsInAPage);
		
		if (page > pagesCount) {
			page = pagesCount;
		}
		
		int pageSize = 10;
		int startPage = ((page - 1) / pageSize) * pageSize + 1;
		int endPage = startPage + pageSize - 1;
		
		if (endPage > pagesCount) {
			endPage = pagesCount;
		}
		
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordType", searchKeywordType);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("chatRoomsCnt", chatRoomsCnt);
        model.addAttribute("chatRooms", chatRooms);
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
        
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
    public String createChatRoom(RedirectAttributes redirect, String name, int maxMemberCount, String status, String password) {
		
		chatService.createChatRoom(rq.getLoginedMemberId(), name, maxMemberCount, status, Util.sha256(password));
        
        int chatRoomId = chatService.getLastInsertId();
        
        redirect.addAttribute("chatRoomId", chatRoomId);
        
        return "redirect:/usr/chat/joinChatRoom";
        
    }
	
	//	채팅방 입장 화면
	//	파라미터로 넘어오는 chatRoomId 를 확인후 해당 chatRoomId 를 기준으로
	//	채팅방을 찾아서 클라이언트를 채팅방으로 보낸다.
	@RequestMapping("/usr/chat/joinChatRoom")
	public String joinChatRoom(Model model, @RequestParam("chatRoomId") int chatRoomId) {
		
		//	URL로 채팅방 입장하는 것 막음
		if (rq.getRequest().getHeader("REFERER") == null) {
			return rq.jsReplace("정상적인 접근이 아닙니다.", "chatRoomList");
		}
		
		ChatRoom chatRoom = chatService.getChatRoomById(chatRoomId);
		
		if (chatRoom.getId() == 0) {
			return rq.jsReplace("채팅방이 존재하지 않습니다.", "chatRoomList");
		}
		
		Member member = rq.getLoginedMember();
		
	    model.addAttribute("chatRoom", chatRoom);
	    model.addAttribute("member", member);
	    
	    return "usr/chat/chatRoom";
	    
	}
	
	//	비공개 채팅방 입장 시 비밀번호 확인하는 페이지
	@RequestMapping("/usr/chat/chatRoomPasswordCheck")
	public String chatRoomPasswordCheck(Model model, int chatRoomId) {
		
		model.addAttribute("chatRoomId", chatRoomId);
		
		return "usr/chat/chatRoomPasswordCheck";
		
	}
	
	//	비공개 채팅방 입장 시 입력한 비밀번호가 일치하는지 체크
    @SuppressWarnings("rawtypes")
	@RequestMapping("/usr/chat/passwordCheck")
    @ResponseBody
    public ResultData passwordCheck(int chatRoomId, String password) {
        return chatService.passwordCheck(chatRoomId, Util.sha256(password));
    }
    
    //	채팅방 입장 시 이미 다른 채팅방에 입장해 있는지, 인원수 꽉 차 있는지, 강퇴당한 적 있는지 체크
    @SuppressWarnings("rawtypes")
	@RequestMapping("/usr/chat/canJoin")
    @ResponseBody
    public ResultData canJoin(int chatRoomId, int memberId) {
    	return chatService.canJoin(chatRoomId, memberId);
    }
    
    //	채팅방 생성 버튼 누를 때 이미 채팅방을 생성 했는지, 다른 채팅방에 입장해 있는지 체크
    @SuppressWarnings("rawtypes")
	@RequestMapping("/usr/chat/canCreate")
    @ResponseBody
    public ResultData canCreate(int memberId) {
    	return chatService.canCreate(memberId);
    }

}