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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile.css" />

<div class="container">
<section class="profile-Tclass">
	<sec:authorize access="hasRole('TEACHER')">
		<div class="row m-5 p-5 ml-1">
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">강사 마이페이지</h3>
				<div class="card-body">
					<div class="card-text">
		          	<c:if test="${not empty attach}">
						<div class="img-box">
				            <img img src="${pageContext.request.contextPath}/resources/upload/member/${member.memberReProfile}">
						</div>
		          	</c:if>
						<span class="fs-5">
			               <sec:authentication property="principal.username"/>
			            </span>
			            <span class="fs-5">님</span>
			            <span class="fs-5">,&nbsp;안녕하세요.</span>
					</div>
					<div class="text-end">
						<sapn class="link-box" onclick="location.href='${pageContext.request.contextPath}/teacher/teacherDetail.do'">
							<span></span><span></span><span></span><span></span>
								프로필 수정
						</sapn>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">내 강의 목록</h3>
				<div class="card-body">
					<div class="card-text">
					<c:choose>
						<c:when test="${empty list}">
							등록하신 강의가 존재하지 않습니다.
						</c:when>
						<c:when test="${not empty list}">
							<c:forEach items="${list}" var="lec">
								<li onclick='location.href="${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${lec.lectureNo}"'>
									${lec.lectureName}
								</li>
							</c:forEach>
						</c:when>
					</c:choose>
					</div>
					<div class="text-end">
						<span class="link-box" onclick="location.href='${pageContext.request.contextPath}/lecture/myAllLecture.do';">
							<span></span><span></span><span></span><span></span>
							강의 전체 보기
						</span>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">알림</h3>
				<div class="card-body">
					<div class="card-text">
					<c:if test="${empty message}">
						<p>등록된 알림이 없습니다.</p>
					</c:if>
					<c:if test="${not empty message}">
						<c:forEach items="${message}" var="message" end="2">
						<li >
							<span onclick="location.href='${pageContext.request.contextPath}/alarm/alarmDetail.do?msgNo=${message.msgNo}'">
								${message.msgTitle}
							</span>
						</li>
						</c:forEach>
					</c:if>
					</div>
					<c:if test="${not empty message}">
						<span class="link-box" onclick='location.href="${pageContext.request.contextPath}/alarm/alarmList.do"'>
							<span></span><span></span><span></span><span></span>
							받은알림 목록
						</span>
					</c:if>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">캘린더</h3>
				<div class="card-body">
					<div class="card-text">
						<li>구체적인 계획 미정</li>
					</div>
					<div class="text-end">
						<span class="link-box" onclick="location.href='${pageContext.request.contextPath}/member/myCalendar.do'">
							<span></span><span></span><span></span><span></span>
							캘린더 전체보기
						</span>
					</div>
				</div>
			</div>
<!-- 			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">정산내역</h3>
				<div class="card-body">
				  <div class="card-text">
					<p><a href="#">2021년 상반기 정산내역</a></p>
					<p><a href="#">2020년 하반기 정산내역</a></p>
					</div>
					<div class="text-end">
						<span class=""><a href="#">정산 상세 내역</a></span>
					</div>
				</div>
			</div> -->

<!-- 			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">강의자 페이지</h3>
				<div class="card-body">
					<div class="card-text">
						<li>새 강의 공지</li>
						<li>강의 질답</li>
						<li>공지사항</li>
					</div>
					<div class="text-end">
						<span class="link-box" onclick="#">
							<span></span><span></span><span></span><span></span>
							상세 프로필 보기
						</span>
					</div>
				</div>
			</div> -->
		</div>
	  </sec:authorize>
	  <!-- 강사 프로필 끝 -->
  </section>
</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>