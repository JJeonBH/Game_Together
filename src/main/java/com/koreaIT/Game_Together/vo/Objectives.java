package com.koreaIT.Game_Together.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Objectives {
	
	private Objective baron;
	private Objective champion;
	private Objective dragon;
//	private Objective inhibitor;
	private Objective tower;
	
}