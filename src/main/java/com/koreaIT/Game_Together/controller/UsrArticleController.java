package com.koreaIT.Game_Together.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.ArticleService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Article;
import com.koreaIT.Game_Together.vo.Request;

@Controller
public class UsrArticleController {

	private ArticleService articleService;
	private Request rq;
	
	@Autowired
	public UsrArticleController(ArticleService articleService, Request rq) {
		this.articleService = articleService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/article/write")
	public String join() {
		return "usr/article/write";
	}
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(int boardId, String title, String body) {
		
		if (Util.isEmpty(title)) {
			return Util.jsAlertHistoryBack("제목을 입력해 주세요.");
		}

		if (Util.isEmpty(body)) {
			return Util.jsAlertHistoryBack("내용을 입력해 주세요.");
		}

		articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);

		int id = articleService.getLastInsertId();

		return Util.jsAlertReplace("", String.format("detail?id=%d", id));
		
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, HttpServletResponse resp, Model model, int id) {
		
		Cookie oldCookie = null;
		Cookie[] cookies = req.getCookies();
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("viewCount")) {
					oldCookie = cookie;
				}
			}
		}
		
		if (oldCookie != null) {
			if (!oldCookie.getValue().contains("[" + id + "]")) {
				articleService.increaseViewCount(id);
				oldCookie.setValue(oldCookie.getValue() + "_[" + id + "]");
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60);
				resp.addCookie(oldCookie);
			}
		} else {
			articleService.increaseViewCount(id);
			Cookie newCookie = new Cookie("viewCount", "[" + id + "]");
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60);
			resp.addCookie(newCookie);
		}
		
		Article article = articleService.getForPrintArticle(id);

		articleService.actorCanChangeData(rq.getLoginedMemberId(), article);

		model.addAttribute("article", article);

		return "usr/article/detail";
		
	}
	
}