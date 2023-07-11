<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<!-- 파비콘 불러오기 -->
	<link rel="shortcut icon" href="/resource/images/favicon.ico" />
	<!-- 테일윈드 불러오기 -->
	<!-- 노말라이즈 -->
	<script src="https://cdn.tailwindcss.com"></script>
	<!-- 데이지 UI 불러오기 -->
	<link href="https://cdn.jsdelivr.net/npm/daisyui@2.51.6/dist/full.css" rel="stylesheet" type="text/css" />
	<!-- 제이쿼리 불러오기 -->
	<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
	<!-- 폰트어썸 불러오기 -->
	<script src="https://kit.fontawesome.com/c186b4187f.js" crossorigin="anonymous"></script>
	<!-- CSS 파일 불러오기 -->
	<link rel="stylesheet" href="/resource/css/common.css" />
	<!-- JS 파일 불러오기 -->
	<script src="/resource/js/login.js" defer="defer"></script>
</head>
<body>
	<header class="text-lg mt-14">
		<h1 class="logo flex justify-center">
			<a href="/">
				<img src="/resource/images/logo.png" alt="같이 할래?" width="380px">
			</a>
		</h1>
	</header>
	<section class="text-lg mt-10 mb-20">
		<div class="flex justify-center">
			<form action="doLogin" method="POST" class="border border-red-200 p-5" onsubmit="submitLoginForm(this); return false;">
				<div>
					<label class="cursor-pointer">
						아이디
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="loginId" placeholder="아이디를 입력해 주세요."/>
					</label>
				</div>
				<div class="mt-5">
					<label class="cursor-pointer">
						비밀번호
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="loginPw" placeholder="비밀번호를 입력해 주세요."/>
					</label>
				</div>
				<div id="loginMsg" class="mt-2 h-5 text-xs text-red-400"></div>
				<div class="mt-8">
					<button class="btn-text-color btn btn-info w-112">로그인</button>
				</div>
			</form>
		</div>
		<div class="mt-5 flex justify-center">
			<button onclick="history.back();">뒤로가기</button>
			<div class="mx-4">|</div>
			<a href="join">회원가입</a>
		</div>
	</section>
</body>
</html>