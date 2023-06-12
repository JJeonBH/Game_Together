package com.koreaIT.Game_Together.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.koreaIT.Game_Together.vo.Champion;
import com.koreaIT.Game_Together.vo.LeagueEntry;
import com.koreaIT.Game_Together.vo.Match;
import com.koreaIT.Game_Together.vo.MatchesData;
import com.koreaIT.Game_Together.vo.Participant;
import com.koreaIT.Game_Together.vo.Queue;
import com.koreaIT.Game_Together.vo.RuneStyle;
import com.koreaIT.Game_Together.vo.SpellData;
import com.koreaIT.Game_Together.vo.Summoner;
import com.koreaIT.Game_Together.vo.Team;

@Service
public class LOLService {
	
	@Value("${riot.api.key}")
	private String riotAPIKey;
	@Value("${riot.server.url.kr}")
	private String riotServerUrlKr;
	@Value("${riot.server.url.asia}")
	private String riotServerUrlAsia;
	
	private ObjectMapper objectMapper;
	private HttpClient client;
	
	@Autowired
	public LOLService(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
		this.client = HttpClientBuilder.create().build();
	}
	
	public Summoner getSummonerBySummonerName(String summonerName) {
		
		Summoner summoner = new Summoner();
		 
        try {
            HttpGet request = new HttpGet(riotServerUrlKr + "/lol/summoner/v4/summoners/by-name/" + summonerName + "?api_key=" + riotAPIKey);
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return null;
            }
 
            HttpEntity entity = response.getEntity();
            
            summoner = objectMapper.readValue(entity.getContent(), Summoner.class);
            
            setDataDragonVer(summoner);
            setQueues(summoner);
            setSpellData(summoner);
            setRuneStyle(summoner);
            	
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
        
        return summoner;
        
	}

	private void setDataDragonVer(Summoner summoner) {
		
		try {
            HttpGet request = new HttpGet("https://ddragon.leagueoflegends.com/api/versions.json");
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return;
            }
 
            HttpEntity entity = response.getEntity();
            
			@SuppressWarnings("unchecked")
			List<String> dataDragonVer = objectMapper.readValue(entity.getContent(), List.class);
            
            summoner.setDataDragonVer(dataDragonVer);
            	
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
        
	}
	
	private void setQueues(Summoner summoner) {
		
		try {
            HttpGet request = new HttpGet("http://static.developer.riotgames.com/docs/lol/queues.json");
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return;
            }
 
            HttpEntity entity = response.getEntity();
            
			@SuppressWarnings("unchecked")
			List<Queue> queues = objectMapper.readValue(entity.getContent(), List.class);
            
            summoner.setQueues(queues);
            	
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
		
	}
	
	private void setSpellData(Summoner summoner) {
		
		String dataDragonVer = summoner.getDataDragonVer().get(0);
		
		try {
            HttpGet request = new HttpGet("https://ddragon.leagueoflegends.com/cdn/"+ dataDragonVer +"/data/ko_KR/summoner.json");
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return;
            }
 
            HttpEntity entity = response.getEntity();
            
            SpellData spellData = objectMapper.readValue(entity.getContent(), SpellData.class);
            
            summoner.setSpellData(spellData);
            	
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
		
	}
	
	private void setRuneStyle(Summoner summoner) {
		
		String dataDragonVer = summoner.getDataDragonVer().get(0);
		
		try {
            HttpGet request = new HttpGet("https://ddragon.leagueoflegends.com/cdn/"+ dataDragonVer +"/data/ko_KR/runesReforged.json");
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return;
            }
 
            HttpEntity entity = response.getEntity();
            
            @SuppressWarnings("unchecked")
			List<RuneStyle> runeStyle = objectMapper.readValue(entity.getContent(), List.class);
            
            summoner.setRuneStyle(runeStyle);
            	
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
		
	}

	@SuppressWarnings("unchecked")
	public List<LeagueEntry> getLeagueEntriesBySummonerId(String summonerId) {
		
		List<LeagueEntry> leagueEntries = new ArrayList<>();
		
		try {
            HttpGet request = new HttpGet(riotServerUrlKr + "/lol/league/v4/entries/by-summoner/" + summonerId + "?api_key=" + riotAPIKey);
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return null;
            }
 
            HttpEntity entity = response.getEntity();
            
            leagueEntries = objectMapper.readValue(entity.getContent(), List.class);
            	
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
		
		return leagueEntries;
		
	}

	@SuppressWarnings("unchecked")
	public List<Match> getMatchesBySummonerPuuid(String summonerPuuid, int start, int count) {
		
		List<String> matchIds = new ArrayList<>();
		List<Match> matches = new ArrayList<>();
		
		try {
            HttpGet request = new HttpGet(riotServerUrlAsia + "/lol/match/v5/matches/by-puuid/" + summonerPuuid + "/ids?start=" + start + "&count=" + count + "&api_key=" + riotAPIKey);
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return null;
            }
 
            HttpEntity entity = response.getEntity();
            
            matchIds = objectMapper.readValue(entity.getContent(), List.class);
            
            List<HttpGet> requests = new ArrayList<>();
            
            for (String matchId : matchIds) {
            	
            	request = new HttpGet(riotServerUrlAsia + "/lol/match/v5/matches/" + matchId + "?api_key=" + riotAPIKey);
				
            	requests.add(request);
            	
        	}
            
            for (HttpGet req : requests) {
            	
            	response = client.execute(req);
            	
            	if(response.getStatusLine().getStatusCode() != 200){
            		return null;
            	}
            	
            	entity = response.getEntity();
            	
            	Match match = objectMapper.readValue(entity.getContent(), Match.class);
            	
            	matches.add(match);
            	
            }
            	
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
		
		return matches;
		
	}

	public MatchesData getMatchesData(List<Match> matches, Summoner summoner) {
		
		MatchesData matchesData = new MatchesData();
		
		int totalWins = 0;
		int totalLoses = 0;
		int totalKills = 0;
		int totalDeaths = 0;
		int totalAssists = 0;
		int totalTeamKills = 0;
		Map<String, Integer> teamPositions = new HashMap<>();
		List<Champion> champions = new ArrayList<>();
		
		teamPositions.put("TOP", 0);
		teamPositions.put("JUNGLE", 0);
		teamPositions.put("MIDDLE", 0);
		teamPositions.put("BOTTOM", 0);
		teamPositions.put("UTILITY", 0);
		
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
						
						if(match.getInfo().getQueueId() == 420) {
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
		
		//	경기 수 기준 내림차순 정렬
		Collections.sort(champions, Collections.reverseOrder());
		
		matchesData.setTotalWins(totalWins);
		matchesData.setTotalLoses(totalLoses);
		matchesData.setTotalKills(totalKills);
		matchesData.setTotalDeaths(totalDeaths);
		matchesData.setTotalAssists(totalAssists);
		matchesData.setTotalTeamKills(totalTeamKills);
		matchesData.setTeamPositions(teamPositions);
		matchesData.setChampions(champions);
		
		return matchesData;
		
	}

}