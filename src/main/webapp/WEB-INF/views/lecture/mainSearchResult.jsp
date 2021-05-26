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
	<jsp:param value="CodeLit" name="title" />
</jsp:include>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->
<script src="${pageContext.request.contextPath}/resources/js/rolling.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/rolling.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">

<link
	href="${pageContext.request.contextPath}/resources/css/star-rating.css"
	media="all" rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/theme-krajee-fa.css"
	media="all" rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/theme-krajee-svg.css"
	media="all" rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/theme-krajee-uni.css"
	media="all" rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/lecture.css"
	media="all" rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/resources/js/star-rating.js"></script>


<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->

<div class="container">

	<div class="row justify-content-center">

		<div class="title m-5">
			<h2>강의 검색</h2>
		</div>
		<hr />
		<div class="row mt-2">
			<div class="row main-content p-5">
				<!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 하세요 -->
				<c:if test="${empty list}">
					<tr>
						<h5 colspan="14" style="text-align: center;">조회된 검색 결과가 없습니다.</h5>
						<h6 style="text-align: center;">
							<a href="${pageContext.request.contextPath}">메인으로 돌아가기</a>
						</h6>
					</tr>
				</c:if>
				<c:forEach items="${list}" var="result" varStatus="vs">
					<c:if test="${vs.count % 4 == 1}">
						<div class="row row-cols-auto my-1 px-5 justify-content-center">
					</c:if>
					<div class="col-sm-3">
						<div class="card position-relative text-decoration-none text-dark"
							style="cursor: pointer;"
							onclick="location.href='${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${result.lectureNo}';">
							<img
								src="${empty result.lectureThumbRenamed ? 'https://via.placeholder.com/450x300.png?text=Thumbnail+Image'
								:pageContext.request.contextPath += '/resources/upload/lecture/thumbnails/' += result.lectureThumbRenamed}"
								class="card-img-top" alt="..." style="height: 10rem;" />
							<div class="card-body">
								<h5 class="card-title">${result.lectureName}</h5>
								<div class="card-text text-end">
									<c:choose>
										<c:when test="${result.lecturePrice == 0}">
							   무료
							  </c:when>
										<c:otherwise>
											<fmt:formatNumber value="${result.lecturePrice}"
												type="currency" />
										</c:otherwise>
									</c:choose>
								</div>
								<div class="card-text text-end">${result.teacherName}</div>
							</div>
							<div class="overlay d-flex flex-column justify-content-start p-3">
								<div class="row my-2">
									<div class="col-auto">
										<c:forEach items="${categoryList}" var="category">
											<c:if test="${category.no eq mainLec.refLecCatNo}">
												<h4>${category.name}</h4>
											</c:if>
										</c:forEach>
									</div>
								</div>
								<div class="row my-2">
									<div class="col-auto">
										<h5>${result.lectureName}</h5>
									</div>
								</div>
								<div class="row my-1">
									<div class="lecture-intro col-auto">
										<h6>${result.lectureIntro}</h6>
									</div>
								</div>
							</div>
						</div>
					</div>
					<c:if test="${vs.count % 4 == 0}">
			</div>
			</c:if>
			</c:forEach>
		</div>
	</div>
</div>

<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>