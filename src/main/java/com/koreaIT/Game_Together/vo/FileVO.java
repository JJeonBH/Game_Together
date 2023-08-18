package com.koreaIT.Game_Together.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FileVO {
	
	private int id;
	private LocalDateTime regDate;
	private String originName;
	private String savedName;
	private String savedPath;
	private String relTypeCode;
	private int relId;
	
}