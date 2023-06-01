package com.koreaIT.Game_Together.service;

import java.io.IOException;
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
import com.koreaIT.Game_Together.vo.Summoner;

@Service
public class LOLService {
	
	@Value("${riot.api.key}")
	private String riotAPIKey;
	
	private ObjectMapper objectMapper;
	
	@Autowired
	public LOLService(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}
	
	public Summoner callRiotAPIBySummonerName(String summonerName) {
		
		Summoner summoner;
		
		String serverUrl = "https://kr.api.riotgames.com";
		 
        try {
            HttpClient client = HttpClientBuilder.create().build();
            HttpGet request = new HttpGet(serverUrl + "/lol/summoner/v4/summoners/by-name/" + summonerName + "?api_key=" + riotAPIKey);
 
            HttpResponse response = client.execute(request);
 
            if(response.getStatusLine().getStatusCode() != 200){
            	return null;
            }
 
            HttpEntity entity = response.getEntity();
            summoner = objectMapper.readValue(entity.getContent(), Summoner.class);
            
        	String summonerId = summoner.getId();
        	
        	request = new HttpGet(serverUrl + "/lol/league/v4/entries/by-summoner/" + summonerId + "?api_key=" + riotAPIKey);
        	
        	response = client.execute(request);
        	
        	entity = response.getEntity();
       	
        	List<LeagueEntry> leagueEntry = objectMapper.readValue(entity.getContent(), List.class);
			
        	summoner.setLeagueEntry(leagueEntry);
        	
        	request = new HttpGet("https://ddragon.leagueoflegends.com/api/versions.json");
        	
        	response = client.execute(request);
        	
        	entity = response.getEntity();
        	
        	List<String> dataDragonVer = objectMapper.readValue(entity.getContent(), List.class);
        	
        	summoner.setDataDragonVer(dataDragonVer);
            	
        } catch (IOException e){
            e.printStackTrace();
            return null;
        }
        
        return summoner;
        
	}
	
}