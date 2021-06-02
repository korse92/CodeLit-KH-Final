<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 목록" name="title"/>
</jsp:include>

<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->
<link href="${pageContext.request.contextPath}/resources/css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/theme-krajee-fa.css" media="all" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/theme-krajee-svg.css" media="all" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/theme-krajee-uni.css" media="all" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/star-rating.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/lecture.css" media="all" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	
</script>

<!-- 컨텐츠 헤더 시작 -->
<div class="container mt-5 mb-3">
 	<div class="row">
		<h2>수강중인 강의</h2>
	</div>
	<div class="row mt-2">
	</div>
</div>
<!-- 컨텐츠 헤더 끝 -->
<!-- 강의 리스트 시작 -->
<div class="container mt-3">
	<c:if test="${empty list}">
	<div class="d-flex justify-content-center mt-3">
		<h1>수강중인 강의가 없습니다.</h1>
	</div>
	</c:if>
	<c:if test="${not empty list}">
	<c:forEach items="${list}" var="lecture" varStatus="vs">
	<c:if test="${vs.count % 4 == 1}">
	<div class="row row-cols-auto">
	</c:if>
		<div class="col-sm-3 my-3">
			<!-- 이동 -->
			<c:choose>
				<c:when test='${lecture.lectureAcceptYn == "Y"}'>
					<div class="card mx-auto position-relative"
						style="cursor: pointer;"
						onclick="location.href='${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${lecture.lectureNo}';">
						<img
							src="${empty lecture.lectureThumbRenamed ?
										'https://via.placeholder.com/450x300.png?text=Thumbnail+Image'
										: pageContext.request.contextPath += '/resources/upload/lecture/thumbnails/' += lecture.lectureThumbRenamed}"
							class="card-img-top"
							alt="..."
							style="height: 13rem;"/>
				</c:when>
				<c:when test='${lecture.lectureAcceptYn == "W"}'>
					<div class="card mx-auto position-relative" style="cursor: no-drop;">
					<img
						src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/stop.jpg"
						class="card-img-top"
						alt="..."
						style="height: 13rem;"/>
				</c:when>
				<c:when test='${lecture.lectureAcceptYn == null}'>
					<div class="card mx-auto position-relative" style="cursor: no-drop;">
					<img
						src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/delete.jpg"
						class="card-img-top"
						alt="..."
						style="height: 13rem;"/>
				</c:when>
			</c:choose>
				<div class="card-body">
					<c:choose>
					<c:when test='${lecture.lectureAcceptYn == "Y"}'>
						<h5 class="card-title">${lecture.lectureName}</h5>
						<p class="card-subtitle">${lecture.refMemberId}</p>
						<p class="card-subtitle my-1">
					</c:when>
					<c:when test='${lecture.lectureAcceptYn == "W"}'>
						<h5 class="card-title">현재 정지되어있는 강의입니다.</h5>
						<p class="card-subtitle">현재 정지되어있는 강의입니다.</p>
						<p class="card-subtitle my-1">
					</c:when>
					<c:when test="${lecture.lectureAcceptYn == null}">
						<h5 class="card-title">삭제된 강의입니다.</h5>
						<p class="card-subtitle">삭제된 강의입니다.</p>
						<p class="card-subtitle my-1">
					</c:when>
					</c:choose>
					</p>
				</div>
					<div class="overlay d-flex flex-column justify-content-end p-3">
				<c:choose>
				<c:when test='${lecture.lectureAcceptYn == "Y"}'>
					<div class="row my-1">
						<div class="col-auto">
							<h5>${lecture.lectureName}</h5>
						</div>
					</div>
					<div class="row my-1">
						<div class="lecture-intro col-auto">
							${lecture.lectureIntro}
						</div>
					</div>
					<div class="row my-1">
						<div class="col-auto">카테고리 : ${categoryMap.get(lecture.refLecCatNo)}</div>
					</div>
					<div class="row my-1">
						<div class="col-auto">강의종류 : ${lecture.lectureType eq 'V' ? '일반 강의' : '스트리밍 강의'}</div>
					</div>
					<div class="d-flex justify-content-end">
					</div>
				</c:when>
				<c:when test='${lecture.lectureAcceptYn == "W"}'>
					<div class="row my-1">
						<div class="col-auto">
							<h5>${lecture.lectureName}</h5>
							<h4>정지 되어있는 상태입니다.</h4>
						</div>
					</div>
				</c:when>
				<c:when test="${lecture.lectureAcceptYn == null}">
					<div class="row my-1">
						<div class="col-auto">
							<h5>삭제된 강의입니다.</h5>
						</div>
					</div>
				</c:when>
				</c:choose>
				</div>
			</div>
		</div>
	<c:if test="${(vs.count%4 == 0) || vs.last}">
	</div>
	</c:if>
	</c:forEach>
	<div class="row my-3">
		${pageBar}
	</div>
	</c:if>
</div>
<!-- 강의 리스트 끝 -->
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>