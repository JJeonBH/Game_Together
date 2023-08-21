function submitLoginForm(form) {
	
	let loginMsg = $('#loginMsg');
	
	loginMsg.empty();
	
	form.loginId.value = form.loginId.value.trim();
	
	if (form.loginId.value.length == 0) {
		loginMsg.html("아이디를 입력해 주세요.");
		return;
	}
	
	form.loginPw.value = form.loginPw.value.trim();
	
	if (form.loginPw.value.length == 0) {
		loginMsg.html("비밀번호를 입력해 주세요.");
		return;
	}
	
	new Promise((resolve, reject) => {
				
		$.ajax({
	        type: 'POST',
	        url: '/usr/member/checkLogin',
	        dataType: 'json',
	        data: {
				'loginId' : form.loginId.value,
	            'loginPw' : form.loginPw.value
	        },
	        success: function (data) {
	        	resolve(data);
	        },
	        fail: function (error) {
	        	reject(error);
	        }
	    })
			    
	})
	.then((resultData) => {
		
		if (resultData.fail) {
			
			if (resultData.resultCode == 'F-3') {
				
				if (confirm(resultData.msg)) {
					
					$.ajax({
				        type: 'POST',
				        url: '/usr/member/restore',
				        dataType: 'json',
				        data: {
							'loginId' : form.loginId.value,
				            'loginPw' : form.loginPw.value
				        },
				        success: function (data) {
							alert(data.msg);
							form.submit();
				        }
	    			})
					
				} else {
					loginMsg.html("회원 탈퇴한 계정입니다.");
				}
				
			} else {
				loginMsg.html(resultData.msg);
			}
			
		} else {
			form.submit();
		}
		
	})
	.catch((error) => {
		
		alert(error);
		
	})
	
}