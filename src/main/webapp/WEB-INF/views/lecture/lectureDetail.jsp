<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 상세페이지" name="title"/>
</jsp:include>

<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->

<div class="container my-5">
	<div class="page-header row">
		<h2 class="row">강의 상세페이지</h2>
		<div class="row just">
			<div class="col-auto">별점</div>
			div.col-auto
		</div>
	</div>
	<div class="col">
		<video width="700" controls>
			<source src="mov_bbb.mp4" type="video/mp4">
			<source src="mov_bbb.ogg" type="video/ogg">
		</video>
	</div>
	<div class="tab-content col-8">
		<ul class="nav nav-tabs justify-content-start" id="myTab"
			role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
					data-bs-target="#intro" type="button" role="tab"
					aria-controls="intro" aria-selected="true">강의 소개</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
					data-bs-target="#curriculum" type="button" role="tab"
					aria-controls="curriculum" aria-selected="false">커리큘럼</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
					data-bs-target="#review" type="button" role="tab"
					aria-controls="review" aria-selected="false">강의 후기</button>
			</li>
		</ul>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="intro" role="tabpanel"
				aria-labelledby="home-tab">강의소개 브라블랍블라</div>
			<div class="tab-pane fade" id="curriculum" role="tabpanel"
				aria-labelledby="profile-tab">커리큘럼 블라우블ㄹ라</div>
			<div class="tab-pane fade" id="review" role="tabpanel"
				aria-labelledby="contact-tab">강의 후기 블랑브라블ㄹ라</div>
		</div>
	</div>


</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>