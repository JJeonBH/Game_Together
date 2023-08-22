package com.koreaIT.Game_Together.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	
	private int id;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private String loginId;
	private String loginPw;
	private int authLevel;
	private String name;
	private String nickname;
	private String birthday;
	private String gender;
	private String email;
	private String cellphoneNum;
	private int delStatus;
	private LocalDateTime delDate;
	private int banStatus;
	private LocalDateTime banDate;
	
	private String sessionId;
	private String formatRegDate;
	private String formatDelDate;
	private String formatBanDate;
	
}