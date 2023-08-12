<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="같이 할래?"/>
<%@ include file="../common/head.jsp" %>
	<section class="mt-6 mx-20 text-lg min-w-1000">
		<div class="flex justify-center">
			<form action="../lol/search" method="POST" onsubmit="submitSummonerSearchForm(this); return false;">
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
			<div class="w-1/2 h-80 border border-indigo-400 max-w-670">
				<div class="h-1/2 border-b border-indigo-400">
					<div class="text-lg text-blue-500 border-b border-indigo-400 p-2">
						롤 공지사항
					</div>
					<c:forEach var="lolNoticeArticle" items="${lolNoticeArticles}">
						<div class="notice flex p-1">
							<div class="w-2/3">
								<a href="../article/detail?articleId=${lolNoticeArticle.id}&boardType=${lolNoticeArticle.boardType}&boardId=${lolNoticeArticle.boardId}" class="hover:underline pl-1">${lolNoticeArticle.title}</a>
							</div>
							<div class="w-1/6 text-center">${lolNoticeArticle.writerNickname}</div>
							<div class="w-1/6 text-center">${lolNoticeArticle.formatRegDate}</div>
						</div>
					</c:forEach>
				</div>
				<div class="h-1/2">
					<div class="text-lg text-green-500 border-b border-indigo-400 p-2">
						배그 공지사항
					</div>
					<c:forEach var="bgNoticeArticle" items="${bgNoticeArticles}">
						<div class="notice flex p-1">
							<div class="w-2/3">
								<a href="../article/detail?articleId=${bgNoticeArticle.id}&boardType=${bgNoticeArticle.boardType}&boardId=${bgNoticeArticle.boardId}" class="hover:underline pl-1">${bgNoticeArticle.title}</a>
							</div>
							<div class="w-1/6 text-center">${bgNoticeArticle.writerNickname}</div>
							<div class="w-1/6 text-center">${bgNoticeArticle.formatRegDate}</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="ml-4 w-1/2 h-80 border border-indigo-400 max-w-670">
				<div class="h-1/2 border-b border-indigo-400">
					<div class="text-lg text-blue-500 border-b border-indigo-400 p-2">
						롤 인기글
					</div>
					<c:forEach var="lolHighReactionPointArticle" items="${lolHighReactionPointArticles}">
						<div class="high-reaction-point flex p-1">
							<div class="w-2/3">
								<a href="../article/detail?articleId=${lolHighReactionPointArticle.id}&boardType=${lolHighReactionPointArticle.boardType}&boardId=${lolHighReactionPointArticle.boardId}" class="hover:underline pl-1">${lolHighReactionPointArticle.title}</a>
							</div>
							<div class="w-1/6 text-center">${lolHighReactionPointArticle.writerNickname}</div>
							<div class="w-1/6 text-center">${lolHighReactionPointArticle.formatRegDate}</div>
						</div>
					</c:forEach>
				</div>
				<div class="h-1/2">
					<div class="text-lg text-green-500 border-b border-indigo-400 p-2">
						배그 인기글
					</div>
					<c:forEach var="bgHighReactionPointArticle" items="${bgHighReactionPointArticles}">
						<div class="high-reaction-point flex p-1">
							<div class="w-2/3">
								<a href="../article/detail?articleId=${bgHighReactionPointArticle.id}&boardType=${bgHighReactionPointArticle.boardType}&boardId=${bgHighReactionPointArticle.boardId}" class="hover:underline pl-1">${bgHighReactionPointArticle.title}</a>
							</div>
							<div class="w-1/6 text-center">${bgHighReactionPointArticle.writerNickname}</div>
							<div class="w-1/6 text-center">${bgHighReactionPointArticle.formatRegDate}</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
	<section class="mt-6 mb-20 mx-20 text-lg min-w-1000">
		<div class="mt-6 flex">
			<a href="/usr/article/list?boardType=lol" class="w-1/2 max-w-670"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/usr/article/list?boardType=bg" class="ml-4 w-1/2 max-w-670"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>