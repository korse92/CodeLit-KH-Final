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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile.css" />

<section class="profile-Uclass">
<div class="container">
	  <!-- 유저 프로필 시작 -->
	  	<%-- <sec:authorize access="!hasRole('TEACHER') && hasRole('USER')"> --%>
		<div class="row m-5 p-5">
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">마이페이지</h3>
				<div class="card-body">
<<<<<<< HEAD
					<div class="card-text">
						<span class="fs-5"> 
							<sec:authentication property="principal.username" />
						</span> 
						<span class="fs-5">님</span> 
						<span class="fs-5">,&nbsp;안녕하세요.</span>
					</div>
=======
					<div class="img">
						<%--   <img src="${pageContext.request.contextPath}" alt=""> --%>
					</div>
					<p class="card-text">
						<span class="fs-5"> <sec:authentication
								property="principal.username" />
						</span> <span class="fs-5">님</span> <span class="fs-5">,&nbsp;안녕하세요.</span>
					</p>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
					<div class="text-end">
<<<<<<< HEAD
						<sapn class="link-box profile-update-box" onclick="location.href='${pageContext.request.contextPath}/member/memberDetail.do'">
							<span></span><span></span><span></span><span></span>
								프로필 수정
						</sapn>
=======
						<a href="${pageContext.request.contextPath}/member/memberDetail.do">프로필 수정</a>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">수강중인 강의</h3>
				<div class="card-body">
<<<<<<< HEAD
					<div class="card-text">
					<c:choose>
						<c:when test="${empty lectureList}">
							<h6 class="basket-list">수강중인 강의가 없습니다.</h6>
						</c:when>
						<c:when test="${not empty lectureList}">
							<c:forEach items="${lectureList}" var="lec" end="2">
								<ul>
									<li>
										<span onclick="location.href='${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${lec.lectureNo}'">
											${lec.lectureName}
										</sapn>
									</li>
								</ul>
							</c:forEach>
						</c:when>
					</c:choose>
=======
					<div class="basket">
						<p>
							<a href="#">수강중인 강의</a>
						</p>
						<p>
							<a href="#">수강중인 강의</a>
						</p>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
					</div>
					<div class="text-end">
<<<<<<< HEAD
					<c:choose>
					<c:when test="${empty lectureList}">
						<sapn class="text-end link-box" onclick="location.href='${pageContext.request.contextPath}/lecture/lectureList.do'">
							<span></span><span></span><span></span><span></span>
							강의 둘러보기
						</sapn>
					</c:when>
					<c:when test="${not empty lectureList}">
						<span class="link-box" onclick="location.href='${pageContext.request.contextPath}/member/memberLectureList.do'">
							<span></span><span></span><span></span><span></span>
							수강중인 강의 목록
						</span>
					</c:when>
					</c:choose>
=======
						<span class=""><a href="${pageContext.request.contextPath}/member/memberLectureList.do">수강중인 강의 목록</a></span>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">관심 강의</h3>
				<div class="card-body">
<<<<<<< HEAD
					<div class="card-text">
					<c:choose>
						<c:when test="${empty pickList}">
							<h6>찜목록에 강의가 존재하지 않습니다.</h6>
						</c:when>
						<c:when test="${not empty pickList}">
							<c:forEach items="${pickList}" var="pickList" end="2">
								<li>
									<span onclick="location.href='${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${pickList.refLectureNo}'">
											${pickList.lectureName} / ${pickList.teacherName} / ${pickList.lecturePrice != 0 ? pickList.lecturePrice : "무료"}
									</span>
								</li>
							</c:forEach>
						</c:when>
					</c:choose>
=======
					<div class="Calendar">
						<p>
							<a href="#">강의</a>
						</p>
						<p>
							<a href="#">강의</a>
						</p>
						<p>
							<a href="#">강의</a>
						</p>
						<p>
							<a href="#">강의</a>
						</p>
						<p>
							<a href="#">강의</a>
						</p>
						<p>
							<a href="#">강의</a>
						</p>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
					</div>
					<div class="text-end">
<<<<<<< HEAD
						<c:choose>
							<c:when test="${not empty pickList}">
								<span class="link-box" onclick='location.href="${pageContext.request.contextPath}/order/pick.do"'>
									<span></span><span></span><span></span><span></span>
									찜목록 가기
								</span>
							</c:when>
						</c:choose>
=======
						<span class=""><a href="#">강의 전체 보기</a></span>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">장바구니</h3>
				<div class="card-body">
<<<<<<< HEAD
					<div class="card-text">
						<c:choose>
							<c:when test="${empty basketList}">
								<h6>장바구니가 비어있습니다.</h6>
							</c:when>
							<c:when test="${not empty basketList}">
								<c:forEach items="${basketList}" var="basketList" end="2">
									<li >
										<span onclick="location.href='${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${basketList.refLectureNo}'">
											${basketList.lectureName}
										</span>
									</li>
								</c:forEach>
							</c:when>
						</c:choose>
=======
					<div class="Calendar">
						<p>
							<a href="#">장바구니 아이템</a>
						</p>
						<p>
							<a href="#">장바구니 아이템</a>
						</p>
						<p>
							<a href="#">장바구니 아이템</a>
						</p>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
					</div>
					<div class="text-end">
<<<<<<< HEAD
					<c:choose>
						<c:when test="${not empty basketList}">
						<span class="link-box" onclick='href="${pageContext.request.contextPath}/order/basket.do"'>
							<span></span><span></span><span></span><span></span>
							장바구니 바로가기
						</span>
						</c:when>
					</c:choose>
=======
						<span class=""><a href="#">장바구니 바로가기</a></span>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
				<h3 class="card-header">캘린더</h3>
				<div class="card-body">
					<div class="card-text">
						<p>
							<a href="#">다음 강의 일정</a>
						</p>
						<p>
							<a href="${pageContext.request.contextPath}/member/streamingCalendar.do">스트리밍 강의 일정</a>
						</p>
					</div>
					<div class="text-end">
					<span class="link-box" onclick="#">
						<span></span><span></span><span></span><span></span>
						캘린더 전체보기
					</span>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
<<<<<<< HEAD
=======
				<h3 class="card-header">구매 내역</h3>
				<div class="card-body">
					<div class="Calendar">
						<p>
							<a href="#">구매한 강의</a>
						</p>
						<p>
							<a href="#">구매한 강의</a>
						</p>
						<p>
							<a href="#">구매한 강의</a>
						</p>
					</div>
					<div class="text-end">
						<span class=""><a href="#">전체 구매내역</a></span>
					</div>
				</div>
			</div>
			<div class="card border-warning m-5" style="max-width: 23rem;">
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
				<h3 class="card-header">알림</h3>
				<div class="card-body">
					<div class="card-text">
					<c:if test="${empty message}">
						<p>등록된 알림이 없습니다.</p>
					</c:if>
					<c:if test="${not empty message}">
						<c:forEach items="${message}" var="message" end="2">
<<<<<<< HEAD
						<li >
							<span onclick="location.href='${pageContext.request.contextPath}/alarm/alarmDetail.do?msgNo=${message.msgNo}'">
								${message.msgTitle}
							</span>
						</li>
=======
							<p>
								<a href="${pageContext.request.contextPath}/alarm/alarmDetail.do?msgNo=${message.msgNo}">${message.msgTitle} / 
								${message.readYN = 'N' ? "읽지않음" : '읽음'}
								</a> 
							</p>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
						</c:forEach>
					</c:if>
					</div>
<<<<<<< HEAD
					<c:if test="${not empty message}">
						<span class="link-box" onclick='location.href="${pageContext.request.contextPath}/alarm/alarmList.do"'>
							<span></span><span></span><span></span><span></span>
							받은알림 목록
						</span>
					</c:if>
=======
						<div class="text-end">
							<span class=""><a href="${pageContext.request.contextPath}/alarm/alarmList.do">받은알림 목록</a></span>
						</div>
>>>>>>> branch 'master' of https://github.com/korse92/CodeLit-KH-Filnal.git
				</div>
			</div>
		</div>
</section>
</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>