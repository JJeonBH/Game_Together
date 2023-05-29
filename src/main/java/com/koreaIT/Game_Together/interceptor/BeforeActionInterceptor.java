package com.koreaIT.Game_Together.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.koreaIT.Game_Together.vo.Request;

@Component
public class BeforeActionInterceptor implements HandlerInterceptor {
	
	private Request rq;
	
	@Autowired
	public BeforeActionInterceptor(Request rq) {
		this.rq = rq;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		rq.initRequest();
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
		
	}
	
}