package com.koreaIT.Game_Together.util;

public class Util {

	public static boolean empty(Object obj) {

		if (obj == null) {
			return true;
		}

		String str = (String) obj;

		return str.trim().length() == 0;
		
	}

	public static String jsHistoryBack(String msg) {

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

	public static String jsReplace(String msg, String uri) {
		
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
	
}