<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${article.title}" />
<%@ include file="../common/head.jsp" %>
<%@ include file="../common/toastUiEditorLib.jsp" %>
<script>

	function getReactionPoint() {
		
		$.get('../reactionPoint/getReactionPoint', {
			relTypeCode : 'article',
			relId : ${article.id}
		}, function(data) {
			
			let reactionPointBtn = $('#reactionPointBtn');
			
			if (data.data1.sumReactionPoint == 0) {
				reactionPointBtn.empty();
				reactionPointBtn.html('🤍추천 ${article.sumReactionPoint}');
				reactionPointBtn.attr('onclick', 'doInsertReactionPoint()')
			} else {
				reactionPointBtn.empty();
				reactionPointBtn.html('❤️추천 ${article.sumReactionPoint}');
				reactionPointBtn.attr('onclick', 'doDeleteReactionPoint()')
			}
			
		}, 'json');
		
	}
	
	function doInsertReactionPoint() {
		
		$.get('../reactionPoint/doInsertReactionPoint', {
			relTypeCode : 'article',
			relId : ${article.id}
		}, function(data) {
			
			let reactionPointBtn = $('#reactionPointBtn');
			let recommendation = $('#recommendation');
			
			reactionPointBtn.empty();
			recommendation.empty();
			reactionPointBtn.html('❤️추천 ' + data);
			recommendation.html('추천 ' + data)
			reactionPointBtn.attr('onclick', 'doDeleteReactionPoint()')
			
		}, 'json');
		
	}
	
	function doDeleteReactionPoint() {
		
		$.get('../reactionPoint/doDeleteReactionPoint', {
			relTypeCode : 'article',
			relId : ${article.id}
		}, function(data) {
			
			let reactionPointBtn = $('#reactionPointBtn');
			let recommendation = $('#recommendation');
			
			reactionPointBtn.empty();
			recommendation.empty();
			reactionPointBtn.html('🤍추천 ' + data);
			recommendation.html('추천 ' + data)
			reactionPointBtn.attr('onclick', 'doInsertReactionPoint()')
			
		}, 'json');
		
	}
	
	$(function() {
		getReactionPoint();
	})
	
</script>
	<section class="mt-6 mb-20 mx-20 min-w-1000 flex">
		<div class="w-64 p-6 text-lg">
			<c:if test="${Request.loginedMemberId != 0}">
				<div class="mb-2">
					<span>${Request.loginedMember.nickname}</span>
				</div>
				<ul>
					<li class="mb-2">
						<a href="list?boardType=${boardType}&memberId=${Request.loginedMemberId}" class="btn-text-color btn btn-info btn-sm w-full"><span>내가 쓴 글</span></a>
					</li>
					<li class="mb-4">
						<a href="write?boardType=${boardType}" class="btn-text-color btn btn-info btn-sm w-full"><span>글쓰기</span></a>
					</li>
				</ul>
				<div class="border-b border-blue-400 my-4"></div>
			</c:if>
			<ul>
				<li class="mb-2">
					<a href="list?boardType=${boardType}" class="hover:underline"><span>전체 게시판</span></a>
					<div class="border-b border-blue-400 my-4"></div>
				</li>
				<c:forEach var="board" items="${boards}">
					<li class="mb-2">
						<a href="list?boardType=${boardType}&boardId=${board.id}" class="hover:underline"><span>${board.name}</span></a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="w-3/4 ml-6 p-6 rounded-lg">
			<div class="flex justify-between items-center border-b border-gray-200 pb-4">
				<div>
					<c:if test="${article.actorCanChangeData}">
						<span><a href="modify?id=${article.id}" class="btn btn-info btn-sm text-white hover:text-black">수정</a></span>
						<span><a href="doDelete?id=${article.id}" class="btn btn-info btn-sm text-white hover:text-black" onclick="if(!confirm('정말 삭제하시겠습니까?')) {return false;}">삭제</a></span>
					</c:if>
				</div>
				<div class="flex">
					<c:if test="${article.nextArticleId != 0}">
						<div><a href="detail?articleId=${article.nextArticleId}&boardType=${boardType}&boardId=${boardId}&page=${page}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}&memberId=${memberId}" class="btn btn-info btn-sm text-white hover:text-black">△다음글</a></div>
					</c:if>
					<c:if test="${article.previousArticleId != 0}">
						<div><a href="detail?articleId=${article.previousArticleId}&boardType=${boardType}&boardId=${boardId}&page=${page}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}&memberId=${memberId}" class="btn btn-info btn-sm text-white hover:text-black ml-2">▽이전글</a></div>
					</c:if>
					<div><a href="list?boardType=${boardType}&boardId=${boardId}&page=${page}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}&memberId=${memberId}" class="btn btn-info btn-sm text-white hover:text-black ml-2">목록</a></div>
				</div>
			</div>
			<div>
				<div class="my-4">
					<div><a href="list?boardType=${boardType}&boardId=${article.boardId}" class="text-green-500" >${article.boardName}</a></div>
				</div>
				<div class="my-4">
					<span class="text-3xl detail-title">${article.title}</span>
				</div>
				<div class="flex justify-between items-center">
					<div class="flex">
						<div class="flex items-center rounded-full bg-blue-200">이미지</div>
						<div class="ml-2">
							<div class="font-bold">${article.writerNickname}</div>
							<div>
								<div>
									<span>${article.formatRegDate}</span>
									<span class="ml-2">조회 ${article.viewCount}</span>
								</div>
							</div>
						</div>
					</div>
					<div>
						<span>댓글 1</span>
						<span class="text-gray-300 mx-2">|</span>
						<span id="recommendation">추천 ${article.sumReactionPoint}</span>
					</div>
				</div>
			</div>
			<div class="border-b border-blue-400 my-4"></div>
			<div class="toast-ui">
				<div class="toast-ui-viewer">
					<script type="text/x-template">${article.body}</script>
				</div>
			</div>
			<div>
				<c:if test="${Request.loginedMemberId == 0}">
					<div>❤️추천 ${article.sumReactionPoint}</div>
				</c:if>
				<c:if test="${Request.loginedMemberId != 0}">
					<c:choose>
						<c:when test="${Request.loginedMemberId == article.memberId}">
							<div>❤️추천 ${article.sumReactionPoint}</div>
						</c:when>
						<c:otherwise>
							<button id="reactionPointBtn" class="btn btn-info btn-sm text-white hover:text-black"></button>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
			<div class="border-b border-blue-400 my-4"></div>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>