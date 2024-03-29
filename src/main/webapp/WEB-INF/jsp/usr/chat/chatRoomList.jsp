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
	
		function canJoin(chatRoomId) {
			
			let memberId = ${Request.loginedMemberId};
			let can;
			
			$.ajax({
		        type: 'GET',
		        url: '/usr/chat/canJoin',
		        async: false,
		        data: {
		        	'chatRoomId': chatRoomId,
		        	'memberId': memberId
		        },
		        success: function (data) {
		        	if (data.fail) {
		        		alert(data.msg);
		        		can = false;
		        	} else {
		        		can = true;
		        	}
		        }
		    })
			
			return can;
			
		}
		
		function canCreate() {
			
			let memberId = ${Request.loginedMemberId};
			let can;
			
			$.ajax({
		        type: 'GET',
		        url: '/usr/chat/canCreate',
		        async: false,
		        data: {
		        	'memberId': memberId
		        },
		        success: function (data) {
		        	if (data.fail) {
		        		alert(data.msg);
		        		can = false;
		        	} else {
		        		can = true;
		        	}
		        }
		    })
			
			return can;
			
		}
		
		//	채팅방 리스트에서 채팅방 검색할 때 셀렉트 값(제목, 방장) 유지
		$(function() {
			
			$('select[data-value]').each(function(index, item) {
				
				const items = $(item);
				
				const defaultValue = items.attr('data-value').trim();
				
				if (defaultValue.length > 0) {
					items.val(defaultValue);
				}
				
			});
			
		})
		
	</script>
</head>
<body>
	<section class="min-w-800">
		<div class="flex justify-center text-3xl my-5">
			<div><a href="chatRoomList">채팅방 목록</a></div>
		</div>
		<div class="flex justify-center mb-3">
			<div class="w-4/5">
				<div class="flex justify-between items-center">
					<div>${chatRoomsCnt}개의 채팅방</div>
					<div>
						<form>
							<select data-value="${searchKeywordType}" class="select select-primary" name="searchKeywordType">
								<option value="name">제목</option>
								<option value="hostNickname">방장</option>
							</select>
							<input class="ml-1 input input-bordered input-info" name="searchKeyword" placeholder="검색어를 입력해 주세요." maxlength="20" value="${searchKeyword}"/>
							<button class="ml-1 btn-text-color btn btn-info btn-sm">검색</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="flex justify-center mb-3">
			<div class="table-box-type-1 w-4/5">
				<table class="w-full">
					<colgroup>
						<col width="120"/>
						<col />
						<col width="120"/>
						<col width="120"/>
					</colgroup>
					<thead>
						<tr>
							<th>공개 여부</th>
							<th>제목</th>
							<th>인원</th>
							<th>방장</th>
						</tr>
					</thead>
					<tbody>
					 	<c:forEach var="chatRoom" items="${chatRooms}">
					 		<tr>
					 			<td>${chatRoom.status == "public" ? "공개" : "비공개"}</td>
					 			<td>
					 				<c:choose>
					 					<c:when test="${chatRoom.status == 'public'}">
							 				<a href="joinChatRoom?chatRoomId=${chatRoom.id}" class="hover:underline" onclick="if (canJoin(${chatRoom.id}) == false) {return false;}">${chatRoom.name}</a>
					 					</c:when>
					 					<c:otherwise>
					 						<a href="chatRoomPasswordCheck?chatRoomId=${chatRoom.id}" class="hover:underline" onclick="if (canJoin(${chatRoom.id}) == false) {return false;}">${chatRoom.name}</a>
					 					</c:otherwise>
					 				</c:choose>
					 			</td>
					 			<td>${chatRoom.currentMemberCount} / ${chatRoom.maxMemberCount}</td>
					 			<td>${chatRoom.hostNickname}</td>
					 		</tr>
					 	</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="flex justify-center mb-3">
			<div class="w-4/5 flex justify-center items-center">
				<c:set var="pageBaseUri" value="chatRoomList?searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}" />
				<c:if test="${page > 1}">
					<a href="${pageBaseUri}&page=1" class="hover:text-blue-600 mx-1">«</a>
					<a href="${pageBaseUri}&page=${page - 1}" class="hover:text-blue-600 mx-1">&lt;</a>
					<span class="text-gray-300 mx-2">|</span>
				</c:if>
				<c:forEach begin="${startPage}" end="${endPage}" var="i">
					<a href="${pageBaseUri}&page=${i}" class="${page == i ? 'text-blue-600 border border-blue-600 p-1' : ''} mx-1 hover:underline">${i}</a>
				</c:forEach>
				<c:if test="${page < pagesCount}">
					<span class="text-gray-300 mx-2">|</span>
					<a href="${pageBaseUri}&page=${page + 1}" class="hover:text-blue-600 mx-1">&gt;</a>
					<a href="${pageBaseUri}&page=${pagesCount}" class="hover:text-blue-600 mx-1">»</a>
				</c:if>
			</div>
		</div>
		<div class="flex justify-center mb-3">
			<div class="flex justify-end w-4/5"><a href="createChatRoomForm" class="btn-text-color btn btn-info btn-sm" onclick="if (canCreate() == false) {return false;}">채팅방 생성</a></div>
		</div>
	</section>
</body>
</html>