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
	
}