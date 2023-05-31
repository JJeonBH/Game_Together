<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="프로필"></c:set>
<%@ include file="../common/head.jsp" %>
	<section class="h-20 text-xl min-w-900 flex justify-between items-center bg-white mt-1">
		<div class="ml-14 bg-pink-200">이미지</div>
		<div class="ml-2 hover:underline">
			<span class="text-black">${Request.loginedMember.name }</span>
			<span class="text-blue-400">(${Request.loginedMember.nickname })</span>
		</div>
		<div class="flex-grow"></div>
		<div class="mr-14">
			<a href="checkPassword" class="btn btn-outline btn-md text-black"><span>개인정보 수정</span></a>
		</div>
	</section>
	<section class="text-lg min-w-900 flex justify-center mt-4">
		<div class="table-box w-2/3">
			<table class="w-full">
				<tbody>
					<colgroup>
						<col width="180"/>
					</colgroup>
					<tr>
						<th>아이디</th>
						<td>${Request.loginedMember.loginId }</td>
					</tr>
					<tr>
						<th>생성일자</th>
						<td>${regDate }</td>
					</tr>
					<tr>
						<th>회원등급</th>
						<td>
							<c:choose>
								<c:when test="${Request.loginedMember.authLevel == 7 }">관리자</c:when>
								<c:otherwise>일반회원</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${Request.loginedMember.name }</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>${Request.loginedMember.nickname }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${Request.loginedMember.email.replaceAll("^([0-9a-zA-Z])([-_\\.]?[0-9a-zA-Z])*(@[0-9a-zA-Z])([-_\\.]?[0-9a-zA-Z])*(\\.[a-zA-Z]{2,3})$", "$1*****$3*****$5") }</td>
					</tr>
					<tr>
						<th>휴대전화 번호</th>
						<td>${Request.loginedMember.cellphoneNum.replaceAll("^(010)([0-9])([0-9]{2,3})([0-9])([0-9]{3})$", "$1-$2***-$4***") }</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>