<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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


<!-- 컨텐츠 헤더 시작 -->
<div class="container mt-5 mb-3">
 	<div class="row">
		<h2>수강중인 강의</h2>
	</div>
	<div class="row mt-2">
	</div>
</div>
<div class="container">
	<div class="row">
		<div class="col-sm-auto">
			<select class="form-select">
				<option value="1">모든 수업보기</option>
				<option value="2">학습중인 강의</option>
				<option value="3">완료한 강의</option>
			</select>
		</div>
		<div class="col-sm-auto">
			<select class="form-select">
				<option value="1">최근 학습한 강의</option>
				<option value="2">강의 제목순</option>
			</select>
		</div>
	</div>
</div>
<!-- 컨텐츠 헤더 끝 -->
<!-- 강의 리스트 시작 -->
<div class="container mt-3">
	<c:forEach items="${list}" var="lecture" varStatus="vs">
	<c:if test="${vs.count % 4 == 1}">
	<div class="row row-cols-auto">
	</c:if>
		<div class="col-sm-3 my-3">
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
				<div class="card-body">
					<h5 class="card-title">${lecture.lectureName}</h5>
					<p class="card-subtitle">${lecture.teacherName}</p>
					<p class="card-subtitle my-1">
						<c:forEach var="i" begin="1" end="5">
							<i class="${i <= lecture.avgLecAssessment ? 'fas' : 'far'} fa-star text-warning"></i>
						</c:forEach>
					</p>
					<p class="card-text">
						학습률 : 
					</p>
				</div>
				<div class="overlay d-flex flex-column justify-content-end p-3">
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
</div>
<!-- 강의 리스트 끝 -->
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>