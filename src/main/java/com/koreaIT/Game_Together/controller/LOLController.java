package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreaIT.Game_Together.service.LOLService;
import com.koreaIT.Game_Together.vo.Summoner;

@Controller
public class LOLController {
	
	private LOLService lOLService;
	
	@Autowired
	public LOLController(LOLService lOLService) {
		this.lOLService = lOLService;
	}

	@RequestMapping("/usr/lol/search")
	public String apiTest(String summonerName, Model model) {
		
		summonerName = summonerName.trim().replaceAll(" ","%20");
		
		Summoner summoner = lOLService.callRiotAPIBySummonerName(summonerName);
		
		model.addAttribute("summoner", summoner);
		
		return "usr/home/main";
		
	}
	
}