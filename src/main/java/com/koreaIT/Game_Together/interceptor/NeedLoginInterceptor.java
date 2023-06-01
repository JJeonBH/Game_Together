package com.koreaIT.Game_Together.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.koreaIT.Game_Together.vo.Request;

@Component
public class NeedLoginInterceptor implements HandlerInterceptor {

	private Request rq;
	
	@Autowired
	public NeedLoginInterceptor(Request rq) {
		this.rq = rq;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if (rq.getLoginedMemberId() == 0) {
			rq.doJsAlertHistoryBack("로그인 후 이용해주세요");
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
		
	}
	
}