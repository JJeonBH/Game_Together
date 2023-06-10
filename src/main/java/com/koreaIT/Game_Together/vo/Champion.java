package com.koreaIT.Game_Together.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Champion implements Comparable<Champion> {
	
	private String championName;
	private int kills;
	private int deaths;
	private int assists;
	private int winCount;
	private int matchCount;
	
	@Override
	public int compareTo(Champion champion) {
		
		if (champion.matchCount < matchCount) {
			 return 1;
        } else if (champion.matchCount > matchCount) {
            return -1;
        }
		
		return 0;
		
	}
	
	public int getOdds() {
		
		int odds = (int) Math.round(((double) winCount / matchCount) * 100);
		
		return odds;
		
	}
	
	public double getAvgKDA() {
		
		double avgKDA = Math.round(((double) (kills + assists) / deaths) * 100) / 100.0;
		
		return avgKDA;
		
	}
}