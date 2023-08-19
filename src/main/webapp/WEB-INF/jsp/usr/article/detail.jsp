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
			
			let reactionPointBtn = $('#reactionPoint-btn');
			
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
			
			let reactionPointBtn = $('#reactionPoint-btn');
			let recommendationCnt = $('#recommendation-count');
			
			reactionPointBtn.empty();
			recommendationCnt.empty();
			
			reactionPointBtn.html('❤️추천 ' + data);
			recommendationCnt.html('추천 ' + data);
			
			reactionPointBtn.attr('onclick', 'doDeleteReactionPoint()')
			
		}, 'json');
		
	}
	
	function doDeleteReactionPoint() {
		
		$.get('../reactionPoint/doDeleteReactionPoint', {
			relTypeCode : 'article',
			relId : ${article.id}
		}, function(data) {
			
			let reactionPointBtn = $('#reactionPoint-btn');
			let recommendationCnt = $('#recommendation-count');
			
			reactionPointBtn.empty();
			recommendationCnt.empty();
			
			reactionPointBtn.html('🤍추천 ' + data);
			recommendationCnt.html('추천 ' + data);
			
			reactionPointBtn.attr('onclick', 'doInsertReactionPoint()')
			
		}, 'json');
		
	}
	
	function replyWrite() {
		
		let replyBody = $('textarea[name=body]').val().trim();
		
		if (replyBody.length < 2) {
			alert('2글자 이상 입력해 주세요.');
			$('textarea[name=body]').focus();
			return;
		}
		
		$.get('../reply/doWrite', {
			relTypeCode : 'article',
			relId : ${article.id},
			body : replyBody
		}, function(data) {
			
			let noReply = $('#no-reply');
			let replyBox = $('#reply-box');
			let replyCnt = $('#reply-count');
			
			let append = `<div id="\${data.data1.id}" class="border-b border-gray-300 p-4">`;
			append += `<div class="flex justify-between items-center">`;
			append += `<div class="font-semibold flex items-center">`;
			
			if (data.data1.profileImg != null) {
				append += `<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/usr/file/getFileUrl/\${data.data1.profileImg.id}" alt="reply writer profile image"/></div>`
			} else {
				append += `<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/resource/images/gt.png" alt="reply writer profile image"/></div>`;
			}
			
			append += `<span class="ml-2">\${data.data1.writerNickname}</span>`;
			append += `</div>`;
			append += `<div class="dropdown">`;
			append += `<button class="btn btn-circle btn-ghost btn-sm mr-8">`;
			append += `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>`;
			append += `</button>`;
			append += `<ul tabindex="0" class="menu menu-compact dropdown-content p-2 shadow bg-base-100 rounded-box w-20">`;
			append += `<li><div onclick="getReplyModifyForm(\${data.data1.id});">수정</div></li>`;
			append += `<li><div onclick="replyDelete(\${data.data1.id});">삭제</div></li>`;
			append += `</ul>`;
			append += `</div>`;
			append += `</div>`;
			append += `<div class="my-4"><span>\${data.data1.forPrintBody}</span></div>`;
			append += `<div class="text-xs text-gray-400"><span>\${data.data1.formatRegDate}</span></div>`;
			append += `</div>`;
			
			noReply.remove();
			replyBox.append(append);
			replyCnt.empty();
			replyCnt.html(`<i class="fa-regular fa-comment-dots"></i> <span>댓글 ` + data.data2 + `</span>`);
			$('textarea[name=body]').val('');
			
		}, 'json');
		
	}
	
	function replyDelete(replyId) {
		
		if (confirm('정말 삭제하시겠습니까?') == false) {
			return;
		}
		
		$.get('../reply/doDelete', {
			replyId : replyId,
			relTypeCode : 'article',
			relId : ${article.id}
		}, function(data) {
			
			if (data.fail) {
				alert(data.msg);
			} else {
				
				let replyBox = $('#reply-box');
				let replyCnt = $('#reply-count');
				
				$('#' + replyId).remove();
				
				if (data.data2 == 0) {
					let append = `<div id="no-reply" class="border-b border-gray-300 p-4 text-center">`;
					append += `<span><i class="fa-regular fa-comment-dots text-2xl"></i></span>`;
					append += `<div><span>등록된 댓글이 없습니다.</span></div>`;
					append += `</div>`;
					replyBox.append(append);
				}
				
				replyCnt.empty();
				replyCnt.html(`<i class="fa-regular fa-comment-dots"></i> <span>댓글 ` + data.data2 + `</span>`);
				
			}
			
		}, 'json');
		
	}
	
	originalReplyModifyForm = null;
	originalReplyId = null;
	
	function getReplyModifyForm(replyId) {
		
		if (originalReplyModifyForm != null) {
			replyModify_cancle(originalReplyId);
		}
		
		$.get('../reply/getReplyContent', {
			replyId : replyId
		}, function(data) {
			
			if (data.fail) {
				alert(data.msg);
			} else {
				
				let replyContent = $('#' + replyId);
				
				originalReplyModifyForm = replyContent.html();
				originalReplyId = replyId;
				
				let append = `<div>`;
				append += `<div class="border border-blue-400 rounded-lg p-4">`;
				append += `<div class="font-semibold mb-2 flex items-center">`;
				
				if (data.data1.profileImg != null) {
					append += `<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/usr/file/getFileUrl/\${data.data1.profileImg.id}" alt="profile image"/></div>`
				} else {
					append += `<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/resource/images/gt.png" alt="profile image"/></div>`;
				}
				
				append += `<span class="ml-2">\${data.data1.writerNickname}</span>`;
				append += `</div>`;
				append += `<textarea class="textarea textarea-info w-full" name="modifyBody" placeholder="댓글을 남겨보세요.">\${data.data1.body}</textarea>`;
				append += `<div class="flex justify-end">`;	
				append += `<div class="btn btn-info btn-sm text-white hover:text-black" onclick="replyModify(\${data.data1.id});">수정</div>`;
				append += `<div class="btn btn-info btn-sm text-white hover:text-black ml-1" onclick="replyModify_cancle(\${data.data1.id});">취소</div>`;		
				append += `</div>`;
				append += `</div>`;
				append += `</div>`;
				
				replyContent.empty();
				replyContent.append(append);
				
			}
			
		}, 'json');
		
	}
	
	function replyModify_cancle(replyId) {
		
		let replyContent = $('#' + replyId);
		replyContent.html(originalReplyModifyForm);
		
		originalReplyModifyForm = null;
		originalReplyId = null;
		
	}
	
	function replyModify(replyId) {
		
		let replyModifyBody = $('textarea[name=modifyBody]').val().trim();
		
		if (replyModifyBody.length < 2) {
			alert('2글자 이상 입력해 주세요.');
			$('textarea[name=modifyBody]').focus();
			return;
		}
		
		$.get('../reply/doModify', {
			replyId : replyId,
			body : replyModifyBody
		}, function(data) {
			
			if (data.fail) {
				alert(data.msg);
			} else {
				
				let replyContent = $('#' + replyId);
				
				let append = `<div class="flex justify-between items-center">`;
				append += `<div class="font-semibold flex items-center">`;
				
				if (data.data1.profileImg != null) {
					append += `<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/usr/file/getFileUrl/\${data.data1.profileImg.id}" alt="reply writer profile image"/></div>`
				} else {
					append += `<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/resource/images/gt.png" alt="reply writer profile image"/></div>`;
				}
				
				append += `<span class="ml-2">\${data.data1.writerNickname}</span>`;
				append += `</div>`;
				append += `<div class="dropdown">`;
				append += `<button class="btn btn-circle btn-ghost btn-sm mr-8">`;
				append += `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>`;
				append += `</button>`;
				append += `<ul tabindex="0" class="menu menu-compact dropdown-content p-2 shadow bg-base-100 rounded-box w-20">`;
				append += `<li><div onclick="getReplyModifyForm(\${data.data1.id});">수정</div></li>`;
				append += `<li><div onclick="replyDelete(\${data.data1.id});">삭제</div></li>`;
				append += `</ul>`;
				append += `</div>`;
				append += `</div>`;
				append += `<div class="my-4"><span>\${data.data1.forPrintBody}</span></div>`;
				append += `<div class="text-xs text-gray-400"><span>\${data.data1.formatRegDate}</span></div>`;
				
				replyContent.empty();
				replyContent.append(append);
				
				originalReplyModifyForm = null;
				originalReplyId = null;
				
			}
			
		}, 'json');
		
	}
	
	// 	댓글수 누르면 댓글로 이동
	$(document).ready(function() {
		$('#reply-count').click(function() {
			//	선택한 태그의 위치를 반환
			let offset = $('#destination').offset();
			//	animate() 메서드를 이용해서 선택한 태그의 스크롤 위치를 지정해서 0.4초 동안 부드럽게 해당 위치로 이동
			$('html').animate({scrollTop : offset.top - 50}, 400);
		});
	});
	
	// 	게시물 목록에서 댓글수 누르면 상세보기에서 바로 댓글로 이동
	if (${event == 1}) {
		
		$(function() {
			
			let offset = $('#destination').offset();
			
			$('html').animate({scrollTop : offset.top - 50}, 400);
			
		});
		
	}
	
	$(function() {
		getReactionPoint();
	})
	
</script>
	<section class="mt-6 mb-20 mx-20 min-w-1000 flex">
		<div class="w-64 p-6 text-lg">
			<c:if test="${Request.loginedMemberId != 0}">
				<div class="mb-2 flex items-center">
					<c:choose>
						<c:when test="${profileImg != null}">
							<div class="w-20 h-20"><img class="h-full w-full rounded-full" src="/usr/file/getFileUrl/${profileImg.id}" alt="profile image"/></div>
						</c:when>
						<c:otherwise>
							<div class="w-20 h-20"><img class="h-full w-full rounded-full" src="/resource/images/gt.png" alt="profile image"/></div>
						</c:otherwise>
					</c:choose>
					<span class="ml-2">${Request.loginedMember.nickname}</span>
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
					<a href="list?boardType=${boardType}" class="hover:underline ${boardId == 0 ? 'font-extrabold text-blue-500' : ''}"><span>전체 게시판</span></a>
					<div class="border-b border-blue-400 my-4"></div>
				</li>
				<c:forEach var="board" items="${boards}">
					<li class="mb-2">
						<a href="list?boardType=${boardType}&boardId=${board.id}" class="hover:underline ${boardId == board.id ? 'font-extrabold text-blue-500' : ''}"><span>${board.name}</span></a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="w-3/4 ml-6 p-6">
			<div class="flex justify-between items-center">
				<div>
					<c:if test="${article.actorCanChangeData}">
						<span><a href="modify?articleId=${article.id}&boardType=${boardType}" class="btn btn-info btn-sm text-white hover:text-black">수정</a></span>
						<span><a href="doDelete?articleId=${article.id}&boardType=${boardType}&boardId=${boardId}" class="btn btn-info btn-sm text-white hover:text-black" onclick="if(!confirm('정말 삭제하시겠습니까?')) {return false;}">삭제</a></span>
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
			<div class="border border-gray-300 p-4 mt-2 rounded-lg">
				<div>
					<div class="my-4">
						<div>
							<a href="list?boardType=${boardType}&boardId=${article.boardId}" class="text-green-500" >
								<span class="flex items-center"><img src="/resource/images/${boardType}.jpg" alt="게임 로고" width="50"> ${article.boardName}</span>
							</a>
						</div>
					</div>
					<div class="my-4">
						<h1 class="text-3xl detail-title">${article.title}</h1>
					</div>
					<div class="flex justify-between items-center">
						<div class="flex items-center">
							<c:choose>
								<c:when test="${writerProfileImg != null}">
									<div class="w-16 h-16"><img class="h-full w-full rounded-full" src="/usr/file/getFileUrl/${writerProfileImg.id}" alt="article writer profile image"/></div>
								</c:when>
								<c:otherwise>
									<div class="w-16 h-16"><img class="h-full w-full rounded-full" src="/resource/images/gt.png" alt="article writer profile image"/></div>
								</c:otherwise>
							</c:choose>
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
							<button id="reply-count">
								<i class="fa-regular fa-comment-dots"></i>
								<span>댓글 ${article.repliesCnt}</span>
							</button>
							<span class="text-gray-300 mx-2">|</span>
							<span id="recommendation-count">추천 ${article.sumReactionPoint}</span>
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
								<button id="reactionPoint-btn" class="btn btn-info btn-sm text-white hover:text-black"></button>
							</c:otherwise>
						</c:choose>
					</c:if>
				</div>
				<div id="destination" class="border-b border-blue-400 my-4"></div>
				<div>
					<h2 class="text-lg my-4">댓글</h2>
					<div id="reply-box">
						<c:choose>
							<c:when test="${replies.size() == 0}">
								<div id="no-reply" class="border-b border-gray-300 p-4 text-center">
									<span><i class="fa-regular fa-comment-dots text-2xl"></i></span>
									<div><span>등록된 댓글이 없습니다.</span></div>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="reply" items="${replies}">
									<div id="${reply.id}" class="border-b border-gray-300 p-4">
										<div class="flex justify-between items-center">
											<div class="font-semibold flex items-center">
												<c:choose>
													<c:when test="${reply.profileImg != null}">
														<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/usr/file/getFileUrl/${reply.profileImg.id}" alt="reply writer profile image"/></div>
													</c:when>
													<c:otherwise>
														<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/resource/images/gt.png" alt="reply writer profile image"/></div>
													</c:otherwise>
												</c:choose>
												<span class="ml-2">${reply.writerNickname}</span>
											</div>
											<c:if test="${reply.actorCanChangeData}">
												<div class="dropdown">
													<button class="btn btn-circle btn-ghost btn-sm mr-8">
														<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
													</button>
													<ul tabindex="0" class="menu menu-compact dropdown-content p-2 shadow bg-base-100 rounded-box w-20">
												        <li><div onclick="getReplyModifyForm(${reply.id});">수정</div></li>
												        <li><div onclick="replyDelete(${reply.id});">삭제</div></li>
						      						</ul>
												</div>
											</c:if>
										</div>
										<div class="my-4"><span>${reply.getForPrintBody()}</span></div>
										<div class="text-xs text-gray-400"><span>${reply.formatRegDate}</span></div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
					<c:if test="${Request.loginedMemberId != 0}">
						<div class="mt-4">
							<div class="border border-blue-400 rounded-lg p-4">
								<div class="font-semibold mb-2 flex items-center">
									<c:choose>
										<c:when test="${profileImg != null}">
											<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/usr/file/getFileUrl/${profileImg.id}" alt="profile image"/></div>
										</c:when>
										<c:otherwise>
											<div class="w-12 h-12"><img class="h-full w-full rounded-full" src="/resource/images/gt.png" alt="profile image"/></div>
										</c:otherwise>
									</c:choose>
									<span class="ml-2">${Request.loginedMember.nickname}</span>
								</div>
								<textarea class="textarea textarea-info w-full" name="body" placeholder="댓글을 남겨보세요."></textarea>
								<div class="flex justify-end">
									<div class="btn btn-info btn-sm text-white hover:text-black" onclick="replyWrite();">등록</div>
								</div>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>