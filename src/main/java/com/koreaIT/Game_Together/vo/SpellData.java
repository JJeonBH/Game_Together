package com.koreaIT.Game_Together.vo;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SpellData {
	
//	private String type;
//	private String version;
	private Map<String, Spell> data;
	
}