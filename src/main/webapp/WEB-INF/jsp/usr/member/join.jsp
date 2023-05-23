<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
<link rel="stylesheet" href="/resource/css/join.css" />
<!-- JS 파일 불러오기 -->
<script src="/resource/js/join.js"></script>
</head>
<body>
	<section class="text-lg my-20">
		<h1 class="logo flex justify-center">
			<a href="/">
				<img src="/resource/images/logo.png" alt="같이 할래?" width="380px">
			</a>
		</h1>
		<div class="mt-10 flex justify-center">
			<form action="doJoin" method="POST" onsubmit="submitJoinForm(this); return false;">
				<div>
					<label class="cursor-pointer">
						아이디
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="loginId" placeholder="아이디를 입력해주세요" onblur="loginIdDupCheck(this);"/>
					</label>
					<div id="loginIdDupCheckMsg" class="mt-2 h-5 text-xs text-red-400"></div>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						비밀번호
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="loginPw" placeholder="비밀번호를 입력해주세요"/>
					</label>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						비밀번호 재확인
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="loginPwChk" placeholder="비밀번호 재확인을 입력해주세요"/>
					</label>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						이름
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="name" placeholder="이름을 입력해주세요"/>
					</label>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						닉네임
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="nickname" placeholder="닉네임을 입력해주세요"/>
					</label>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						생년월일
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="date" name="birthday"/>
					</label>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						성별
						<br>
						<select class="cursor-pointer mt-2 select select-bordered select-info w-112" name="gender">
							<option selected value="">성별</option>
							<option value="male">남자</option>
							<option value="female">여자</option>
						</select>
					</label>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						이메일
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="email" name="email" placeholder="이메일을 입력해주세요"/>
					</label>
				</div>
				<div class="mt-4">
					<label class="cursor-pointer">
						휴대전화
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="tel" name="cellphoneNum" placeholder="휴대전화 번호를 입력해주세요"/>
					</label>
				</div>
				<div class="mt-4">
					<button class="btn-text-color btn btn-info w-112">가입하기</button>
				</div>
			</form>
		</div>
		<div class="mt-3 flex justify-center">
			<button class="btn-text-color btn btn-info w-112" onclick="history.back();">뒤로가기</button>
		</div>
	</section>
</body>
</html>