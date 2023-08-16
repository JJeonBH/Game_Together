<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="비밀번호 변경"/>
<%@ include file="../common/head.jsp" %>
	<script type="text/javascript">
		function submitPasswordModifyForm(form) {
			
			form.currentLoginPw.value = form.currentLoginPw.value.trim();
			
			if (form.currentLoginPw.value.length == 0) {
				alert('현재 비밀번호를 입력해 주세요.');
				form.currentLoginPw.focus();
				return;
			}
			
			form.newLoginPw.value = form.newLoginPw.value.trim();
			
			if (form.newLoginPw.value.length == 0) {
				alert('새 비밀번호를 입력해 주세요.');
				form.newLoginPw.focus();
				return;
			}
			
			form.newLoginPwChk.value = form.newLoginPwChk.value.trim();
			
			if (form.newLoginPwChk.value.length == 0) {
				alert('새 비밀번호 확인을 입력해 주세요.');
				form.newLoginPwChk.focus();
				return;
			}
			
			new Promise((resolve, reject) => {
				
				$.ajax({
			        type: 'POST',
			        url: '/usr/member/doPasswordCheck',
			        data: {
			            'loginPw': form.currentLoginPw.value
			        },
			        success: function (data) {
			        	resolve(data);
			        },
			        fail: function (error) {
			        	reject(error);
			        }
			    })
			    
			})
			.then((resultData) => {
				
				if (resultData.fail) {
					alert('현재 ' + resultData.msg);
					form.currentLoginPw.focus();
					return;
				}
				
				const newLoginPwRegex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/;
				const hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
				
				if (!newLoginPwRegex.test(form.newLoginPw.value)) {
					alert('새 비밀번호에 8~16자 영문 대 소문자, 숫자, 특수문자(!@#$%^&*-?)를 사용하세요.');
					form.newLoginPw.value = '';
					form.newLoginPwChk.value = '';
					form.newLoginPw.focus();
					return;
				} else if (form.newLoginPw.value.search(/\s/) != -1) {
					alert('새 비밀번호는 공백 없이 입력해 주세요.');
					form.newLoginPw.value = '';
					form.newLoginPwChk.value = '';
					form.newLoginPw.focus();
					return;
				} else if (hangulcheck.test(form.newLoginPw.value)) {
					alert('새 비밀번호에 한글을 사용 할 수 없습니다.');
					form.newLoginPw.value = '';
					form.newLoginPwChk.value = '';
					form.newLoginPw.focus();
					return;
				}
				
				if (form.newLoginPw.value != form.newLoginPwChk.value) {
					alert('새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.');
					form.newLoginPw.value = '';
					form.newLoginPwChk.value = '';
					form.newLoginPw.focus();
					return;
				}
				
				form.submit();
				
			})
			.catch((error) => {
				
				alert(error);
				return;
				
			})
			
		}
	</script>
	<section class="text-lg min-w-900 mt-4">
		<div>
			<form action="doPasswordModify" method="post" onsubmit="submitPasswordModifyForm(this); return false;">
				<div class="table-box-type-1 flex justify-center">
					<table class="w-1/2">
						<colgroup>
							<col width="180"/>
						</colgroup>
						<tbody>
							<tr>
								<th>현재 비밀번호</th>
								<td><input class="cursor-pointer input input-bordered input-info w-112" type="text" name="currentLoginPw" placeholder="현재 비밀번호를 입력해 주세요."/></td>
							</tr>
							<tr>
								<th>새 비밀번호</th>
								<td><input class="cursor-pointer input input-bordered input-info w-112" type="text" name="newLoginPw" placeholder="새 비밀번호를 입력해 주세요."/></td>
							</tr>
							<tr>
								<th>새 비밀번호 확인</th>
								<td><input class="cursor-pointer input input-bordered input-info w-112" type="text" name="newLoginPwChk" placeholder="새 비밀번호 확인을 입력해 주세요."/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="flex justify-center">
					<div class="w-1/2 flex justify-end mt-4">
						<button class="btn-text-color btn btn-info">변경</button>
					</div>
				</div>
			</form>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>