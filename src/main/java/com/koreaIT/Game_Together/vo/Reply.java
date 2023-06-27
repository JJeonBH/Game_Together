package com.koreaIT.Game_Together.vo;

	import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
	
	private int id;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private int memberId;
	private String relTypeCode;
	private int relId;
	private String body;
	
	private String writerNickname;
	private String formatRegDate;
	
	public String getForPrintBody() {
		return this.body.replaceAll("\n", "<br>");
	}
	
}