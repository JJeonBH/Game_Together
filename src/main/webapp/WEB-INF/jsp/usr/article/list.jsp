<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${pageTitle}" />
<%@ include file="../common/head.jsp" %>
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
			<div class="mb-3">
				<a href="list?boardType=${boardType}&boardId=${boardId}&memberId=${memberId}">
					<span class="text-3xl flex items-center"><img src="/resource/images/${boardType}.jpg" alt="게임 로고" width="100"> ${pageTitle}</span>
				</a>
			</div>
			<div class="mb-3 flex justify-between items-center">
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
						<input class="ml-1 input input-bordered input-info" name="searchKeyword" placeholder="검색어를 입력해 주세요." maxlength="20" value="${searchKeyword}"/>
						<button class="ml-1 btn-text-color btn btn-info btn-sm">검색</button>
					</form>
				</div>
			</div>
			<div class="table-box-type-2 mb-4">
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
							<th>추천</th>
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
								<td>
									<a href="detail?articleId=${article.id}&boardType=${boardType}&boardId=${boardId}&page=${page}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}&memberId=${memberId}" class="hover:underline">${article.title}</a>
									<c:if test="${article.repliesCnt != 0}">
										<a href="detail?articleId=${article.id}&boardType=${boardType}&boardId=${boardId}&page=${page}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}&memberId=${memberId}&event=${1}" class="hover:underline text-red-500">[${article.repliesCnt}]</a>
									</c:if>
								</td>
								<td><span class="hover:underline">${article.writerNickname}</span></td>
								<td class="text-center"><span>${article.formatRegDate}</span></td>
								<td class="text-center"><span>${article.viewCount}</span></td>
								<td class="text-center"><span>${article.sumReactionPoint}</span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<c:if test="${Request.loginedMemberId != 0}">
				<div class="mb-4 flex justify-end">
					<a href="write?boardType=${boardType}" class="btn-text-color btn btn-info btn-sm"><span>글쓰기</span></a>	
				</div>
			</c:if>
			<div class="mb-2 flex justify-center">
				<div>
					<c:choose>
						<c:when test="${memberId == 0}">
							<c:set var="pageBaseUri" value="list?boardType=${boardType}&boardId=${boardId}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}" />
						</c:when>
						<c:otherwise>
							<c:set var="pageBaseUri" value="list?boardType=${boardType}&boardId=${boardId}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}&memberId=${memberId}" />
						</c:otherwise>
					</c:choose>
					<c:if test="${page > 1}">
						<a href="${pageBaseUri}&page=1" class="hover:text-blue-600 mx-1">«</a>
						<a href="${pageBaseUri}&page=${page - 1}" class="hover:text-blue-600 mx-1">&lt;</a>
						<span class="text-gray-300 mx-2">|</span>
					</c:if>
					<c:forEach begin="${startPage}" end="${endPage}" var="i">
						<a href="${pageBaseUri}&page=${i}" class="${page == i ? 'text-blue-600 border border-blue-600 p-1' : ''} mx-1 hover:underline">${i}</a>
					</c:forEach>
					<c:if test="${page < pagesCount}">
						<span class="text-gray-300 mx-2">|</span>
						<a href="${pageBaseUri}&page=${page + 1}" class="hover:text-blue-600 mx-1">&gt;</a>
						<a href="${pageBaseUri}&page=${pagesCount}" class="hover:text-blue-600 mx-1">»</a>
					</c:if>
				</div>
			</div>
			<div class="flex justify-center">
				<form onsubmit="submitListPageForm(this, ${pagesCount}); return false;">
					<input type="hidden" name="boardType" value="${boardType}"/>
					<input type="hidden" name="boardId" value="${boardId}"/>
					<input type="hidden" name="searchKeywordType" value="${searchKeywordType}"/>
					<input type="hidden" name="searchKeyword" value="${searchKeyword}"/>
					<input type="hidden" name="memberId" value="${memberId}"/>
					<input type="text" name="page" class="input input-bordered input-info input-xs w-14" placeholder="페이지"/>
					<button class="btn btn-info btn-xs text-white hover:text-black ml-1">이동</button>
				</form>
			</div>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>