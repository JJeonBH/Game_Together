<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<!-- 제이쿼리 불러오기 -->
	<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
	<!-- CSS 파일 불러오기 -->
	<link rel="stylesheet" href="/resource/css/chat.css" />
</head>
<body>
	<section class="min-w-800">
		<div id="connecting" class="bg-gray-200 text-center text-2xl py-2">
        	연결중..
        </div>
		<div id="chat" class="flex justify-center">
			<div>
				<input type="hidden" id="member-id" value="${member.id}">
				<input type="hidden" id="member-nickname" value="${member.nickname}">
				<input type="hidden" id="host-member-id" value="${chatRoom.memberId}">
				<div class="flex justify-center py-4 text-2xl font-semibold h-16">
					<h1>${chatRoom.name}</h1>
				</div>
				<div class="flex justify-center">
					<ul id="message-area"></ul>
				</div>
				<div class="flex justify-center">
					<form id="message-form" class="flex justify-center items-center">
						<input type="text" id="message-input" class="input input-bordered input-info my-2 w-108 h-10" autocomplete="off"/>
						<button class="btn-text-color btn btn-info btn-sm h-10 ml-2">보내기</button>
					</form>
				</div>
			</div>
			<div class="ml-2">
				<div class="h-16"></div>
				<div id="info">
					<div id="host" class="flex justify-center">
						<div>방장 : ${chatRoom.hostNickname}</div>
					</div>
					<ul id="member-list"></ul>
				</div>
				<div id="buttons" class="flex">
					<button id="exit-button" class="btn-text-color btn btn-info btn-sm my-2 h-10">나가기</button>
					<c:if test="${member.id == chatRoom.memberId}">
						<button id="delete-button" class="btn-text-color btn btn-info btn-sm my-2 ml-2 h-10">채팅방 삭제</button>
					</c:if>
				</div>
			</div>
		</div>
	</section>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script src="/resource/js/socket.js"></script>
</body>
</html>