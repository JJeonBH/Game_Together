package com.koreaIT.Game_Together.vo;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MatchesData {

	private int totalWins;
	private int totalLoses;
	private int totalKills;
	private int totalDeaths;
	private int totalAssists;
	private int totalTeamKills;
	private Map<String, Integer> teamPositions;
	private List<Champion> champions;
	
}