<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${pageTitle}" />
<%@ include file="../common/head.jsp" %>
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
		<div class="w-3/4 ml-6 p-6">
			<div class="mb-2">
				<a href="list?boardType=${boardType}&boardId=${boardId}&memberId=${memberId}"><span class="text-3xl">${pageTitle}</span></a>
			</div>
			<div class="mb-2 flex justify-between items-center">
				<div>${articlesCnt}개의 글</div>
				<div>
					<form>
						<input type="hidden" name="boardType" value="${boardType}"/>
						<input type="hidden" name="boardId" value="${boardId}"/>
						<input type="hidden" name="memberId" value="${memberId}"/>
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
			<div class="table-box-type-2 mb-2">
				<table class="w-full">
					<colgroup>
						<col width="80"/>
						<col width="260"/>
						<col width="80"/>
						<col width="120"/>
						<col width="80"/>
						<col width="60"/>
					</colgroup>
					<thead class="text-base text-center">
						<tr>
							<th>
								<c:choose>
									<c:when test="${boardId == 0}">글머리</c:when>
									<c:otherwise>글 번호</c:otherwise>
								</c:choose>
							</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회</th>
							<th>좋아요</th>
						</tr>
					</thead>
					<tbody class="text-sm">
						<c:forEach var="article" items="${articles}">
							<tr>
								<td class="text-center">
									<c:choose>
										<c:when test="${boardId == 0}"><a href="list?boardType=${boardType}&boardId=${article.boardId}" class="hover:underline">${article.boardName}</a></c:when>
										<c:otherwise><span>${article.id}</span></c:otherwise>
									</c:choose>
								</td>
								<td><a href="detail?articleId=${article.id}&boardType=${boardType}" class="hover:underline">${article.title}</a></td>
								<td><span class="hover:underline">${article.writerNickname}</span></td>
								<td class="text-center"><span>${article.formatRegDate}</span></td>
								<td class="text-center"><span>${article.viewCount}</span></td>
								<td class="text-center"><span>0</span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<c:if test="${Request.loginedMemberId != 0}">
				<div class="mb-2 flex justify-end">
					<a href="write?boardType=${boardType}" class="btn-text-color btn btn-info btn-sm"><span>글쓰기</span></a>	
				</div>
			</c:if>
			<div class="mb-2 flex justify-center">
				<div class="join">
<%-- 					<c:set var="pageMenuLen" value="5" /> --%>
<%-- 					<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1}" /> --%>
<%-- 					<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" /> --%>
					<c:choose>
						<c:when test="${memberId == 0}">
							<c:set var="pageBaseUri" value="list?boardType=${boardType}&boardId=${boardId}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}" />
						</c:when>
						<c:otherwise>
							<c:set var="pageBaseUri" value="list?boardType=${boardType}&boardId=${boardId}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}&memberId=${memberId}" />
						</c:otherwise>
					</c:choose>
					<c:if test="${page == 1}">
						<a class="join-item btn btn-sm btn-disabled">«</a>
						<a class="join-item btn btn-sm btn-disabled">&lt;</a>
					</c:if>
					<c:if test="${page > 1}">
						<a class="join-item btn btn-sm" href="${pageBaseUri}&page=1">«</a>
						<a class="join-item btn btn-sm" href="${pageBaseUri}&page=${page - 1}">&lt;</a>
					</c:if>
					<c:forEach begin="${start}" end="${end}" var="i">
						<a class="join-item btn btn-sm ${page == i ? 'btn-active' : ''}" href="${pageBaseUri}&page=${i}">${i}</a>
					</c:forEach>
					<c:if test="${page < pagesCount}">
						<a class="join-item btn btn-sm" href="${pageBaseUri}&page=${page + 1}">&gt;</a>
						<a class="join-item btn btn-sm" href="${pageBaseUri}&page=${pagesCount}">»</a>
					</c:if>
					<c:if test="${page == pagesCount}">
						<a class="join-item btn btn-sm btn-disabled">&gt;</a>
						<a class="join-item btn btn-sm btn-disabled">»</a>
					</c:if>
				</div>
			</div>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>