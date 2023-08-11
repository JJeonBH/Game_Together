package com.koreaIT.Game_Together.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.ArticleService;
import com.koreaIT.Game_Together.service.LOLService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Article;
import com.koreaIT.Game_Together.vo.LeagueEntry;
import com.koreaIT.Game_Together.vo.Match;
import com.koreaIT.Game_Together.vo.MatchesData;
import com.koreaIT.Game_Together.vo.Participant;
import com.koreaIT.Game_Together.vo.Summoner;

@Controller
public class LOLController {
	
	private LOLService lOLService;
	private ArticleService articleService;
	private int start;
	private int count;
	
	@Autowired
	public LOLController(LOLService lOLService, ArticleService articleService) {
		this.lOLService = lOLService;
		this.articleService = articleService;
	}

	@RequestMapping("/usr/lol/search")
	public String search(String summonerName, Model model) {
		
		int limitStart = 0;
		int itemsInAPage = 3;
		
		String boardType = "lol";
		
		List<Article> lolNoticeArticles = articleService.getNoticeArticles(boardType, limitStart, itemsInAPage);
		
		for (Article article : lolNoticeArticles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
		}
		
		boardType = "bg";
		
		List<Article> bgNoticeArticles = articleService.getNoticeArticles(boardType, limitStart, itemsInAPage);
		
		for (Article article : bgNoticeArticles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
		}
		
		summonerName = summonerName.trim().replaceAll(" ","%20");
		
		Summoner summoner = lOLService.getSummonerBySummonerName(summonerName);
		
		if (summoner == null) {
			model.addAttribute("lolNoticeArticles", lolNoticeArticles);
			model.addAttribute("bgNoticeArticles", bgNoticeArticles);
			return "usr/home/main";
		}
		
		String summonerId = summoner.getId();
		
		List<LeagueEntry> leagueEntries = lOLService.getLeagueEntriesBySummonerId(summonerId);
		
		String summonerPuuid = summoner.getPuuid();
		
		this.start = 0;
		this.count = 20;
		
		List<Match> matches = lOLService.getMatchesBySummonerPuuid(summonerPuuid, start, count);

		if (matches == null) {
			model.addAttribute("lolNoticeArticles", lolNoticeArticles);
			model.addAttribute("bgNoticeArticles", bgNoticeArticles);
			return "usr/home/main";
		}
		
		for(Match match : matches) {
			for(Participant participant : match.getInfo().getParticipants()) {
				if (participant.getChampionName().equals("FiddleSticks")) {
					participant.setChampionName("Fiddlesticks");
				}
			}
		}
		
		this.start += count;
		
		MatchesData matchesData = lOLService.getMatchesData(matches, summoner);
		
		model.addAttribute("summoner", summoner);
		model.addAttribute("leagueEntries", leagueEntries);
		model.addAttribute("matches", matches);
		model.addAttribute("matchesData", matchesData);
		model.addAttribute("lolNoticeArticles", lolNoticeArticles);
		model.addAttribute("bgNoticeArticles", bgNoticeArticles);
		
		return "usr/home/main";
		
	}
	
	@RequestMapping("/usr/lol/searchFromMatch")
	public String searchFromMatch(String summonerPuuid, Model model) {
		
		int limitStart = 0;
		int itemsInAPage = 3;
		
		String boardType = "lol";
		
		List<Article> lolNoticeArticles = articleService.getNoticeArticles(boardType, limitStart, itemsInAPage);
		
		for (Article article : lolNoticeArticles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
		}
		
		boardType = "bg";
		
		List<Article> bgNoticeArticles = articleService.getNoticeArticles(boardType, limitStart, itemsInAPage);
		
		for (Article article : bgNoticeArticles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
		}
		
		Summoner summoner = lOLService.getSummonerBySummonerPuuid(summonerPuuid);
		
		if (summoner == null) {
			model.addAttribute("lolNoticeArticles", lolNoticeArticles);
			model.addAttribute("bgNoticeArticles", bgNoticeArticles);
			return "usr/home/main";
		}
		
		String summonerId = summoner.getId();
		
		List<LeagueEntry> leagueEntries = lOLService.getLeagueEntriesBySummonerId(summonerId);
		
		this.start = 0;
		this.count = 20;
		
		List<Match> matches = lOLService.getMatchesBySummonerPuuid(summonerPuuid, start, count);
		
		if (matches == null) {
			model.addAttribute("lolNoticeArticles", lolNoticeArticles);
			model.addAttribute("bgNoticeArticles", bgNoticeArticles);
			return "usr/home/main";
		}
		
		for(Match match : matches) {
			for(Participant participant : match.getInfo().getParticipants()) {
				if (participant.getChampionName().equals("FiddleSticks")) {
					participant.setChampionName("Fiddlesticks");
				}
			}
		}
		
		this.start += count;
		
		MatchesData matchesData = lOLService.getMatchesData(matches, summoner);
		
		model.addAttribute("summoner", summoner);
		model.addAttribute("leagueEntries", leagueEntries);
		model.addAttribute("matches", matches);
		model.addAttribute("matchesData", matchesData);
		model.addAttribute("lolNoticeArticles", lolNoticeArticles);
		model.addAttribute("bgNoticeArticles", bgNoticeArticles);
		
		return "usr/home/main";
		
	}
	
	@RequestMapping("/usr/lol/getSummoner")
	@ResponseBody
	public Summoner getSummoner(String summonerName) {
		
		summonerName = summonerName.trim().replaceAll(" ","%20");
		
		Summoner summoner = lOLService.getSummonerBySummonerName(summonerName);
		
		return summoner;
		
	}
	
	@RequestMapping("/usr/lol/getMatches")
	@ResponseBody
	public List<Match> getMatches(String summonerPuuid) {
		
		List<Match> matches = lOLService.getMatchesBySummonerPuuid(summonerPuuid, start, count/2);
		
		this.start += count/2;
		
		if (matches != null) {
			for(Match match : matches) {
				for(Participant participant : match.getInfo().getParticipants()) {
					if (participant.getChampionName().equals("FiddleSticks")) {
						participant.setChampionName("Fiddlesticks");
					}
				}
			}
		}
		
		return matches;
		
	}
	
}