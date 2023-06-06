package com.koreaIT.Game_Together.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PerkStyle {
	
	private String description;
	private List<PerkStyleSelection> selections;
	private int style;
	
}