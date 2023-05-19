<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>같이 할래?</title>
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
<link rel="stylesheet" href="/resource/css/common.css" />
<script src="/resource/js/common.js"></script>
</head>
<body>
	<div class="top-bar flex container mx-auto bg-indigo-100 text-2xl">
		<h1 class="logo ml-4">
			<a href="/">
				<img src="/resource/images/logo1.png" alt="같이 할래?" width="150px">
			</a>
		</h1>
		<nav class="menu-box w-full flex justify-between ml-8 mr-4">
			<ul class="h-full flex">
				<li>
					<a href="/" class="topbar-text-link h-full flex items-center px-3 mx-1"><span>홈</span></a>
				</li>
				<li>
					<a href="#" class="topbar-text-link h-full flex items-center px-3 mx-1"><span>커뮤니티</span></a>
				</li>
			</ul>
			<ul class="h-full flex">
				<li>
					<div class="light-dark h-full flex items-center px-3 mx-1 light" onclick="lightDark(this);">
						<i class="fa-solid fa-sun"></i>
						<span class="light-dark-msg text-xs text-center bg-black text-white">Day mode</span>
					</div>
				</li>
				<li>
					<a href="#" class="topbar-text-link h-full flex items-center px-3 mx-1"><span>로그인</span></a>
				</li>
				<li>
					<a href="#" class="topbar-text-link h-full flex items-center px-3 mx-1"><span>회원가입</span></a>
				</li>
			</ul>
		</nav>
	</div>
</body>
</html>