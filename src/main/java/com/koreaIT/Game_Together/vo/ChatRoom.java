package com.koreaIT.Game_Together.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

//	Stomp 를 통해 pub/sub 를 사용하면 구독자 관리가 알아서 된다!!
//	따라서 따로 세션 관리를 하는 코드를 작성할 필도 없고,
//	메시지를 다른 세션의 클라이언트에게 발송하는 것도 구현 필요가 없다!
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatRoom {
	
	private int id;
	private LocalDateTime regDate;
	private int memberId;
	private String name;
	private int maxMemberCount;
	
	private String hostNickname;
	private int currentMemberCount;
	
}