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
</head>
<body>
	<section class="min-w-800">
		<div class="py-4 border-b border-blue-300">
			<div class="text-center text-2xl font-bold">채팅방 생성</div>
		</div>
		<div class="my-4 flex justify-center text-lg">
			<form action="createChatRoom">
				<div>
					<label class="cursor-pointer">
						채팅방 제목
						<br>
						<input class="cursor-pointer input input-bordered input-info mt-2 w-112" type="text" name="name" placeholder="채팅방 제목을 입력해 주세요."/>
					</label>
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
				<div class="flex justify-end mt-4">
					<button class="btn-text-color btn btn-info" onclick="history.back(); return false;">취소</button>
					<button class="ml-2 btn-text-color btn btn-info">생성</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>