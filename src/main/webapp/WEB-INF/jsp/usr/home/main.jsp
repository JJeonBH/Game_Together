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
		<div class="table-box-type-3 mt-4 flex">
			<table class="w-1/2 h-80">
				<colgroup>
					<col width="350"/>
				</colgroup>
				<tbody class="h-1/2">
					<tr class="title">
						<td colspan="3" class="text-blue-500">롤 공지사항</td>
					</tr>
					<c:if test="${lolNoticeArticles.size() == 0}">
						<tr>
							<td class="h-full pl-1">공지사항이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="lolNoticeArticle" items="${lolNoticeArticles}">
						<tr>
							<td>
								<a href="../article/detail?articleId=${lolNoticeArticle.id}&boardType=${lolNoticeArticle.boardType}&boardId=${lolNoticeArticle.boardId}" class="hover:underline pl-1">${lolNoticeArticle.title}</a>
							</td>
							<td class="text-center">${lolNoticeArticle.writerNickname}</td>
							<td class="text-center">${lolNoticeArticle.formatRegDate}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tbody class="h-1/2">
					<tr class="title">
						<td colspan="3" class="text-green-500">배그 공지사항</td>
					</tr>
					<c:if test="${bgNoticeArticles.size() == 0}">
						<tr>
							<td class="h-full pl-1">공지사항이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="bgNoticeArticle" items="${bgNoticeArticles}">
						<tr>
							<td>
								<a href="../article/detail?articleId=${bgNoticeArticle.id}&boardType=${bgNoticeArticle.boardType}&boardId=${bgNoticeArticle.boardId}" class="hover:underline pl-1">${bgNoticeArticle.title}</a>
							</td>
							<td class="text-center">${bgNoticeArticle.writerNickname}</td>
							<td class="text-center">${bgNoticeArticle.formatRegDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<table class="ml-4 w-1/2 h-80">
				<colgroup>
					<col width="350"/>
				</colgroup>
				<tbody class="h-1/2">
					<tr class="title">
						<td colspan="3" class="text-blue-500">롤 인기글</td>
					</tr>
					<c:if test="${lolHighReactionPointArticles.size() == 0}">
						<tr>
							<td class="h-full pl-1">최근 한 달간 추천 받은 글이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="lolHighReactionPointArticle" items="${lolHighReactionPointArticles}">
						<tr>
							<td>
								<a href="../article/detail?articleId=${lolHighReactionPointArticle.id}&boardType=${lolHighReactionPointArticle.boardType}&boardId=${lolHighReactionPointArticle.boardId}" class="hover:underline pl-1">${lolHighReactionPointArticle.title}</a>
							</td>
							<td class="text-center">${lolHighReactionPointArticle.writerNickname}</td>
							<td class="text-center">${lolHighReactionPointArticle.formatRegDate}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tbody class="h-1/2">
					<tr class="title">
						<td colspan="3" class="text-green-500">배그 인기글</td>
					</tr>
					<c:if test="${bgHighReactionPointArticles.size() == 0}">
						<tr>
							<td class="h-full pl-1">최근 한 달간 추천 받은 글이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="bgHighReactionPointArticle" items="${bgHighReactionPointArticles}">
						<tr>
							<td>
								<a href="../article/detail?articleId=${bgHighReactionPointArticle.id}&boardType=${bgHighReactionPointArticle.boardType}&boardId=${bgHighReactionPointArticle.boardId}" class="hover:underline pl-1">${bgHighReactionPointArticle.title}</a>
							</td>
							<td class="text-center">${bgHighReactionPointArticle.writerNickname}</td>
							<td class="text-center">${bgHighReactionPointArticle.formatRegDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</section>
	<section class="mt-6 mb-20 mx-20 text-lg min-w-1000">
		<div class="mt-6 flex">
			<a href="/usr/article/list?boardType=lol" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/usr/article/list?boardType=bg" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>