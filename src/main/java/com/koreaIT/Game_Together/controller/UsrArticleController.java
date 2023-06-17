package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreaIT.Game_Together.service.ArticleService;
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
	
}