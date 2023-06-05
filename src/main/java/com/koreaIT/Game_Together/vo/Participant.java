package com.koreaIT.Game_Together.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Participant {
	
	private int assists;
	private int champLevel;
	private int championId;
	private String championName;
	private int deaths;
	private int doubleKills;
	private int item0;
	private int item1;
	private int item2;
	private int item3;
	private int item4;
	private int item5;
	private int item6;
	private int kills;
	private String lane;
	private int neutralMinionsKilled;
	private int participantId;
	private String puuid;
	private int pentaKills;
	private int quadraKills;
	private String role;
	private int summoner1Id;
	private int summoner2Id;
	private String summonerId;
	private String summonerName;
	private int teamId;
	private String teamPosition;
	private int totalDamageDealt;
	private int totalDamageDealtToChampions;
	private int totalMinionsKilled;
	private int tripleKills;
	private int visionWardsBoughtInGame;
	private int wardsKilled;
	private int wardsPlaced;
	private boolean win;
	
	public List<Integer> getItemList() {
		
		List<Integer> items = new ArrayList<>();
		
		items.add(item0);
		items.add(item1);
		items.add(item2);
		items.add(item3);
		items.add(item4);
		items.add(item5);
		items.add(item6);
		
		return items;
		
	}
	
	public List<Integer> getSpellList() {
		
		List<Integer> spells = new ArrayList<>();
		
		spells.add(summoner1Id);
		spells.add(summoner2Id);
		
		return spells;
		
	}
	
}