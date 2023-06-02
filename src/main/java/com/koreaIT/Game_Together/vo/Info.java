package com.koreaIT.Game_Together.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Info {
	
	private long gameDuration;
	private String gameMode;
//	private String gameName;
	private String gameType;
	private int mapId;
	private List<Participant> participants;
	private int queueId;
	private List<Team> teams;
	
}