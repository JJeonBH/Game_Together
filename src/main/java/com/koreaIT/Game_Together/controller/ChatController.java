package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreaIT.Game_Together.vo.Request;

@Controller
public class ChatController {
	
	private Request rq;
	
	@Autowired
	public ChatController(Request rq) {
		this.rq = rq;
	}
	
	@RequestMapping("/usr/chat/chatting")
	public String chatting(Model model) {
		
		model.addAttribute("member", rq.getLoginedMember());
		
		return "usr/chat/chatting";
		
	}

}