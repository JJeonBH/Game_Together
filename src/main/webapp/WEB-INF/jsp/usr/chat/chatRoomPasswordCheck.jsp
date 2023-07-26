<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>채팅방 비밀번호 확인 - 같이 할래?</title>
	<!-- 파비콘 불러오기 -->
	<link rel="shortcut icon" href="/resource/images/favicon.ico" />
	<!-- 테일윈드 불러오기 -->
	<!-- 노말라이즈 -->
	<script src="https://cdn.tailwindcss.com"></script>
	<!-- 데이지 UI 불러오기 -->
	<link href="https://cdn.jsdelivr.net/npm/daisyui@2.51.6/dist/full.css" rel="stylesheet" type="text/css" />
	<!-- 제이쿼리 불러오기 -->
	<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
	<!-- CSS 파일 불러오기 -->
	<link rel="stylesheet" href="/resource/css/chat.css" />
	<script>
	
		function passwordCheck(form) {
			
			let password = $('#password');
			let passwordMsg = $('#passwordMsg');
			
			password.val(password.val().trim());
			let value = password.val();
			
			passwordMsg.empty();
			
			//	정규식 안쓰고 length 로 체크
			if (value.length < 4 || value.length > 8) {
				passwordMsg.html('<span>채팅방 비밀번호를 입력해 주세요. (4 ~ 8글자)</span>');
				password.focus();
				return;
			} else if (value.search(/\s/) != -1) {
				passwordMsg.html('<span>비밀번호는 공백 없이 입력해 주세요.</span>');
				password.focus();
				return;
			}
			
			let chatRoomId = form.chatRoomId.value;
			
			$.ajax({
		        type: 'GET',
		        url: '/usr/chat/passwordCheck',
		        data: {
		        	'chatRoomId': chatRoomId,
		            'password': value
		        },
		        success: function (data) {
		        	if (data.fail) {
		        		passwordMsg.html('<span>' + data.msg + '</span>');
						password.focus();
						return;
		        	} else {
		        		form.submit();
		        	}
		        }
		    })
			
		}
	
	</script>
</head>
<body>
	<section class="min-w-800">
		<div class="py-4 border-b border-blue-300">
			<div class="text-center text-2xl font-semibold">채팅방 비밀번호 확인</div>
		</div>
		<div class="my-4 flex justify-center text-lg">
			<form action="joinChatRoom" onsubmit="passwordCheck(this); return false;">
				<input type="hidden" name="chatRoomId" value="${chatRoomId}"/>
				<div>
					<label class="cursor-pointer">
						채팅방 비밀번호
						<br>
						<input id="password" class="cursor-pointer input input-bordered input-info mt-2 w-64" type="text"/>
					</label>
					<div id="passwordMsg" class="mt-2 h-5 text-xs text-red-400"></div>
				</div>
				<div class="flex justify-end mt-4">
					<button class="btn-text-color btn btn-info" onclick="history.back(); return false;">취소</button>
					<button class="ml-2 btn-text-color btn btn-info">입장</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>