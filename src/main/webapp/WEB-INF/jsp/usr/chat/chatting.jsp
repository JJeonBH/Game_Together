<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 - 같이 할래?</title>
<!-- 파비콘 불러오기 -->
<link rel="shortcut icon" href="/resource/images/favicon.ico" />
<!-- 테일윈드 불러오기 -->
<!-- 노말라이즈 -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- 데이지 UI 불러오기 -->
<link href="https://cdn.jsdelivr.net/npm/daisyui@2.51.6/dist/full.css" rel="stylesheet" type="text/css" />
<!-- CSS 파일 불러오기 -->
<link rel='stylesheet' href='/resource/css/chat.css'>
</head>
<body>
	<section>
		<div id='chat'>
			<input type='hidden' id='member-id' value='${member.id}'>
			<input type='hidden' id='member-nickname' value='${member.nickname}'>
			<div class="flex justify-center my-4 text-lg font-semibold">
				<h1>채팅방</h1>
			</div>
			<div class="flex justify-center">
				<div id='talk' class="border border-blue-400"></div>
			</div>
			<div class="flex justify-center">
				<textarea id='msg' class="textarea textarea-info my-2"></textarea>
			</div>
			<div class="flex justify-center">
				<div class="w-500px flex justify-end">
					<button id='send-btn' class="btn btn-info w-16 text-white hover:text-black mb-2">전송</button>
				</div>
			</div>
		</div>
		<!-- JS 파일 불러오기 -->
		<script src='/resource/js/chat.js'></script>
	</section>
</body>
</html>