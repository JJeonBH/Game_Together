<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="같이 할래?"></c:set>
<%@ include file="../common/head.jsp" %>
	<section class="mt-6 mb-20 text-lg min-w-1000">
		<div class="flex justify-center">
			<form action="../lol/search" method="POST" onsubmit="submitSearchForm(this); return false;">
				<input class="cursor-pointer input input-bordered input-info w-96 mr-2" type="text" name="summonerName" placeholder="소환사명을 입력해주세요."/>
				<button class="btn-text-color btn btn-info">검색</button>
			</form>
		</div>
		<c:if test="${summoner != null}">
			<div class="mt-4 px-20 flex justify-center">
				<div class="summoner-icon">
					<img src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/profileicon/${summoner.profileIconId}.png" width="180" alt="profile icon"/>
					<div class="summoner-level text-sm text-black">${summoner.summonerLevel}</div>
				</div>
				<div class="mx-4 text-2xl font-bold">${summoner.name}</div>
				<div class="mx-4 flex items-center" >
					<c:if test="${summoner.leagueEntry.size() != 0}">
						<div class="text-center">
							<div>솔로랭크</div>
							<div><img src="/resource/images/emblem-${summoner.leagueEntry.get(0).tier}.png" alt="tier emblem" width="150"/></div>
						</div>
						<div class="mx-5 text-center">
							<div>${summoner.leagueEntry.get(0).tier} ${summoner.leagueEntry.get(0).rank}</div>
							<div class="text-sm">${summoner.leagueEntry.get(0).leaguePoints} LP</div>
						</div>
						<div class="text-sm text-right">
							<span>${summoner.leagueEntry.get(0).wins} 승</span>
							<span>${summoner.leagueEntry.get(0).losses} 패</span>
							<div class="text-xs">
								승률 ${Math.round(summoner.leagueEntry.get(0).wins / (summoner.leagueEntry.get(0).wins + summoner.leagueEntry.get(0).losses) * 100)} %
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</c:if>
		<div class="mt-4 px-20 flex">
			<div class="w-1/2 h-80 border border-indigo-400">공지사항</div>
			<div class="ml-4 w-1/2 h-80 border border-indigo-400">인기글</div>
		</div>
		<div class="mt-4 px-20 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
		<div class="mt-4 px-20 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
		<div class="mt-4 px-20 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>