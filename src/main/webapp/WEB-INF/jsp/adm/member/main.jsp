<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="관리자 페이지"/>
<%@ include file="../../usr/common/head.jsp" %>
	<section class="h-screen min-w-1000 text-white text-xl flex justify-around items-center">
		<a href="/adm/member/list" class="bg-purple-400 p-20 hover:text-black">회원 관리</a>
		<a href="#" class="bg-purple-400 p-20 hover:text-black">게시물 관리</a>
		<a href="#" class="bg-purple-400 p-20 hover:text-black">게시판 관리</a>
	</section>
<%@ include file="../../usr/common/foot.jsp" %>