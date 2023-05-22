let validLoginId = '';

function submitJoinForm(form) {
		
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return;
		}
		
		if (form.loginId.value != validLoginId) {
			alert(form.loginId.value + '은(는) 이미 사용중이거나 탈퇴한 아이디입니다');
			form.loginId.value = '';
			form.loginId.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
		}
		
		form.loginPwChk.value = form.loginPwChk.value.trim();
		if (form.loginPwChk.value.length == 0) {
			alert('비밀번호 재확인을 입력해주세요');
			form.loginPwChk.focus();
			return;
		}
		
		if (form.loginPw.value != form.loginPwChk.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.value = '';
			form.loginPwChk.value = '';
			form.loginPw.focus();
			return;
		}
		
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}
		
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요');
			form.nickname.focus();
			return;
		}
		
		form.birthday.value = form.birthday.value.trim();
		if (form.birthday.value.length == 0) {
			alert('생년월일을 입력해주세요');
			form.birthday.focus();
			return;
		}
		
		form.gender.value = form.gender.value.trim();
		if (form.gender.value.length == 0) {
			alert('성별을 입력해주세요');
			form.gender.focus();
			return;
		}
		
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}
		
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value.length == 0) {
			alert('휴대전화 번호를 입력해주세요');
			form.cellphoneNum.focus();
			return;
		}
		
		form.submit();
		
}

function loginIdDupCheck(input) {
	
	let loginIdDupCheckMsg = $('#loginIdDupCheckMsg');
	
	loginIdDupCheckMsg.empty();
	
	input.value = input.value.trim();
	
	if (input.value.length == 0) {
		loginIdDupCheckMsg.removeClass('text-green-400');
		loginIdDupCheckMsg.addClass('text-red-400');
		loginIdDupCheckMsg.html('<span>필수 정보입니다</span>');
		return;
	}
	
	$.get('loginIdDupCheck', {
		loginId : input.value
	}, function(data) {
		if(data.success) {
			loginIdDupCheckMsg.removeClass('text-red-400');
			loginIdDupCheckMsg.addClass('text-green-400');
			loginIdDupCheckMsg.html(`<span>${data.msg}</span>`);
			validLoginId = data.data1;
		} else {
			loginIdDupCheckMsg.removeClass('text-green-400');
			loginIdDupCheckMsg.addClass('text-red-400');
			loginIdDupCheckMsg.html(`<span>${data.msg}</span>`);
			validLoginId = '';
		}
	}, 'json');
	
}