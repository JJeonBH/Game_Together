package com.koreaIT.Game_Together.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.koreaIT.Game_Together.interceptor.BeforeActionInterceptor;
import com.koreaIT.Game_Together.interceptor.NeedLoginInterceptor;
import com.koreaIT.Game_Together.interceptor.NeedLogoutInterceptor;

@Configuration
public class GtWebMvcConfigurer implements WebMvcConfigurer {
	
	private BeforeActionInterceptor beforeActionInterceptor;
	private NeedLoginInterceptor needLoginInterceptor;
	private NeedLogoutInterceptor needLogoutInterceptor;
	
	@Autowired
	public GtWebMvcConfigurer(BeforeActionInterceptor beforeActionInterceptor, NeedLoginInterceptor needLoginInterceptor, NeedLogoutInterceptor needLogoutInterceptor) {
		this.beforeActionInterceptor = beforeActionInterceptor;
		this.needLoginInterceptor = needLoginInterceptor;
		this.needLogoutInterceptor = needLogoutInterceptor;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		InterceptorRegistration ir;
		
		ir = registry.addInterceptor(beforeActionInterceptor);
		ir.addPathPatterns("/**");
		ir.addPathPatterns("/favicon.ico");
		ir.excludePathPatterns("/resource/**");
		
		ir = registry.addInterceptor(needLoginInterceptor);
		ir.addPathPatterns("/usr/member/doLogout");
		ir.addPathPatterns("/usr/article/write");
		
		ir = registry.addInterceptor(needLogoutInterceptor);
		ir.addPathPatterns("/usr/member/join");
		ir.addPathPatterns("/usr/member/doJoin");
		ir.addPathPatterns("/usr/member/login");
		ir.addPathPatterns("/usr/member/doLogin");
		
	}

}