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
	private int odds;
	private double avgKill;
	private double avgDeath;
	private double avgAssist;
	private double avgKDA;
	private int killInvolvement;
	private Map<String, Integer> teamPositions;
	private List<Champion> champions;
	
}