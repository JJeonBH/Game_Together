<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 탈퇴"/>
<%@ include file="../common/head.jsp" %>
	<script type="text/javascript">
		function submitWithdrawForm(form) {
			
			let checkMsg = $('#checkMsg');
			
			checkMsg.empty();
			
			form.loginPw.value = form.loginPw.value.trim();
			
			if (form.loginPw.value.length == 0) {
				checkMsg.html("비밀번호를 입력해 주세요");
				form.loginPw.focus();
				return;
			}
			
			$.post('doPasswordCheck', {
				loginPw : form.loginPw.value
			}, function(data) {
				if(data.success) {
					if (confirm('정말 탈퇴하시겠습니까?')) {
						form.submit();
					}
				} else {
					checkMsg.html(data.msg);
					form.loginPw.focus();
				}
			}, 'json');
			
		}
	</script>
	<section class="text-lg mt-10 mb-20 min-w-900">
		<div class="flex justify-center">
			<form action="doWithdraw" method="POST" class="border border-red-200 p-5" onsubmit="submitWithdrawForm(this); return false;">
				<div>
					<label class="cursor-pointer">
						비밀번호 확인
						<br>
						<input class="cursor-pointer mt-2 input input-bordered input-info w-112" type="text" name="loginPw" placeholder="비밀번호를 입력해 주세요."/>
					</label>
				</div>
				<div id="checkMsg" class="mt-2 h-3 text-xs text-red-400"></div>
				<div class="mt-8">
					<button class="btn-text-color btn btn-info w-112">탈퇴하기</button>
				</div>
			</form>
		</div>
		<div class="mt-5 flex justify-center">
			<button onclick="history.back();">뒤로가기</button>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>