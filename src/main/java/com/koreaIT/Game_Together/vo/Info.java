package com.koreaIT.Game_Together.vo;

import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Period;
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
		
		//	날짜만 가져오기
		LocalDate matchStartDate = matchStartDateTime.toLocalDate();
		LocalDate currentDate = currentDateTime.toLocalDate();
		
		//	시간만 가져오기
		LocalTime matchStartTime = matchStartDateTime.toLocalTime();
		LocalTime currentTime = currentDateTime.toLocalTime();
		
		if (matchStartDate.isEqual(currentDate)) {
			
			Duration diff = Duration.between(matchStartTime, currentTime);
			
			if (diff.toHours() >= 1) {
				return diff.toHours() + "시간 전";
			}
			
			if (diff.toMinutes() >= 1 && diff.toMinutes() < 60) {
				return diff.toMinutes() + "분 전";
			} else {
				return diff.getSeconds() + "초 전";
			}
			
		} else {
			
			Period diff = Period.between(matchStartDate, currentDate);
			
			if (diff.getYears() >= 1) {
				return diff.getYears() + "년 전";
			}
			
			if (diff.getMonths() >= 1) {
				
				if (diff.getMonths() == 1) {
					return "한 달 전";
				} else {
					return diff.getMonths() + "달 전";
				}
				
			} else {
				
				if (diff.getDays() == 1) {
					return "하루 전";
				} else {
					return diff.getDays() + "일 전";
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