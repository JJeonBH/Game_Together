<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="개인정보 수정"/>
<%@ include file="../common/head.jsp" %>
	<script type="text/javascript">
		function submitModifyForm(form) {
			
			form.nickname.value = form.nickname.value.trim();
			
			if (form.nickname.value.length == 0) {
				alert('닉네임을 입력해 주세요.');
				form.nickname.focus();
				return;
			}
			
			const nicknameRegex = /^[가-힣a-zA-Z0-9]{2,10}$/;
			
			if (!nicknameRegex.test(form.nickname.value)) {
				alert('2~10자의 한글과 영문 대 소문자, 숫자를 사용하세요. (특수기호, 공백 사용 불가)');
				form.nickname.focus();
				return;
			}
			
			if (form.nickname.value != `${Request.loginedMember.nickname}`) {
				
				let nicknameDupCheckForChangeResultData;
				
				$.ajax({
			        type: 'POST',
			        url: '/usr/member/nicknameDupCheckForChange',
			        async: false,
			        data: {
			            'nickname': form.nickname.value
			        },
			        success: function (data) {
			        	nicknameDupCheckForChangeResultData = data;
			        }
			    })
			    
				if (nicknameDupCheckForChangeResultData.fail) {
					alert(nicknameDupCheckForChangeResultData.data1 + '(은)는 ' + nicknameDupCheckForChangeResultData.msg);
					form.nickname.focus();
					return;
				}
				
			}
			
			form.email.value = form.email.value.trim();
			
			if (form.email.value.length > 0) {
				
				const emailRegex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

				if (!emailRegex.test(form.email.value)) {
					alert('이메일 주소를 다시 확인해 주세요.');
					form.email.focus();
					return;
				}
				
				if (form.email.value != `${Request.loginedMember.email}`) {
					
					let emailDupCheckForChangeResultData;
					
					$.ajax({
				        type: 'POST',
				        url: '/usr/member/emailDupCheckForChange',
				        async: false,
				        data: {
				            'email': form.email.value
				        },
				        success: function (data) {
				        	emailDupCheckForChangeResultData = data;
				        }
				    })
				    
					if (emailDupCheckForChangeResultData.fail) {
						alert(emailDupCheckForChangeResultData.data1 + '(은)는 ' + emailDupCheckForChangeResultData.msg);
						form.email.focus();
						return;
					}
					
				}
				
			}
			
			form.cellphoneNum.value = form.cellphoneNum.value.trim();
			
			if (form.cellphoneNum.value.length == 0) {
				alert('휴대전화 번호를 입력해 주세요. (-없이 숫자만)');
				form.cellphoneNum.focus();
				return;
			}
			
			const cellphoneNumRegex = /^(010)[0-9]{3,4}[0-9]{4}$/;
			
			if(!cellphoneNumRegex.test(form.cellphoneNum.value)) {
				alert('형식에 맞지 않는 번호입니다. ( -, 공백 없이 숫자만 )');
				form.cellphoneNum.focus();
				return;
			}
			
			if (form.cellphoneNum.value != `${Request.loginedMember.cellphoneNum}`) {
				
				let cellphoneNumDupCheckForChangeResultData;
				
				$.ajax({
			        type: 'POST',
			        url: '/usr/member/cellphoneNumDupCheckForChange',
			        async: false,
			        data: {
			            'cellphoneNum': form.cellphoneNum.value
			        },
			        success: function (data) {
			        	cellphoneNumDupCheckForChangeResultData = data;
			        }
			    })
			    
				if (cellphoneNumDupCheckForChangeResultData.fail) {
					alert(cellphoneNumDupCheckForChangeResultData.data1 + '(은)는 ' + cellphoneNumDupCheckForChangeResultData.msg);
					form.cellphoneNum.focus();
					return;
				}
				
			}
			
			form.submit();
			
		}
	</script>
	<section class="text-lg min-w-900 mt-4">
		<div>
			<form action="doModify" method="post" onsubmit="submitModifyForm(this); return false;">
				<div class="table-box-type-1 flex justify-center">
					<table class="w-2/3">
						<colgroup>
							<col width="180"/>
						</colgroup>
						<tbody>
							<tr>
								<th>아이디</th>
								<td>${Request.loginedMember.loginId}</td>
							</tr>
							<tr>
								<th>생성일자</th>
								<td>${regDate}</td>
							</tr>
							<tr>
								<th>회원등급</th>
								<td>
									<c:choose>
										<c:when test="${Request.loginedMember.authLevel == 7}">관리자</c:when>
										<c:otherwise>일반회원</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>${Request.loginedMember.name}</td>
							</tr>
							<tr>
								<th>닉네임</th>
								<td><input class="cursor-pointer input input-bordered input-info w-112" type="text" name="nickname" value="${Request.loginedMember.nickname}" placeholder="닉네임을 입력해 주세요."/></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input class="cursor-pointer input input-bordered input-info w-112" type="email" name="email" value="${Request.loginedMember.email}" placeholder="[선택] 비밀번호 분실 시 확인용 이메일"/></td>
							</tr>
							<tr>
								<th>휴대전화 번호</th>
								<td><input class="cursor-pointer input input-bordered input-info w-112" type="tel" name="cellphoneNum" value="${Request.loginedMember.cellphoneNum}" placeholder="휴대전화 번호를 입력해 주세요. (-없이 숫자만)"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="flex justify-center">
					<div class="w-2/3 flex justify-end mt-4">
						<button class="btn-text-color btn btn-info">수정</button>
						<a href="passwordModify" class="btn-text-color btn btn-info ml-1"><span>비밀번호 변경</span></a>
					</div>
				</div>
			</form>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>