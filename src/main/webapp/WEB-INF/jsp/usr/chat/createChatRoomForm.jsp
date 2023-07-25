<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>채팅방 생성 - 같이 할래?</title>
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
	
		//	유효한 값을 입력했는지 체크하기 위한 변수
		//	유효한 값을 입력하면 1, 유효하지 않은 값을 입력하면 0
		//	채팅방 비밀번호는 공개방일 때는 입력하지 않아도 되므로 미리 1을 넣어둠(페이지를 처음 열면 checked 속성 때문에 공개방으로 선택되어 있음)
		//	비공개방 선택하면 0으로 바뀐 후에 유효한 비밀번호를 입력하면 1로 바뀜
		let validChatRoomName = 0;
		let validPassword = 1;
		
		//	생성 버튼 누를 때 채팅방 제목, 채팅방 비밀번호(비공개방) 제대로 입력했는지 체크 후 submit 되도록
		function submitCreateChatRoomForm(form) {
			
			if (validChatRoomName == 0) {
				form.name.focus();
				return;
			}
			
			if (validPassword == 0) {
				form.password.focus();
				return;
			}
			
			form.submit();
			
		}
		
		//	채팅방 제목 20자 이내로 입력했는지 체크
		function chatRoomNameCheck(input) {
			
			validChatRoomName = 0;
			
			input.value = input.value.trim();
			let value = input.value;
			let nameMsg = $('#nameMsg');
			
			nameMsg.empty();
			
			const regex = /^.{1,20}$/;
			
			if(!regex.test(value)) {
				nameMsg.html('<span>채팅방 제목을 입력해 주세요. (최대 20글자)</span>');
				return;
			}
			
			validChatRoomName = 1;
			
		}
		
		$(document).ready(function() {
			
			//	공개방일 때는 비밀번호 입력 못하게, 비공개방일 때는 비밀번호 입력할 수 있게
			$('input[name="status"]').change(function() {
				
				let passwordMsg = $('#passwordMsg');
				
				if ($('input[name="status"]:checked').val() == 'public') {
					$('input[name="password"]').val('');
					$('input[name="password"]').attr('disabled', 'disabled');
					passwordMsg.empty();
					validPassword = 1;
				} else {
					$('input[name="password"]').removeAttr('disabled');
					validPassword = 0;
				}
				
			});
			
		});
		
		//	비밀번호 유효성 검사
		function passwordCheck(input) {
			
			validPassword = 0;
			
			input.value = input.value.trim();
			let value = input.value;
			let passwordMsg = $('#passwordMsg');
			
			passwordMsg.empty();
			
			const regex = /^.{4,8}$/;
			
			if(!regex.test(value)) {
				passwordMsg.html('<span>채팅방 비밀번호를 입력해 주세요. (4 ~ 8글자)</span>');
				return;
			} else if (value.search(/\s/) != -1) {
				passwordMsg.html('<span>비밀번호는 공백 없이 입력해 주세요.</span>');
				return;
			}
			
			validPassword = 1;
			
		}
		
	</script>
</head>
<body>
	<section class="min-w-800">
		<div class="py-4 border-b border-blue-300">
			<div class="text-center text-2xl font-bold">채팅방 생성</div>
		</div>
		<div class="my-4 flex justify-center text-lg">
			<form action="createChatRoom" method="POST" onsubmit="submitCreateChatRoomForm(this); return false;">
				<div>
					<label class="cursor-pointer">
						채팅방 제목
						<br>
						<input class="cursor-pointer input input-bordered input-info mt-2 w-112" type="text" name="name" placeholder="채팅방 제목을 입력해 주세요." onblur="chatRoomNameCheck(this);"/>
					</label>
					<div id="nameMsg" class="mt-2 h-5 text-xs text-red-400"></div>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						채팅방 최대 인원수
						<br>
						<select class="select select-primary mt-2" name="maxMemberCount">
							<c:forEach begin="2" end="10" var="i">
								<option value="${i}">${i}</option>
							</c:forEach>
						</select>
					</label>
				</div>
				<div class="mt-11">
					<div>공개 선택</div>
					<div class="mt-2">
						<label class="cursor-pointer">
							<input class="cursor-pointer" type="radio" name="status" value="public" checked="checked"/>
							공개방
						</label>
						<label class="cursor-pointer ml-4">
							<input class="cursor-pointer" type="radio" name="status" value="private"/>
							비공개방
						</label>
					</div>
				</div>
				<div class="mt-11">
					<label class="cursor-pointer">
						채팅방 비밀번호
						<br>
						<input class="cursor-pointer input input-bordered input-info mt-2 w-56" type="text" name="password" disabled="disabled" onblur="passwordCheck(this);"/>
					</label>
					<div id="passwordMsg" class="mt-2 h-5 text-xs text-red-400"></div>
				</div>
				<div class="flex justify-end mt-4">
					<button class="btn-text-color btn btn-info" onclick="history.back(); return false;">취소</button>
					<button class="ml-2 btn-text-color btn btn-info">생성</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>