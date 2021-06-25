<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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

<script>
$(() => {
	//$("#input-id").rating();
	//$("#input-id").rating({min:1, max:10, step:2, size:'lg'});

	//Bootstrap Tooltip을 사용하기 위한 tooltip 초기화 코드
	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	  return new bootstrap.Tooltip(tooltipTriggerEl)
	});

	$(".overlay .btn").click(e => {

		//e.preventDefault(); //태그의 고유동작을 중단시킴(a태그 주소이동, submit버튼의 form전송 등)
		e.stopPropagation(); //상위 요소로의 이벤트전파 중단(태그 고유동작은 중단시키지 못함(ex.a태그의 주소이동)
	});
});

</script>
<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->

<div class="container">
	<div class="row justify-content-center">
		<div class="title m-5">
			<h2><spring:message code="search.title"/></h2>
		</div>
		<hr />
		<div class="row mt-2">
			<div class="row p-5">
			<!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
			<c:if test="${empty list}">
				<h5 colspan="14" style="text-align: center;"><spring:message code="help.noDataMsg"/></h5>
				<h6 style="text-align: center;">
					<a href="${empty pageContext.request.contextPath ? '/' : pageContext.request.contextPath}"><spring:message code="error.goHome"/></a>
			   </h6>
			</c:if>
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
						class="card-img-top" alt="..." style="height: 13rem;" />
					<div class="card-body">
						<h5 class="card-title">${lecture.lectureName}</h5>
						<p class="card-subtitle">${lecture.teacherName}</p>
						<p class="card-subtitle my-1">
							<c:forEach var="i" begin="1" end="5">
								<i
									class="${i <= lecture.avgLecAssessment ? 'fas' : 'far'} fa-star text-warning"></i>
							</c:forEach>
						</p>
						<p class="card-text">
							<c:choose>
								<c:when test="${lecture.lecturePrice == 0}">
									무료
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${lecture.lecturePrice}"
										type="currency" currencySymbol="￦" maxFractionDigits="0"/>
								</c:otherwise>
							</c:choose>
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
								${lecture.lectureIntro}</div>
						</div>
						<div class="row my-1">
							<div class="col-auto">카테고리 :
								${categoryMap.get(lecture.refLecCatNo)}</div>
						</div>
						<div class="row my-1">
							<div class="col-auto">강의종류 : ${lecture.lectureType eq 'V' ? '일반 강의' : '스트리밍 강의'}</div>
						</div>
						<div class="d-flex justify-content-end">
							<c:set var="contains" value="false" />
							<c:forEach var="item" items="${orderedlectureNoList}">
								<c:if test="${item eq lecture.lectureNo}">
									<c:set var="contains" value="true" />
								</c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${contains}">
									<div class="m-1">
										<p>이미 결제된 강의입니다.</p>
									</div>
								</c:when>
								<c:otherwise>
									<div class="m-1">
									<form:form id="basketFrm${lecture.lectureNo}"
										action="${pageContext.request.contextPath}${lecture.basketed ? '/order/deleteBasket.do' : '/order/addBasket.do'}"
										method="POST">
										<input name="lectureNo" type="hidden"
											value="${lecture.lectureNo}" type="hidden" />
										<button type="submit"
											class="btn ${lecture.basketed ? 'btn-light' : 'btn-outline-light'}"
											data-bs-toggle="tooltip" data-bs-placement="right"
											title="${lecture.basketed ? '장바구니에서 삭제' : '장바구니에 담기'}">
											<i
												class="${lecture.basketed ? 'fas fa-shopping-cart' : 'fas fa-cart-plus'}"></i>
										</button>
									</form:form>
									</div>
									<div class="m-1">
									<form:form id="pickFrm${lecture.lectureNo}"
										action="${pageContext.request.contextPath}${lecture.picked ? '/order/deletePick.do' : '/order/addPick.do'}"
										method="POST">
										<input name="lectureNo" type="hidden"
											value="${lecture.lectureNo}" type="hidden" />
										<button type="submit"
											class="btn ${lecture.picked ? 'btn-light' : 'btn-outline-light'}"
											data-bs-toggle="tooltip" data-bs-placement="right"
											title="${lecture.picked ? '찜삭제' : '찜하기'}">
											<i
												class="${lecture.picked ? 'far fa-trash-alt' : 'fas fa-heart'}"></i>
										</button>
									</form:form>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
			<c:if test="${(vs.count%4 == 0) || vs.last}">
				</div>
				</c:if>
				</c:forEach>
			</div>
			<!-- 강의 리스트 끝 -->
		</div>
	</div>
</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>