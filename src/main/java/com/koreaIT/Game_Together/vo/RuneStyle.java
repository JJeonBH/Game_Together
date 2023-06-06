package com.koreaIT.Game_Together.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RuneStyle {
	
	private int id;
	private String key;
	private String icon;
	private String name;
	private List<RuneDetail> slots;
	
}