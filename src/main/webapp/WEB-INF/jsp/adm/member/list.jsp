<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 관리"/>
<%@ include file="../../usr/common/head.jsp" %>
	<section class="my-10 mx-20 min-w-1000">
		<div class="mb-3">
			<span class="text-3xl font-medium text-pink-400">관리자 페이지 - 회원 관리</span>
		</div>
		<div class="mb-3 flex justify-between items-center">
			<div>
				<span class="text-lg">회원수 : ${membersCnt}</span>
			</div>
			<div>
				<form>
					<select data-value="${authLevel}" class="select select-primary" name="authLevel">
						<option value="0">전체</option>
						<option value="3">일반</option>
						<option value="7">관리자</option>
					</select>
					<select data-value="${searchKeywordType}" class="select select-primary" name="searchKeywordType">
						<option value="loginId,name,nickname">전체</option>
						<option value="loginId">아이디</option>
						<option value="name">이름</option>
						<option value="nickname">닉네임</option>
					</select>
					<input class="ml-1 input input-bordered input-info" name="searchKeyword" placeholder="검색어를 입력해 주세요." maxlength="20" value="${searchKeyword}"/>
					<button class="ml-1 btn-text-color btn btn-info btn-sm">검색</button>
				</form>
			</div>
		</div>
		<div class="table-box-type-4 mb-3">
			<table class="w-full text-black">
				<colgroup>
					<col width="50"/>
					<col width="80"/>
					<col width="80"/>
				</colgroup>
				<thead class="text-base text-center">
					<tr class="bg-green-50">
						<th><input type="checkbox" class="checkbox-all-member-id cursor-pointer"/></th>
						<th>번호</th>
						<th>등급</th>
						<th>가입날짜</th>
						<th>아이디</th>
						<th>이름</th>
						<th>닉네임</th>
						<th>탈퇴여부</th>
						<th>탈퇴날짜</th>
						<th>강퇴여부</th>
						<th>강퇴날짜</th>
					</tr>
				</thead>
				<tbody class="text-sm text-center">
					<c:choose>
						<c:when test="${membersCnt == 0}">
							<tr>
								<td colspan="11" class="text-center text-lg text-red-500">조건에 일치하는 회원이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="member" items="${members}">
								<tr class="${member.delStatus != 1 && member.banStatus != 1 ? 'bg-blue-50' : (member.delStatus == 1 ? 'bg-red-100' : 'bg-purple-200')}">
									<c:choose>
										<c:when test="${member.delStatus != 1 && member.banStatus != 1}">
											<td><input type="checkbox" class="checkbox-member-id cursor-pointer" value="${member.id}"/></td>
										</c:when>
										<c:otherwise>
											<td><input type="checkbox" class="checkbox-member-id" value="${member.id}" disabled/></td>
										</c:otherwise>
									</c:choose>
									<td>${member.id}</td>
									<c:choose>
										<c:when test="${member.authLevel == 7}">
											<td class="text-red-500">관리자</td>
										</c:when>
										<c:otherwise>
											<td>일반</td>
										</c:otherwise>
									</c:choose>
									<td>${member.formatRegDate}</td>
									<td>${member.loginId}</td>
									<td>${member.name}</td>
									<td>${member.nickname}</td>
									<c:choose>
										<c:when test="${member.delStatus == 1}">
											<td>⭕</td>
										</c:when>
										<c:otherwise>
											<td>❌</td>
										</c:otherwise>
									</c:choose>
									<td>${member.formatDelDate}</td>
									<c:choose>
										<c:when test="${member.banStatus == 1}">
											<td>⭕</td>
										</c:when>
										<c:otherwise>
											<td>❌</td>
										</c:otherwise>
									</c:choose>
									<td>${member.formatBanDate}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		
		<script>

			$('.checkbox-all-member-id').change(function() {
				const allCheck = $(this);
				const allChecked = allCheck.prop('checked');
				$('.checkbox-member-id').prop('checked', allChecked);
				$('.checkbox-member-id:is(:disabled)').prop('checked', false);
			})
			
			$('.checkbox-member-id').change(function() {
				const checkboxMemberIdCount = $('.checkbox-member-id').length;
				const checkboxMemberIdCheckedCount = $('.checkbox-member-id:checked').length;
				const checkboxDisabledCount = $('.checkbox-member-id:is(:disabled)').length;
				const allChecked = (checkboxMemberIdCount - checkboxDisabledCount) == checkboxMemberIdCheckedCount;
				$('.checkbox-all-member-id').prop('checked', allChecked);
			})
	
		</script>
		
		<div class="flex justify-end mb-3">
			<button class="btn-text-color btn btn-info btn-sm btn-delete-selected-members">회원 강퇴</button>
		</div>
		<div>
			<form action="doDeleteMembers" method="POST" name="do-delete-members-form">
				<input type="hidden" name="ids" value=""/>
			</form>
		</div>
		
		<script>
		
			$('.btn-delete-selected-members').click(function() {
				const values = $('.checkbox-member-id:checked').map((index, el) => el.value).toArray();
				if (values.length == 0) {
					alert('선택한 회원이 없습니다.');
					return;
				}
				if (confirm('선택한 회원을 강퇴하시겠습니까?') == false) {						
					return;
				}
				$('input[name=ids]').val(values.join(','));
				$('form[name=do-delete-members-form]').submit();
			})
			
		</script>
		
		<div class="flex justify-center">
			<div>
				<c:set var="pageBaseUri" value="list?authLevel=${authLevel}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}"/>
				<c:if test="${membersCnt != 0}">
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
				</c:if>
			</div>
		</div>
	</section>
<%@ include file="../../usr/common/foot.jsp" %>