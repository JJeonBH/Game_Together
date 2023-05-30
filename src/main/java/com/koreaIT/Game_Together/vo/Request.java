package com.koreaIT.Game_Together.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.koreaIT.Game_Together.service.MemberService;
import com.koreaIT.Game_Together.util.Util;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Request {
	
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private HttpSession httpSession;
	
	@Autowired
	public Request(HttpServletRequest request, HttpServletResponse response, MemberService memberService) {
		
		this.request = request;
		this.response = response;
		this.httpSession = request.getSession();
		
		int loginedMemberId = 0;
		Member loginedMember = null;
		
		if (httpSession.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
			loginedMember = memberService.getMemberById(loginedMemberId);
		}
		
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;
		
		this.request.setAttribute("Request", this);
		
	}
	
	public void initRequest() {
		
	}
	
	public void login(Member member) {
		httpSession.setAttribute("loginedMemberId", member.getId());
	}

	public void logout() {
		httpSession.removeAttribute("loginedMemberId");
	}
	

	public void doJsAlertHistoryBack(String msg) {
		response.setContentType("text/html; charset=UTF-8;");
		
		responseAppend(Util.jsAlertHistoryBack(msg));
	}

	private void responseAppend(String str) {
		try {
			response.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}