<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Profile" name="title" />
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	crossorigin="anonymous"></script>
<style>
.card{
	padding :0;
}
</style>

<section class="profile-Uclass">
<div class="container">
	  <!-- 유저 프로필 시작 -->
	  	<%-- <sec:authorize access="!hasRole('TEACHER') && hasRole('USER')"> --%>
		<div class="row m-5 p-5">
			<div class="card m-5" style="max-width: 23rem;">
				<h3 class="card-header">마이페이지</h3>
				<div class="card-body">
					<img class="card-img-top" src="#" alt="Card image cap">
					<p class="card-text">
						<span class="fs-5"> <sec:authentication
								property="principal.username" />
						</span> <span class="fs-5">님</span> <span class="fs-5">,&nbsp;안녕하세요.</span>
					</p>
					<div class="text-end">
						<a class="btn btn-primary" href="${pageContext.request.contextPath}/member/memberDetail.do">프로필 수정</a>
					</div>
				</div>
			</div>
			<div class="card m-5" style="max-width: 23rem;">
				<h3 class="card-header">수강중인 강의</h3>
				<div class="card-body">
					<div class="basket">
					<c:choose>
						<c:when test="${empty lectureList}">
							<h6>수강중인 강의가 없습니다.</h6>
						</c:when>
						<c:when test="${not empty lectureList}">
							<c:forEach items="${lectureList}" var="lec" end="2">
								<p>
									<a href="${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${lec.lectureNo}">${lec.lectureName}</a>
								</p>
							</c:forEach>
						</c:when>
					</c:choose>
					</div>
					<div class="text-end">
					<c:choose>
					<c:when test="${empty lectureList}">
						<br>
						<br>
						<button class="btn btn-primary" onclick="${pageContext.request.contextPath}/lecture/lectureList.do">강의 보러가기</button>
					</c:when>
					<c:when test="${not empty lectureList}">
						<span ><a href="${pageContext.request.contextPath}/member/memberLectureList.do">수강중인 강의 목록</a></span>
					</c:when>
					</c:choose>
					</div>
				</div>
			</div>
			<div class="card m-5" style="max-width: 23rem;">
				<h3 class="card-header">관심 강의</h3>
				<div class="card-body">
					<div class="Calendar">
					<c:choose>
						<c:when test="${empty pickList}">
							<h6>찜목록에 강의가 존재하지 않습니다.</h6>
							<br>
							<br>
						</c:when>
						<c:when test="${not empty pickList}">
							<c:forEach items="${pickList}" var="pickList" end="2">
								<p class="card-text">
									<a href="${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${pickList.refLectureNo}">
										${pickList.lectureName} / ${pickList.teacherName} / ${pickList.lecturePrice != 0 ? pickList.lecturePrice : "무료"}
									</a>
								</p>
							</c:forEach>
						</c:when>
					</c:choose>
					</div>
					<div class="text-end">
						<c:choose>
							<c:when test="${not empty pickList}">
								<span ><a href="${pageContext.request.contextPath}/order/pick.do">찜목록 가기</a></span>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="card m-5" style="max-width: 23rem;">
				<h3 class="card-header">장바구니</h3>
				<div class="card-body">
					<c:forEach items="${basketList}" var="basketList" end="2">
						<p>
 							<a href="${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${basketList.refLectureNo}">
								${basketList.lectureName}
							</a>
						</p>
					</c:forEach>
					<div class="text-end">
						<span ><a href="${pageContext.request.contextPath}/order/basket.do">장바구니 바로가기</a></span>
					</div>
				</div>
			</div>
			<div class="card m-5" style="max-width: 23rem;">
				<h3 class="card-header">캘린더</h3>
				<div class="card-body">
					<div class="alamList">
						<p>
							<a href="#">다음 강의 일정</a>
						</p>
						<p>
							<a href="${pageContext.request.contextPath}/member/streamingCalendar.do">스트리밍 강의 일정</a>
						</p>
					</div>
					<div class="text-end">
						<span class=""><a href="#">캘린더 전체보기</a></span>
					</div>
				</div>
			</div>
			<div class="card m-5" style="max-width: 23rem;">
				<h3 class="card-header">알림</h3>
				<div class="card-body">
					<div class="alamList">
					<c:if test="${empty message}">
						<p class="card-text">등록된 알림이 없습니다.</p>
					</c:if>
					<c:if test="${not empty message}">
						<c:forEach items="${message}" var="message" end="2">
							<p class="card-text">
								<a href="${pageContext.request.contextPath}/alarm/alarmDetail.do?msgNo=${message.msgNo}">${message.msgTitle}</a> 
							</p>
						</c:forEach>
					</c:if>
					</div>
					<c:if test="${not empty message}">
						<div class="text-end">
							<span class=""><a href="${pageContext.request.contextPath}/alarm/alarmList.do">받은알림 목록</a></span>
						</div>
					</c:if>
				</div>
			</div>
		</div>
</section>
</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>