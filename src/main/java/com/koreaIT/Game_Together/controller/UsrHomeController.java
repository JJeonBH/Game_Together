package com.koreaIT.Game_Together.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreaIT.Game_Together.service.ArticleService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Article;

@Controller
public class UsrHomeController {
	
	private ArticleService articleService;
	
	@Autowired
	public UsrHomeController(ArticleService articleService) {
		this.articleService = articleService;
	}

	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		
		int limitStart = 0;
		int itemsInAPage = 3;
		
		String boardType = "lol";
		
		List<Article> lolNoticeArticles = articleService.getNoticeArticles(boardType, limitStart, itemsInAPage);
		
		for (Article article : lolNoticeArticles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
		}
		
		List<Article> lolHighReactionPointArticles = articleService.getHighReactionPointArticles(boardType, limitStart, itemsInAPage);
		
		for (Article article : lolHighReactionPointArticles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
		}
		
		boardType = "bg";
		
		List<Article> bgNoticeArticles = articleService.getNoticeArticles(boardType, limitStart, itemsInAPage);
		
		for (Article article : bgNoticeArticles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
		}
		
		List<Article> bgHighReactionPointArticles = articleService.getHighReactionPointArticles(boardType, limitStart, itemsInAPage);
		
		for (Article article : bgHighReactionPointArticles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
		}
		
		model.addAttribute("lolNoticeArticles", lolNoticeArticles);
		model.addAttribute("bgNoticeArticles", bgNoticeArticles);
		model.addAttribute("lolHighReactionPointArticles", lolHighReactionPointArticles);
		model.addAttribute("bgHighReactionPointArticles", bgHighReactionPointArticles);
		
		return "usr/home/main";
		
	}
	
	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}

}