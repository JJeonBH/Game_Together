package com.koreaIT.Game_Together.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreaIT.Game_Together.service.LOLService;
import com.koreaIT.Game_Together.vo.LeagueEntry;
import com.koreaIT.Game_Together.vo.Match;
import com.koreaIT.Game_Together.vo.Summoner;

@Controller
public class LOLController {
	
	private LOLService lOLService;
	
	@Autowired
	public LOLController(LOLService lOLService) {
		this.lOLService = lOLService;
	}

	@RequestMapping("/usr/lol/search")
	public String search(String summonerName, Model model) {
		
		summonerName = summonerName.trim().replaceAll(" ","%20");
		
		Summoner summoner = lOLService.getSummonerBySummonerName(summonerName);
		
		if (summoner == null) {
			return "usr/home/main";
		}
		
		String summonerId = summoner.getId();
		
		List<LeagueEntry> leagueEntries = lOLService.getLeagueEntriesBySummonerId(summonerId);
		
		String summonerPuuid = summoner.getPuuid();
		
		List<Match> matches = lOLService.getMatchesBySummonerPuuid(summonerPuuid);
		
		model.addAttribute("summoner", summoner);
		model.addAttribute("leagueEntries", leagueEntries);
		model.addAttribute("matches", matches);
		
		return "usr/home/main";
		
	}
	
}