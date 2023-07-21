<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>채팅방 목록 - 같이 할래?</title>
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
	
		function alreadyJoinCheck() {
			//	이미 채팅방에 접속해 있는지 확인
		}
		
	</script>
</head>
<body>
	<section class="min-w-800">
		<div class="flex justify-center text-3xl my-5">
			<div>채팅방 목록</div>
		</div>
		<div class="flex justify-center">
			<div class="table-box-type-1 w-4/5">
				<table class="w-full">
					<colgroup>
						<col />
						<col width="120"/>
						<col width="120"/>
					</colgroup>
					<thead>
						<tr>
							<th>제목</th>
							<th>인원</th>
							<th>방장</th>
						</tr>
					</thead>
					<tbody>
					 	<c:forEach var="chatRoom" items="${chatRooms}">
					 		<tr>
					 			<td><a href="joinChatRoom?chatRoomId=${chatRoom.id}" onclick="alreadyJoinCheck();">${chatRoom.name}</a></td>
					 			<td>${chatRoom.currentMemberCount} / ${chatRoom.maxMemberCount}</td>
					 			<td>${chatRoom.hostNickname}</td>
					 		</tr>
					 	</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="flex justify-center">
			<div class="flex justify-end w-4/5"><a href="createChatRoomForm" class="btn-text-color btn btn-info btn-sm my-4">채팅방 생성</a></div>
		</div>
	</section>
</body>
</html>