//	유효한 아이디, 비밀번호, 이름 등을 체크하기 위한 변수
//	유효한 값을 입력하면 1, 유효하지 않은 값을 입력하면 0
//	이메일은 선택적으로 입력하므로 미리 1을 넣어두고 잘못 입력하거나 중복될 때만 0이 됨
let validLoginId = 0;
let validLoginPw = 0;
let validName = 0;
let validNickname = 0;
let validBirthday = 0;
let validGender = 0;
let validEmail = 1;
let validCellphoneNum = 0;

//	비밀번호 일치 여부를 판단하기 위한 변수
let loginPw = '';
let loginPwChk = '';

function submitJoinForm(form) {
		
		if (validLoginId == 0) {
			form.loginId.focus();
			return;
		}
		
		if (validLoginPw == 0) {
			form.loginPw.focus();
			return;
		}
		
		if (validName == 0) {
			form.name.focus();
			return;
		}
		
		if (validNickname == 0) {
			form.nickname.focus();
			return;
		}
		
		if (validBirthday == 0) {
			form.birthday.focus();
			return;
		}
		
		if (validGender == 0) {
			form.gender.focus();
			return;
		}
		
		if (validEmail == 0) {
			form.email.focus();
			return;
		}
		
		if (validCellphoneNum == 0) {
			form.cellphoneNum.focus();
			return;
		}
		
		form.submit();
		
}

function loginIdDupCheck(input) {
	
	validLoginId = 0;
	
	input.value = input.value.trim();
	let value = input.value;
	let loginIdDupCheckMsg = $('#loginIdDupCheckMsg');
	
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
			validLoginId = 1;
		} else {
			loginIdDupCheckMsg.removeClass('text-green-400');
			loginIdDupCheckMsg.addClass('text-red-400');
			loginIdDupCheckMsg.html(`<span>${data.msg}</span>`);
		}
	}, 'json');
	
}

function pwCheck(input) {
	
	validLoginPw = 0;
	
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
		if (name == 'loginPw') {
			loginPw = '';
		} else {
			loginPwChk = '';
		}
		pwMsg.html('<span>필수 정보입니다.</span>');
		return;
	}
	
	const regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/;
	const hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
	if (name == 'loginPw') {
		if (!regex.test(value)) {
			loginPw = '';
			pwMsg.html('<span>8~16자 영문 대 소문자, 숫자, 특수문자(!@#$%^&*-?)를 사용하세요.</span>');
			return;
		} else if (value.search(/\s/) != -1) {
			loginPw = '';
			pwMsg.html('<span>비밀번호는 공백 없이 입력해 주세요.</span>');
			return;
		} else if (hangulcheck.test(value)) {
			loginPw = '';
			pwMsg.html('<span>비밀번호에 한글을 사용 할 수 없습니다.</span>');
			return;
		} else {
			pwMsg.html('');
			if(loginPw == loginPwChk) {
				$('#loginPwChkMsg').html('');
				validLoginPw = 1;
			}
			return;
		}
	}
	
	if (loginPw != loginPwChk) {
		$('#loginPwChkMsg').html('<span>비밀번호가 일치하지 않습니다.</span>');
		return;
	} else {
		$('#loginPwChkMsg').html('');
		validLoginPw = 1;
		return;
	}
	
}

function nameCheck(input) {
	
	validName = 0;
	
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
		validName = 1;
		return;
	}
	
}

function nicknameCheck(input) {
	
	validNickname = 0;
	
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
			validNickname = 1;
		} else {
			nicknameMsg.removeClass('text-green-400');
			nicknameMsg.addClass('text-red-400');
			nicknameMsg.html(`<span>${data.data1}(은)는 ${data.msg}</span>`);
		}
	}, 'json');
	
}

function birthdayCheck(input) {
	
	validBirthday = 0;
	
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
		birthdayMsg.html('<span>생년월일을 다시 확인해 주세요.</span>');
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
	
	validBirthday = 1;
	
}

function genderCheck(input) {
	
	validGender = 0;
	
	let genderMsg = $('#genderMsg');
	
	genderMsg.empty();
	
	if (input.value == '') {
		genderMsg.html('<span>필수 정보입니다.</span>')
		return;
	}
	
	validGender = 1;
	
}

function emailCheck(input) {
	
	validEmail = 0;
	
	input.value = input.value.trim();
	let value = input.value;
	let emailMsg = $('#emailMsg');
	
	emailMsg.empty();
	
	if (value.length == 0) {
		validEmail = 1;
		return
	}
	
	const regex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	if (!regex.test(value)) {
		emailMsg.html('<span>이메일 주소를 다시 확인해 주세요.</span>');
		return;
	}
	
	$.get('emailDupCheck', {
		email : value
	}, function(data) {
		if(data.success) {
			validEmail = 1;
		} else {
			emailMsg.html(`<span>${data.data1}(은)는 ${data.msg}</span>`);
		}
	}, 'json');
	
}

function cellphoneNumCheck(input) {
	
	validCellphoneNum = 0;
	
	input.value = input.value.trim();
	let value = input.value;
	let cellphoneNumMsg = $('#cellphoneNumMsg');
	
	cellphoneNumMsg.empty();
	
	if (value.length == 0) {
		cellphoneNumMsg.html('<span>필수 정보입니다.</span>');
		return;
	}
	
	const regex = /^(010)[0-9]{3,4}[0-9]{4}$/;
	
	if(!regex.test(value)) {
		cellphoneNumMsg.html('<span>형식에 맞지 않는 번호입니다. ( -, 공백 없이 숫자만 )</span>');
		return;
	}
	
	$.get('cellphoneNumDupCheck', {
		cellphoneNum : value
	}, function(data) {
		if(data.success) {
			validCellphoneNum = 1;
		} else {
			cellphoneNumMsg.html(`<span>${data.data1}(은)는 ${data.msg}</span>`);
		}
	}, 'json');
	
}