package com.koreaIT.Game_Together.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {

	@RequestMapping("/usr/member/join")
	public String join() {
		return "usr/member/join";
	}
	
}
