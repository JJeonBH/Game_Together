package com.koreaIT.Game_Together.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.koreaIT.Game_Together.interceptor.BeforeActionInterceptor;
import com.koreaIT.Game_Together.interceptor.NeedLoginInterceptor;
import com.koreaIT.Game_Together.interceptor.NeedLogoutInterceptor;
import com.koreaIT.Game_Together.interceptor.NeedManagerInterceptor;

@Configuration
public class GtWebMvcConfigurer implements WebMvcConfigurer {
	
	private BeforeActionInterceptor beforeActionInterceptor;
	private NeedLoginInterceptor needLoginInterceptor;
	private NeedLogoutInterceptor needLogoutInterceptor;
	private NeedManagerInterceptor needManagerInterceptor;
	
	@Autowired
	public GtWebMvcConfigurer(BeforeActionInterceptor beforeActionInterceptor, NeedLoginInterceptor needLoginInterceptor, NeedLogoutInterceptor needLogoutInterceptor, NeedManagerInterceptor needManagerInterceptor) {
		this.beforeActionInterceptor = beforeActionInterceptor;
		this.needLoginInterceptor = needLoginInterceptor;
		this.needLogoutInterceptor = needLogoutInterceptor;
		this.needManagerInterceptor = needManagerInterceptor;
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
		ir.addPathPatterns("/usr/member/profile");
		ir.addPathPatterns("/usr/member/passwordCheck");
		ir.addPathPatterns("/usr/member/doPasswordCheck");
		ir.addPathPatterns("/usr/member/modify");
		ir.addPathPatterns("/usr/member/doModify");
		ir.addPathPatterns("/usr/member/passwordModify");
		ir.addPathPatterns("/usr/member/doPasswordModify");
		ir.addPathPatterns("/usr/member/withdraw");
		ir.addPathPatterns("/usr/member/doWithdraw");
		ir.addPathPatterns("/usr/member/nicknameDupCheckForChange");
		ir.addPathPatterns("/usr/member/emailDupCheckForChange");
		ir.addPathPatterns("/usr/member/cellphoneNumDupCheckForChange");
		ir.addPathPatterns("/usr/article/write");
		ir.addPathPatterns("/usr/article/doWrite");
		ir.addPathPatterns("/usr/article/modify");
		ir.addPathPatterns("/usr/article/doModify");
		ir.addPathPatterns("/usr/article/doDelete");
		ir.addPathPatterns("/usr/reactionPoint/getReactionPoint");
		ir.addPathPatterns("/usr/reactionPoint/doInsertReactionPoint");
		ir.addPathPatterns("/usr/reactionPoint/doDeleteReactionPoint");
		ir.addPathPatterns("/usr/reply/doWrite");
		ir.addPathPatterns("/usr/reply/doModify");
		ir.addPathPatterns("/usr/reply/doDelete");
		ir.addPathPatterns("/usr/reply/getReplyContent");
		ir.addPathPatterns("/usr/chat/chatRoomList");
		ir.addPathPatterns("/usr/chat/createChatRoomForm");
		ir.addPathPatterns("/usr/chat/createChatRoom");
		ir.addPathPatterns("/usr/chat/joinChatRoom");
		ir.addPathPatterns("/usr/chat/chatRoomPasswordCheck");
		ir.addPathPatterns("/usr/chat/passwordCheck");
		ir.addPathPatterns("/usr/chat/canJoin");
		ir.addPathPatterns("/usr/chat/canCreate");
		ir.addPathPatterns("/usr/chat/enterMember");
		ir.addPathPatterns("/usr/chat/sendMessage");
		ir.addPathPatterns("/usr/chat/exitMember");
		ir.addPathPatterns("/usr/chat/banMember");
		ir.addPathPatterns("/usr/chat/changeHost");
		ir.addPathPatterns("/usr/chat/deleteChatRoom");
		ir.addPathPatterns("/usr/chat/memberList");
		ir.addPathPatterns("/usr/chat/getChatRoom");
		ir.addPathPatterns("/usr/chat/getMember");
		ir.addPathPatterns("/usr/chat/exitChatRoom");
		
		ir = registry.addInterceptor(needLogoutInterceptor);
		ir.addPathPatterns("/usr/member/join");
		ir.addPathPatterns("/usr/member/doJoin");
		ir.addPathPatterns("/usr/member/login");
		ir.addPathPatterns("/usr/member/doLogin");
		ir.addPathPatterns("/usr/member/checkLogin");
		ir.addPathPatterns("/usr/member/loginIdDupCheck");
		ir.addPathPatterns("/usr/member/nicknameDupCheck");
		ir.addPathPatterns("/usr/member/emailDupCheck");
		ir.addPathPatterns("/usr/member/cellphoneNumDupCheck");
		ir.addPathPatterns("/usr/member/findLoginId");
		ir.addPathPatterns("/usr/member/doFindLoginId");
		ir.addPathPatterns("/usr/member/findLoginPw");
		ir.addPathPatterns("/usr/member/doFindLoginPw");
		ir.addPathPatterns("/usr/member/restore");
		
		ir = registry.addInterceptor(needManagerInterceptor);
		ir.addPathPatterns("/adm/home/main");
		ir.addPathPatterns("/adm/member/list");
		ir.addPathPatterns("/adm/member/doDeleteMembers");
		ir.addPathPatterns("/adm/member/doReleaseMembers");
		
	}

}