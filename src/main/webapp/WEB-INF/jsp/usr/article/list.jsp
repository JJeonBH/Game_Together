<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${pageTitle}" />
<%@ include file="../common/head.jsp" %>
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
					<a href="list?boardType=${boardType}"><span>전체 게시판</span></a>
					<div class="border-b border-blue-400 my-4"></div>
				</li>
				<c:forEach var="board" items="${boards}">
					<li class="mb-2">
						<a href="list?boardType=${boardType}&boardId=${board.id}"><span>${board.name}</span></a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="w-3/4 bg-red-200 ml-6 p-6">
			<div class="mb-2">
				<a href="list?boardType=${boardType}&boardId=${boardId}"><span class="text-3xl">${pageTitle}</span></a>
			</div>
			<div class="mb-2 flex justify-between items-center">
				<div>${articlesCnt}개의 글</div>
				<div>
					<form>
						<input type="hidden" name="boardId" value="${boardId}"/>
						<input type="hidden" name="boardType" value="${boardType}"/>
						<select data-value="${searchKeywordType}" class="select select-primary" name="searchKeywordType">
							<option value="title">제목</option>
							<option value="body">내용</option>
							<option value="writerNickname">작성자</option>
							<option value="title,body">제목 + 내용</option>
						</select>
						<input class="ml-1 input input-bordered input-info" name="searchKeyword" placeholder="검색어를 입력해주세요" maxlength="20" value="${searchKeyword}"/>
						<button class="ml-1 btn-text-color btn btn-info btn-sm">검색</button>
					</form>
				</div>
			</div>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>