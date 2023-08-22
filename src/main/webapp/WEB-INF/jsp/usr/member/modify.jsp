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
			
			if (!cellphoneNumRegex.test(form.cellphoneNum.value)) {
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
		
		function preview() {
			
			let fileInput = document.querySelector("input[name=file]");
			let profileImage = document.querySelector("#profile-image");
			let preview = document.querySelector("#preview");
			let previewImage = document.querySelector("#preview-image");
			
			if (fileInput.files.length > 0) {
				
				profileImage.classList.add("hidden");
				preview.classList.remove("hidden");
				
				let reader = new FileReader();
				
				reader.onload = function (data) {
					previewImage.src = data.target.result;
				}
				
				reader.readAsDataURL(fileInput.files[0]);
				
			} else {
				
				profileImage.classList.remove("hidden");
				preview.classList.add("hidden");
				
				previewImage.src = "";
				
			}
			
		}
		
		function modal() {
			
			$('.layer-bg').show();
			$('.layer').show();
			
			$('.close-x-btn').click(function() {
				$('.layer-bg').hide();
				$('.layer').hide();
			})
			
			$('.submit-btn').click(function() {
				location.href = "/usr/member/withdraw";
			})
			
		}
		
	</script>
	<section class="text-lg min-w-900 my-5">
		<div>
			<form action="doModify" method="post" enctype="multipart/form-data" onsubmit="submitModifyForm(this); return false;">
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
							<tr>
								<th>프로필 사진</th>
								<td>
									<div id="profile-image">
										<c:choose>
											<c:when test="${profileImg != null}">
												<div class="ml-14 w-20 h-20"><img class="h-full w-full rounded-full" src="/usr/file/getFileUrl/${profileImg.id}" alt="profile image"/></div>
											</c:when>
											<c:otherwise>
												<div class="ml-14 w-20 h-20"><img class="h-full w-full rounded-full" src="/resource/images/gt.png" alt="profile image"/></div>
											</c:otherwise>
										</c:choose>
									</div>
									<div id="preview" class="hidden">
										<div class="ml-14 w-20 h-20"><img id="preview-image" class="h-full w-full rounded-full" alt="preview image"/></div>
									</div>
									<input class="cursor-pointer mt-2 input input-bordered input-info w-112 h-full" type="file" name="file" accept="image/*" onchange="preview();"/>
								</td>
							</tr>
							<c:if test="${Request.loginedMember.authLevel != 7}">
								<tr>
									<th>회원 탈퇴</th>
									<td><a href="javascript:modal();" class="btn-text-color btn btn-info"><span>탈퇴 진행</span></a></td>
								</tr>
							</c:if>
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
		<div class="layer-bg"></div>
		<div class="layer">
			<h1>회원 탈퇴 시 주의사항 안내</h1>
			<button class="close-x-btn btn btn-square btn-outline">
				<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
			</button>
			<div>회원 탈퇴 시 홈페이지 이용(글쓰기, 채팅방 등)이 제한되며, 회원 탈퇴 후 30일이 지나면 회원 정보가 완전히 삭제됩니다.<br>30일이 지나기 전에는 언제든지 계정을 복구하실 수 있습니다.<br>다시 로그인을 하시면 복구가 가능합니다.</div>
			<button class="submit-btn btn-text-color btn btn-info">계속 진행</button>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>