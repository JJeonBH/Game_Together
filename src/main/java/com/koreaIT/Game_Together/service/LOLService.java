package com.koreaIT.Game_Together.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.koreaIT.Game_Together.vo.LeagueEntry;
import com.koreaIT.Game_Together.vo.Match;
import com.koreaIT.Game_Together.vo.Queue;
import com.koreaIT.Game_Together.vo.SpellData;
import com.koreaIT.Game_Together.vo.Summoner;

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
            setDataQueues(summoner);
            setSpellData(summoner);
            	
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
	
	private void setDataQueues(Summoner summoner) {
		
		try {
            HttpGet request = new HttpGet("http://static.developer.riotgames.com/docs/lol/queues.json");
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return;
            }
 
            HttpEntity entity = response.getEntity();
            
			@SuppressWarnings("unchecked")
			List<Queue> dataQueues = objectMapper.readValue(entity.getContent(), List.class);
            
            summoner.setDataQueues(dataQueues);
            	
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
	public List<Match> getMatchesBySummonerPuuid(String summonerPuuid) {
		
		List<String> matchIds = new ArrayList<>();
		List<Match> matches = new ArrayList<>();
		
		try {
            HttpGet request = new HttpGet(riotServerUrlAsia + "/lol/match/v5/matches/by-puuid/" + summonerPuuid + "/ids?start=0&count=10&api_key=" + riotAPIKey);
 
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
	
}