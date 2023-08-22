package com.koreaIT.Game_Together.util;

import java.security.MessageDigest;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Util {

	public static boolean isEmpty(Object obj) {

		if (obj == null) {
			return true;
		}

		String str = (String) obj;

		return str.trim().length() == 0;

	}

	public static String jsAlertHistoryBack(String msg) {

		if (msg == null) {
			msg = "";
		}

		return String.format("""
					<script>
						const msg = '%s'.trim();
						if (msg.length > 0) {
							alert(msg);
						}
						history.back();
					</script>
				""", msg);

	}

	public static String jsAlertReplace(String msg, String uri) {

		if (msg == null) {
			msg = "";
		}

		if (uri == null) {
			uri = "";
		}

		return String.format("""
					<script>
						const msg = '%s'.trim();
						if (msg.length > 0) {
							alert(msg);
						}
						location.replace('%s');
					</script>
				""", msg, uri);

	}

	public static String sha256(String base) {
		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(base.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();

			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}

			return hexString.toString();

		} catch (Exception ex) {
			return "";
		}
		
	}
	
	public static String formatDate(LocalDateTime date) {
		
		String formatDate = date.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일"));
		
		return formatDate;
		
	}
	
	//	detail.jsp에서 사용 (chatRoom.jsp, (member) list.jsp에서도 사용)
	public static String formatRegDateVer1(LocalDateTime regDate) {
		
		String formatRegDateVer1 = regDate.format(DateTimeFormatter.ofPattern("yyyy.MM.dd. HH:mm"));
		
		return formatRegDateVer1;
		
	}
	
	//	(article) list.jsp에서 사용
	public static String formatRegDateVer2(LocalDateTime regDate) {
		
		String formatRegDateVer2;
		
		//	현재 날짜, 시간
		LocalDateTime currentDateTime = LocalDateTime.now();
		
		//	시, 분, 초 제외한 작성 날짜와 현재 날짜 비교
		if (regDate.toLocalDate().isEqual(currentDateTime.toLocalDate())) {
			//	같다면 시:분 보여주기
			formatRegDateVer2 = regDate.format(DateTimeFormatter.ofPattern("HH:mm"));
		} else {
			//	다르다면 년.월.일. 보여주기
			formatRegDateVer2 = regDate.format(DateTimeFormatter.ofPattern("yyyy.MM.dd."));
		}
		
		return formatRegDateVer2;
		
	}
	
	public static String getTempPassword(int length) {
		
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
				'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };

		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());
			sb.append(charArr[index]);
		}

		return sb.toString();
		
	}

}