package com.koreaIT.Game_Together.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Queue {

	private int queueId;
	private String map;
	private String description;
	private String notes;
	
}