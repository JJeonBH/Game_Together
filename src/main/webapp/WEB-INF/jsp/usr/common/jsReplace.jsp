<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	let msg = '${msg}'.trim();
	let uri = '${uri}'.trim();
	
	// falsy
	if (msg) {
		alert(msg);
	}
	
	location.replace(uri);
	
</script>