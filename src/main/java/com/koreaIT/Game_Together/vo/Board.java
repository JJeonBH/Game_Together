package com.koreaIT.Game_Together.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	
	private int id;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private String type;
	private String code;
	private String name;
	private int delStatus;
	private LocalDateTime delDate;
	
}