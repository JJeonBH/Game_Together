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
</head>
<body>
	<section>
		<div>
			<table>
				<colgroup>
					<col />
					<col width="50"/>
					<col width="80"/>
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
				 			<td><a href="joinChatRoom?chatRoomId=${chatRoom.id}">${chatRoom.name}</a></td>
				 			<td>${chatRoom.currentMemberCount} / ${chatRoom.maxMemberCount}</td>
				 			<td>${chatRoom.hostNickname}</td>
				 		</tr>
				 	</c:forEach>
				</tbody>
			</table>
		</div>
		<div>
		</div>
	</section>
</body>
</html>