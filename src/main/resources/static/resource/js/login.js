function submitLoginForm(form) {
	
	let loginMsg = $('#loginMsg');
	
	loginMsg.empty();
	
	form.loginId.value = form.loginId.value.trim();
	
	if (form.loginId.value.length == 0) {
		loginMsg.html("아이디를 입력해 주세요");
		return;
	}
	
	form.loginPw.value = form.loginPw.value.trim();
	
	if (form.loginPw.value.length == 0) {
		loginMsg.html("비밀번호를 입력해 주세요");
		return;
	}
	
	$.get('checkLogin', {
		loginId : form.loginId.value,
		loginPw : form.loginPw.value
	}, function(data) {
		if(data.success) {
			form.submit();
		} else {
			loginMsg.html(data.msg);
			return;
		}
	}, 'json');
	
}