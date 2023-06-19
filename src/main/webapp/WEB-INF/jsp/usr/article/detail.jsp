<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${article.title}" />
<%@ include file="../common/head.jsp" %>
<%@ include file="../common/toastUiEditorLib.jsp" %>
<section class="mt-6 mb-20 mx-20 min-w-1000 flex">
	<div class="w-56 bg-green-200 p-6">
		<div>
			<a href="#">1</a>
		</div>
		<div>
			<a href="#">2</a>
		</div>
		<div>
			<a href="#">3</a>
		</div>
		<div>
			<a href="#">4</a>
		</div>
	</div>
	<div class="w-full bg-red-200 ml-6 p-6 rounded-lg">
		<div>
			<div>
				<a class="text-green-500" href="list?boardId=${article.boardId}">${article.boardName}</a>
			</div>
			<div class="my-4">
				<span class="text-3xl">${article.title}</span>
			</div>
			<div class="flex justify-between items-center">
				<div class="flex">
					<div class="flex items-center rounded-full bg-blue-200">이미지</div>
					<div class="ml-2">
						<div class="font-bold">${article.writerNickname}</div>
						<div>
							<div>
								<span>${article.formatUpdateDate()}</span>
								<span class="ml-2">조회 ${article.viewCount}</span>
							</div>
						</div>
					</div>
				</div>
				<div>
					<span>댓글 1</span>
					<span class="ml-2">추천 1</span>
				</div>
			</div>
		</div>
		<div class="border-b border-blue-400 my-4"></div>
		<div class="toast-ui">
			<div class="toast-ui-viewer">
				<script type="text/x-template">${article.body}</script>
			</div>
		</div>
		<div class="border-b border-blue-400 my-8"></div>
		<div>
			<c:if test="${Request.loginedMemberId != 0}">
				<span><a class="btn-text-color btn btn-info btn-sm" href="write">글쓰기</a></span>
			</c:if>
			<c:if test="${article.actorCanChangeData}">
				<span><a class="btn-text-color btn btn-info btn-sm" href="modify?id=${article.id}">수정</a></span>
				<span><a class="btn-text-color btn btn-info btn-sm" href="doDelete?id=${article.id}" onclick="if(!confirm('정말 삭제하시겠습니까?')) {return false;}">삭제</a></span>
			</c:if>
		</div>
	</div>
</section>
<%@ include file="../common/foot.jsp" %>