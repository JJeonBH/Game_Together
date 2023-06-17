<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="글쓰기 - 같이 할래?"/>
<%@ include file="../common/head.jsp" %>
<!-- Toast UI 에디터 불러오기 -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>

	let isFormChanged = false;
	
	$(document).ready(function() {
		
		$('form').find('select, input, textarea').on('change', function() {
			isFormChanged = true;
		});
		
		$(window).on('beforeunload', function() {
			
			if (isFormChanged) {
			    return "변경사항이 저장되지 않을 수 있습니다.";
			}
			
		});
		
	});

</script>
<section class="mt-6 mx-20 text-lg min-w-1000 flex">
	<div class="w-56 bg-green-200">
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
	<div class="mx-6 w-7/12">
		<div class="ml-2 h-14 flex items-center text-2xl">
			<span>글쓰기</span>
		</div>
		<div>
			<form class="w-full" action="doWrite" method="post" onsubmit="submitWriteForm(this); return false;">
				<input type="hidden" name="body" />
				<div class="mb-3">
					<select class="select select-primary" name="boardId">
						<option value="" selected disabled hidden="hidden">게시판을 선택해 주세요.</option>
						<c:if test="${Request.loginedMember.authLevel == 7}">
							<option value="1">공지사항</option>
						</c:if>
						<option value="2">자유 게시판</option>
						<option value="3">신고 게시판</option>
					</select>
				</div>
				<div class="mb-3">
					<input class="input input-bordered input-info w-full" type="text" name="title" placeholder="제목을 입력해 주세요."/>
				</div>
				<div class="mb-3">
					<div id="editor"></div>
				</div>
				<script>
					const Editor = toastui.Editor;
					
					const editor = new Editor({
						el: document.querySelector('#editor'),
						previewStyle: 'tab',
						height: '350px',
						initialEditType: 'markdown'
					});
				</script>
				<div class="mb-3 flex justify-end">
					<button class="ml-2 btn-text-color btn btn-info btn-sm">작성완료</button>
				</div>
			</form>
		</div>
	</div>
	<div class="flex-grow bg-green-200">
	</div>
</section>
<%@ include file="../common/foot.jsp" %>