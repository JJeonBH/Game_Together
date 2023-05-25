// 유효한 아이디, 비밀번호, 이름 등을 저장하는 변수
let validLoginId = '';
let validLoginPw = '';
let validName = '';
let validNickname = '';
let validBirthday = '';

// 비밀번호 일치 여부를 판단하기 위한 변수
let loginPw = '';
let loginPwChk = '';

function submitJoinForm(form) {
		
		if (validLoginId == '') {
			form.loginId.focus();
			return;
		}
		
		if (validLoginPw == '') {
			form.loginPw.focus();
			return;
		}
		
		if (validName == '') {
			form.name.focus();
			return;
		}
		
		if (validNickname == '') {
			form.nickname.focus();
			return;
		}
		
		if (validBirthday == '') {
			form.birthday.focus();
			return;
		}
		
//		form.loginId.value = form.loginId.value.trim();
//		if (form.loginId.value.length == 0) {
//			alert('아이디를 입력해주세요.');
//			form.loginId.focus();
//			return;
//		}
		
//		if (form.loginId.value != validLoginId) {
//			alert(form.loginId.value + '은(는) 사용할 수 없는 아이디입니다.');
//			form.loginId.value = '';
//			form.loginId.focus();
//			return;
//		}
		
//		form.loginPw.value = form.loginPw.value.trim();
//		if (form.loginPw.value.length == 0) {
//			alert('비밀번호를 입력해주세요.');
//			form.loginPw.focus();
//			return;
//		}
		
//		form.loginPwChk.value = form.loginPwChk.value.trim();
//		if (form.loginPwChk.value.length == 0) {
//			alert('비밀번호 재확인을 입력해주세요.');
//			form.loginPwChk.focus();
//			return;
//		}
		
//		if (form.loginPw.value != form.loginPwChk.value) {
//			alert('비밀번호가 일치하지 않습니다.');
//			form.loginPw.value = '';
//			form.loginPwChk.value = '';
//			form.loginPw.focus();
//			return;
//		}
		
//		form.name.value = form.name.value.trim();
//		if (form.name.value.length == 0) {
//			alert('이름을 입력해주세요.');
//			form.name.focus();
//			return;
//		}
		
//		form.nickname.value = form.nickname.value.trim();
//		if (form.nickname.value.length == 0) {
//			alert('닉네임을 입력해주세요.');
//			form.nickname.focus();
//			return;
//		}
		
		form.birthday.value = form.birthday.value.trim();
		if (form.birthday.value.length == 0) {
			alert('생년월일을 입력해주세요.');
			form.birthday.focus();
			return;
		}
		
		form.gender.value = form.gender.value.trim();
		if (form.gender.value.length == 0) {
			alert('성별을 입력해주세요.');
			form.gender.focus();
			return;
		}
		
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}
		
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value.length == 0) {
			alert('휴대전화 번호를 입력해주세요.');
			form.cellphoneNum.focus();
			return;
		}
		
		form.submit();
		
}

function loginIdDupCheck(input) {
	
	validLoginId = '';
	
	let loginIdDupCheckMsg = $('#loginIdDupCheckMsg');
	input.value = input.value.trim();
	let value = input.value;
	
	loginIdDupCheckMsg.empty();
	
	if (value.length == 0) {
		loginIdDupCheckMsg.removeClass('text-green-400');
		loginIdDupCheckMsg.addClass('text-red-400');
		loginIdDupCheckMsg.html('<span>필수 정보입니다.</span>');
		return;
	}
	
	const regex = /^[a-z]{1}[a-z0-9_-]{4,19}$/;
	
	if(!regex.test(value)) {
		loginIdDupCheckMsg.removeClass('text-green-400');
		loginIdDupCheckMsg.addClass('text-red-400');
		loginIdDupCheckMsg.html('<span>5~20자의 영문 소문자(로 시작), 숫자와 특수기호(_),(-)만 사용 가능합니다.</span>');
		return;
	}
	
	$.get('loginIdDupCheck', {
		loginId : value
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
		}
	}, 'json');
	
}

function pwCheck(input) {
	
	validLoginPw = '';
	
	let name = input.getAttribute('name');
	input.value = input.value.trim();
	let value = input.value;
	let pwMsg = '';
	
	if (name == 'loginPw') {
		loginPw = value;
		pwMsg = $('#' + 'loginPwMsg');
	} else {
		loginPwChk = value;
		pwMsg = $('#' + 'loginPwChkMsg');
	}

	pwMsg.empty();
	
	if (value.length == 0) {
		pwMsg.html('<span>필수 정보입니다.</span>');
		return;
	}
	
	const regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/;
	const hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
	if (name == 'loginPw') {
		if (!regex.test(value)) {
			pwMsg.html('<span>8~16자 영문 대 소문자, 숫자, 특수문자(!@#$%^&*-?)를 사용하세요.</span>');
			return;
		} else if (value.search(/\s/) != -1) {
			pwMsg.html('<span>비밀번호는 공백 없이 입력해주세요.</span>');
			return;
		} else if (hangulcheck.test(value)) {
			pwMsg.html('<span>비밀번호에 한글을 사용 할 수 없습니다.</span>');
			return;
		} else {
			pwMsg.html('');
			if(loginPw == loginPwChk) {
				validLoginPw = loginPw;
			}
			return;
		}
	}
	
	if (loginPw != loginPwChk) {
		$('#loginPwChkMsg').html('<span>비밀번호가 일치하지 않습니다.</span>');
		return;
	} else {
		$('#loginPwChkMsg').html('');
		validLoginPw = loginPw;
		return;
	}
	
}

function nameCheck(input) {
	
	validName = '';
	
	input.value = input.value.trim();
	let value = input.value;
	let nameMsg = $('#nameMsg');
	
	nameMsg.empty();
	
	if (value.length == 0) {
		nameMsg.html('<span>필수 정보입니다.</span>');
		return;
	}
	
	const regex = /^[가-힣a-zA-Z]+$/;
	
	if (!regex.test(value)) {
		nameMsg.html('<span>한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)</span>');
		return;
	} else {
		nameMsg.html('');
		validName = value;
		return;
	}
	
}

function nicknameCheck(input) {
	
	validNickname = '';
	
	input.value = input.value.trim();
	let value = input.value;
	let nicknameMsg = $('#nicknameMsg');
	
	nicknameMsg.empty();
	
	if (value.length == 0) {
		nicknameMsg.removeClass('text-green-400');
		nicknameMsg.addClass('text-red-400');
		nicknameMsg.html('<span>필수 정보입니다.</span>');
		return;
	}
	
	const regex = /^[가-힣a-zA-Z0-9]{2,10}$/;
	
	if (!regex.test(value)) {
		nicknameMsg.removeClass('text-green-400');
		nicknameMsg.addClass('text-red-400');
		nicknameMsg.html('<span>2~10자의 한글과 영문 대 소문자, 숫자를 사용하세요. (특수기호, 공백 사용 불가)</span>');
		return;
	}
	
	$.get('nicknameDupCheck', {
		nickname : value
	}, function(data) {
		if(data.success) {
			nicknameMsg.removeClass('text-red-400');
			nicknameMsg.addClass('text-green-400');
			nicknameMsg.html(`<span>${data.data1}(은)는 ${data.msg}</span>`);
			validNickname = data.data1;
		} else {
			nicknameMsg.removeClass('text-green-400');
			nicknameMsg.addClass('text-red-400');
			nicknameMsg.html(`<span>${data.data1}(은)는 ${data.msg}</span>`);
		}
	}, 'json');
	
}

function birthdayCheck(input) {
	
	validBirthday = '';
	
	input.value = input.value.trim();
	let value = input.value;
	let birthdayMsg = $('#birthdayMsg');
	
	birthdayMsg.empty();
	
	if (value.length == 0) {
		birthdayMsg.html('<span>필수 정보입니다.</span>');
		return;
	}
	
//	자리수 체크
	const numberOfDigits = /^[0-9]{8}$/;
	
	if (!numberOfDigits.test(value)) {
		birthdayMsg.html('<span>생년월일은 8자리 숫자로 입력해 주세요.</span>');
		return;
	}
	
//	생년월일 제대로 입력했는지 체크
	const regex = /^(19[0-9][0-9]|20\d{2})(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
	
	if (!regex.test(value)) {
		birthdayMsg.html('<span>생년월일을 다시 확인해주세요.</span>');
		return;
	}

	let date = new Date();
	
	let year = date.getFullYear();
	let month = date.getMonth() +1;
	let day = date.getDate();
	
	let today = year + '.' + month + '.' + day;
	let age14 = (year-14) + '.' + month + '.' + day;
	value = value.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');
	
//	현재 날짜를 millisecond로 변환
	const date1 = Date.parse(today);
//	만 14세 되는 날짜를 millisecond로 변환
	const date2 = Date.parse(age14);
//	입력 받은 날짜를 millisecond로 변환
	const date3 = Date.parse(value);
	
	if (date3 > date1) {
		birthdayMsg.html('<span>미래에서 오셨군요. ^^</span>');
		return;
	}
	
	if (date3 > date2) {
		birthdayMsg.html('<span>만 14세 미만의 어린이는 보호자의 동의가 필요합니다.</span>');
		return;
	}
	
	validBirthday = input.value;
	
}
