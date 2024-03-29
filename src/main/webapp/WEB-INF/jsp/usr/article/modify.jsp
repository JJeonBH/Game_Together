<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="글 수정 - 같이 할래?"/>
<%@ include file="../common/head.jsp" %>
<%@ include file="../common/toastUiEditorLib.jsp" %>
<script>

	let isFormChanged = false;
	
	$(document).ready(function() {
		
		$('form').find('select, input').on('change', function() {
			isFormChanged = true;
		});
		
		$('form').find('div.toast-ui-editor').on('input', function(event) {
			if (event) {
				isFormChanged = true;
			}
		});

		$(window).on('beforeunload', function() {
			
			if (isFormChanged) {
			    return "변경사항이 저장되지 않을 수 있습니다.";
			}
			
		});
		
	});
	
	$(function() {
		$('.select-board').val(${article.boardId});
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
		<div class="w-7/12 mx-6">
			<div class="ml-2 h-14 flex items-center text-3xl">
				<span class="flex items-center"><img src="/resource/images/게임로고.png" alt="게임 로고" width="60"> 글 수정</span>
			</div>
			<div>
				<form class="w-full" action="doModify" method="post" onsubmit="submitArticleModifyForm(this); return false;">
					<input type="hidden" name="body" />
					<input type="hidden" name="articleId" value="${article.id}" />
					<input type="hidden" name="boardType" value="${boardType}" />
					<div class="mb-3">
						<select class="select-board select select-primary" name="boardId">
							<c:forEach var="board" items="${boards}">
								<c:if test="${board.name == '공지사항'}">
									<c:if test="${Request.loginedMember.authLevel == 7}">
										<option value="${board.id}">${board.name}</option>
									</c:if>
								</c:if>
							</c:forEach>
							<c:forEach var="board" items="${boards}">
								<c:if test="${board.name != '공지사항'}">
									<option value="${board.id}">${board.name}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="mb-3">
						<input class="input input-bordered input-info w-full" type="text" name="title" placeholder="제목을 입력해 주세요." value="${article.title}"/>
					</div>
					<div class="toast-ui mb-3">
						<div class="toast-ui-editor">
							<script type="text/x-template">${article.body}</script>
						</div>
					</div>
					<div class="mb-3 flex justify-end">
						<button class="ml-2 btn-text-color btn btn-info btn-sm">수정완료</button>
					</div>
				</form>
			</div>
		</div>
		<div class="flex-grow">
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>