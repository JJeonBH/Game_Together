package com.koreaIT.Game_Together.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Perks {
	
	private PerkStats statPerks;
	private List<PerkStyle> styles;
	
}