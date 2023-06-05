package com.koreaIT.Game_Together.vo;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.TimeZone;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Info {
	
	private long gameCreation;
	private long gameDuration;
	private long gameStartTimestamp;
	private long gameEndTimestamp;
	private String gameMode;
	private String gameType;
	private List<Participant> participants;
	private int queueId;
	private List<Team> teams;

	//	매치 시작 시간 구하기
	public String getMatchStartDateTime() {
		
		//	매치 시작 날짜, 시간
		LocalDateTime matchStartDateTime = LocalDateTime.ofInstant(Instant.ofEpochMilli(gameCreation), TimeZone.getDefault().toZoneId());
		//	현재 날짜, 시간
		LocalDateTime currentDateTime = LocalDateTime.now();
		
		if (ChronoUnit.DAYS.between(matchStartDateTime, currentDateTime) < 1) {
			
			if (ChronoUnit.HOURS.between(matchStartDateTime, currentDateTime) >= 1) {
				return ChronoUnit.HOURS.between(matchStartDateTime, currentDateTime) + "시간 전";
			}
			
			if (ChronoUnit.MINUTES.between(matchStartDateTime, currentDateTime) >= 1 && ChronoUnit.MINUTES.between(matchStartDateTime, currentDateTime) < 60) {
				return ChronoUnit.MINUTES.between(matchStartDateTime, currentDateTime) + "분 전";
			} else {
				return ChronoUnit.SECONDS.between(matchStartDateTime, currentDateTime) + "초 전";
			}
			
		} else {
			
			if (ChronoUnit.YEARS.between(matchStartDateTime, currentDateTime) >= 1) {
				return ChronoUnit.YEARS.between(matchStartDateTime, currentDateTime) + "년 전";
			}
			
			if (ChronoUnit.MONTHS.between(matchStartDateTime, currentDateTime) >= 1) {
				
				if (ChronoUnit.MONTHS.between(matchStartDateTime, currentDateTime) == 1) {
					return "한 달 전";
				} else {
					return ChronoUnit.MONTHS.between(matchStartDateTime, currentDateTime) + "달 전";
				}
				
			} else {
				
				if (ChronoUnit.DAYS.between(matchStartDateTime, currentDateTime) == 1) {
					return "하루 전";
				} else {
					return ChronoUnit.DAYS.between(matchStartDateTime, currentDateTime) + "일 전";
				}
				
			}
			
		}
		
	}
	
	public String getMatchDuration() {
		
	//	gameEndTimestamp필드가 응답에 있으면(0이 아니면) gameDuration필드의 값은 '초'
	//	gameEndTimestamp필드가 응답에 없으면(기본값 0이면) gameDuration필드의 값은 '밀리초'
		
		if (gameEndTimestamp != 0) {
			
			long hour = gameDuration / (60*60);
			long minute = (gameDuration / 60) - (hour*60);
			long second = gameDuration % 60;
			
			if (hour != 0) {
				return String.format("%d시간 %d분 %d초", hour, minute, second);
			} else {
				return String.format("%d분 %d초", minute, second);
			}
			
		} else {
			//	'밀리초'를 '초'로 변환
			long gameDuration = this.gameDuration / 1000;
			
			long hour = gameDuration / (60*60);
			long minute = (gameDuration / 60) - (hour*60);
			long second = gameDuration % 60;
			
			if (hour != 0) {
				return String.format("%d시간 %d분 %d초", hour, minute, second);
			} else {
				return String.format("%d분 %d초", minute, second);
			}
			
		}
		
	}
	
}