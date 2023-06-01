package com.koreaIT.Game_Together.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Summoner {

	private String id;
	private String accountId;
	private String puuid;
	private String name;
	private int profileIconId;
	private long revisionDate;
	private long summonerLevel;
	
	private List<LeagueEntry> leagueEntry;
	private List<String> dataDragonVer;
	
}