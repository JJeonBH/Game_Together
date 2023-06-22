<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="글쓰기 - 같이 할래?"/>
<%@ include file="../common/head.jsp" %>
<%@ include file="../common/toastUiEditorLib.jsp" %>
<script>

	let isFormChanged = false;
	
	$(document).ready(function() {
		
		$('form').find('select, input').on('change', function() {
			isFormChanged = true;
		});
		
		$('form').find('div.toast-ui-editor').on('input', function(event) {
			if(event) {
				isFormChanged = true;
			}
		});

		$(window).on('beforeunload', function() {
			
			if (isFormChanged) {
			    return "변경사항이 저장되지 않을 수 있습니다.";
			}
			
		});
		
	});

</script>
	<section class="mt-6 mb-20 mx-20 min-w-1000 flex">
		<div class="w-64 bg-green-200 p-6 text-lg">
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
		<div class="w-7/12 mx-6">
			<div class="ml-2 h-14 flex items-center text-3xl">
				<span>글쓰기</span>
			</div>
			<div>
				<form class="w-full" action="doWrite" method="post" onsubmit="submitWriteForm(this); return false;">
					<input type="hidden" name="body" />
					<input type="hidden" name="boardType" value="${boardType}" />
					<div class="mb-3">
						<select class="select select-primary" name="boardId">
							<option value="" selected disabled hidden="hidden">게시판을 선택해 주세요.</option>
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
						<input class="input input-bordered input-info w-full" type="text" name="title" placeholder="제목을 입력해 주세요."/>
					</div>
					<div class="toast-ui mb-3">
						<div class="toast-ui-editor">
							<script type="text/x-template"></script>
						</div>
					</div>
					<div class="mb-3 flex justify-end">
						<button class="ml-2 btn-text-color btn btn-info btn-sm">작성완료</button>
					</div>
				</form>
			</div>
		</div>
		<div class="flex-grow">
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>