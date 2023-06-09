package com.koreaIT.Game_Together.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.LOLService;
import com.koreaIT.Game_Together.vo.Champion;
import com.koreaIT.Game_Together.vo.LeagueEntry;
import com.koreaIT.Game_Together.vo.Match;
import com.koreaIT.Game_Together.vo.Participant;
import com.koreaIT.Game_Together.vo.Summoner;
import com.koreaIT.Game_Together.vo.Team;

@Controller
public class LOLController {
	
	private LOLService lOLService;
	private int start;
	private int count;
	
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
		
		this.start = 0;
		this.count = 20;
		
		List<Match> matches = lOLService.getMatchesBySummonerPuuid(summonerPuuid, start, count);

		if (matches == null) {
			return "usr/home/main";
		}
		
		this.start += count;
		
		int totalWins = 0;
		int totalLoses = 0;
		int totalKills = 0;
		int totalDeaths = 0;
		int totalAssists = 0;
		int totalTeamKills = 0;
		Map<String, Integer> teamPositions = new HashMap<>();
		List<Champion> champions = new ArrayList<>();
		
		for (Match match : matches) {
			
			for(Participant participant : match.getInfo().getParticipants()) {
				
				if(participant.getPuuid().equals(summoner.getPuuid())) {
					
					if(participant.isGameEndedInEarlySurrender() == false) {
						
						int kills = participant.getKills();
						int deaths = participant.getDeaths();
						int assists = participant.getAssists();
						
						if (participant.isWin()) {
							totalWins += 1;
						} else {
							totalLoses += 1;
						}
						
						totalKills += kills;
						totalDeaths += deaths;
						totalAssists += assists;
						
						for (Team team : match.getInfo().getTeams()) {
							
							if (team.getTeamId() == participant.getTeamId()) {
								totalTeamKills += team.getObjectives().getChampion().getKills();
							}
							
						}
						
						if (teamPositions.containsKey(participant.getTeamPosition()) == false) {
							teamPositions.put(participant.getTeamPosition(), 1);
						} else {
							teamPositions.put(participant.getTeamPosition(), teamPositions.get(participant.getTeamPosition()) + 1);
						}
						
						String championName = participant.getChampionName();
						int matchCount = 1;
						int winCount;
						
						if (participant.isWin()) {
							winCount = 1;
						} else {
							winCount = 0;
						}
						
						Champion champion = new Champion(championName, kills, deaths, assists, winCount, matchCount);
						
						champions.add(champion);
						
						for (int i = 0; i < champions.size(); i++) {
							
							Champion champ = champions.get(i);
							String champName = champ.getChampionName();
							
							for (int j = i + 1; j < champions.size(); j++) {
								
								if(champName.equals(champions.get(j).getChampionName())) {
									
									Champion equalChamp = champions.get(j);
									
									champ.setKills(champ.getKills() + equalChamp.getKills());
									champ.setDeaths(champ.getDeaths() + equalChamp.getDeaths());
									champ.setAssists(champ.getAssists() + equalChamp.getAssists());
									champ.setWinCount(champ.getWinCount() + equalChamp.getWinCount());
									champ.setMatchCount(champ.getMatchCount() + equalChamp.getMatchCount());
									
									champions.remove(j);
									
								}
								
							}
							
						}
						
					}
					
				}
				
			}
			
		}
		
		//	전체 승률
		int odds = (int) Math.round(((double) totalWins / (totalWins + totalLoses)) * 100);
		
		//	경기수 기준 내림차순 정렬
		Collections.sort(champions, Collections.reverseOrder());
		
		model.addAttribute("summoner", summoner);
		model.addAttribute("leagueEntries", leagueEntries);
		model.addAttribute("matches", matches);
		
		model.addAttribute("odds", odds);
		model.addAttribute("totalWins", totalWins);
		model.addAttribute("totalLoses", totalLoses);
		model.addAttribute("totalKills", totalKills);
		model.addAttribute("totalDeaths", totalDeaths);
		model.addAttribute("totalAssists", totalAssists);
		model.addAttribute("totalTeamKills", totalTeamKills);
		model.addAttribute("teamPositions", teamPositions);
		model.addAttribute("champions", champions);
		
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
		
		return matches;
		
	}
	
}