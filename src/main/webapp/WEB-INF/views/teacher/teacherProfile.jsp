<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Profile" name="title" />
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js" crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet" crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

Font Awesome(아이콘) CSS
<script src="https://kit.fontawesome.com/0e3c91e1c6.js" crossorigin="anonymous"></script>
 -->

<section class="profile-Tclass">
<div class="container">
	<sec:authorize access="hasRole('TEACHER')">
		<div class="row m-5 p-5">
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">강사 마이페이지</h3>
				<div class="card-body">
					<div class="img">
						<%--   <img src="${pageContext.request.contextPath}" alt=""> --%>
					</div>
					<p class="card-text">
						<span class="fs-5">
			               <sec:authentication property="principal.username"/>
			            </span>
			            <span class="fs-5">님</span>
			            <span class="fs-5">,&nbsp;안녕하세요.</span>
					</p>
					<div class="text-end">
						<a href="${pageContext.request.contextPath}/teacher/teacherDetail.do">프로필 수정</a>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">내 글 확인</h3>
				<div class="card-body">
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<div class="img">
						<%--<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" alt=""> --%>
						<div class="text-end">
							<a href="#">내 글 목록</a>
						</div>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">알림</h3>
				<div class="card-body">
					<div class="alamList">
						<p><a href="#">알림</a></p> 
						<p><a href="#">알림</a></p>
						<p><a href="#">알림</a></p>
					</div>
					<div class="text-end">
						<span class=""><a href="#">받은알림 목록</a></span>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">캘린더</h3>
				<div class="card-body">
					<div class="alamList">
						<p><a href="#">다음 강의 일정</a></p> 
						<p><a href="#">스트리밍 강의 일정</a></p> 
					</div>
					<div class="text-end">
						<span class=""><a href="#">캘린더 전체보기</a></span>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">정산내역</h3>
				<div class="card-body">
				  <div class="">
					<p><a href="#">2021년 상반기 정산내역</a></p> 
					<p><a href="#">2020년 하반기 정산내역</a></p> 
					</div>
					<div class="text-end">
						<span class=""><a href="#">정산 상세 내역</a></span>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">강의 목록</h3>
				<form method="GET" id="lecFrm" action="${pageContext.request.contextPath}/teacher/teacherProfile.do">
				<div class="card-body">
					<div class="Calendar">
					<c:forEach items="${list}" var="lec">
						<p><a href="#">${lec.lectureName}</p>
					</c:forEach>
					</div>
					<div class="text-end">
						<span class=""><a href="#">강의 전체 보기</a></span>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">강의자 페이지</h3>
				<div class="card-body">
					<div class="Calendar">
						<p><a href="#">새 강의 공지</a></p> 
						<p><a href="#">강의 질답</a></p> 
						<p><a href="#">공지사항</a></p> 
					</div>
					<div class="text-end">
						<span class=""><a href="#">상세 프로필보기</a></span>
					</div>
				</div>
			</div>
		</div>
	  </sec:authorize>
	  <!-- 강사 프로필 끝 -->
	</div>
  </section>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>