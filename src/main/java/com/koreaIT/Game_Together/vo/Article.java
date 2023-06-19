package com.koreaIT.Game_Together.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
	
	private int id;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private int memberId;
	private int boardId;
	private String title;
	private String body;
	private int viewCount;
	
	private String writerNickname;
	private String boardName;
	private boolean actorCanChangeData;
	
	public String formatUpdateDate() {
		
		String formatUpdateDate = this.updateDate.format(DateTimeFormatter.ofPattern("yyyy.MM.dd. HH:mm"));
		
		return formatUpdateDate;
		
	}
	
}