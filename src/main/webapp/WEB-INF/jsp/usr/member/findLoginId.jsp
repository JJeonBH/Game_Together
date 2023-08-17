<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 찾기</title>
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
	<script type="text/javascript">
		function submitFindLoginIdForm(form) {
			
			form.name.value = form.name.value.trim();
			
			if (form.name.value.length == 0) {
				alert('이름을 입력해 주세요.');
				form.name.focus();
				return;
			}
			
			form.email.value = form.email.value.trim();
			
			if (form.email.value.length == 0) {
				alert('이메일을 입력해 주세요.');
				form.email.focus();
				return;
			}
			
			form.submit();
			
		}
	</script>
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
			<form action="doFindLoginId" method="POST" class="border border-red-200 p-5" onsubmit="submitFindLoginIdForm(this); return false;">
				<div>
					<label class="cursor-pointer">
						이름
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="name" placeholder="이름을 입력해 주세요."/>
					</label>
				</div>
				<div class="mt-5">
					<label class="cursor-pointer">
						이메일
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="email" name="email" placeholder="이메일을 입력해 주세요."/>
					</label>
				</div>
				<div class="mt-8">
					<button class="btn-text-color btn btn-info w-112">아이디 찾기</button>
				</div>
			</form>
		</div>
		<div class="mt-5 flex justify-center">
			<button onclick="history.back();" class="hover:underline">뒤로가기</button>
			<div class="mx-4">|</div>
			<a href="join" class="hover:underline">회원가입</a>
			<div class="mx-4">|</div>
			<a href="login" class="hover:underline">로그인</a>
			<div class="mx-4">|</div>
			<a href="findLoginPw" class="hover:underline">비밀번호 찾기</a>
		</div>
	</section>
</body>
</html>