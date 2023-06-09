<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="같이 할래?"/>
<%@ include file="../common/head.jsp" %>
	<section class="mt-6 mx-20 text-lg min-w-1000">
		<div class="flex justify-center">
			<form action="../lol/search" method="POST" onsubmit="submitSearchForm(this); return false;">
				<input class="cursor-pointer input input-bordered input-info w-96 mr-1" type="text" name="summonerName" placeholder="소환사명을 입력해주세요."/>
				<button class="btn-text-color btn btn-info">검색</button>
			</form>
		</div>
	</section>
<%@ include file="../lol/summonerInfo.jsp" %>
<%@ include file="../lol/summonerMatchesInfo.jsp" %>
<%@ include file="../lol/summonerMatches.jsp" %>
	<section class="mt-6 mx-20 text-lg min-w-1000">
		<div class="mt-4 flex">
			<div class="w-1/2 h-80 border border-indigo-400">공지사항</div>
			<div class="ml-4 w-1/2 h-80 border border-indigo-400">인기글</div>
		</div>
	</section>
	<section class="mt-6 mb-20 mx-20 text-lg min-w-1000">
		<div class="mt-6 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
		<div class="mt-6 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
		<div class="mt-6 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>