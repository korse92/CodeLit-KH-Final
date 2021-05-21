<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
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
<link href="${pageContext.request.contextPath}/resources/css/lecture.css" media="all" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/star-rating.js"></script>

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
			//alert("테스트");
			
			//location.href = "${pageContext.request.contextPath}";
			
			//e.stopPropagation(); //상위 요소로의 이벤트전파 중단(태그 고유동작은 중단시키지 못함(ex.a태그의 주소이동)
			e.preventDefault(); //태그의 고유동작을 중단시킴(a태그 주소이동, submit버튼의 form전송 등)
		});
	});
</script>

<div class="container my-5">
 	<div class="page-header row">
		<div class="col-sm-auto me-auto">
			<h2>강의 목록</h2>
		</div>
	</div>
	<hr />
	<div class="page-body row align-items-start mt-4">
		<nav class="col-sm-2 px-0">
			<ul class="nav nav-pills flex-column text-center">
			<%-- ${empty catNo ? '모든 강의' : categoryMap.get(catNo)} --%>
				<li class="nav-item">
					<a  class="nav-link ${empty catNo ? 'active' : ''}"
						href="${pageContext.request.contextPath}/lecture/lectureList.do">모든 강의</a>
				</li>
				<c:forEach items="${categoryList}" var="category">
				<li class="nav-item">
					<a  class="nav-link ${catNo eq category.no ? 'active' : ''}"
						href="${pageContext.request.contextPath}/lecture/lectureList.do/${category.no}">${category.name}</a>
				</li>
				</c:forEach>
			</ul>
		</nav>
		<!-- 강의 리스트 시작 -->
		<div class="col">
			<div class="row justify-content-end">
				<div class="col-sm-auto">
					<div class="input-group">
						<div class="form-outline">
							<input type="search" id="form1" class="form-control" placeholder="강의자 / 강의명" />
						</div>
						<button type="button" class="btn btn-primary">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>
				<div class="col-sm-auto">
					<select class="form-select">
						<option selected>정렬</option>
						<option value="1">인기순</option>
						<option value="2">최신순</option>
					</select>
				</div>
			</div>
			<c:forEach items="${list}" var="lecture" varStatus="vs">
			<c:if test="${vs.count % 4 == 1}">
			<div class="row my-4 px-5">
			</c:if>
				<div class="col-sm-3">
					<a href="${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${lecture.lectureNo}" class="text-decoration-none text-dark">
						<div class="card mx-auto position-relative" style="width: 15rem;">
							<img
								src="${empty lecture.lectureThumbRenamed ?
											'https://via.placeholder.com/450x300.png?text=Thumbnail+Image'
											: pageContext.request.contextPath += '/resources/upload/lecture/thumbnails/' += lecture.lectureThumbRenamed}"
								class="card-img-top"
								alt="..."
								style="height: 10rem;"/>
							<div class="card-body">
								<h5 class="card-title">${lecture.lectureName}</h5>
								<p class="card-text">${lecture.teacherName}</p>
								<p class="card-text">
									${lecture.avgLecAssessment}
								</p>
								<p class="card-text">
									<c:choose>
										<c:when test="${lecture.lecturePrice == 0}">
										무료
										</c:when>
										<c:otherwise>
										<fmt:formatNumber value="${lecture.lecturePrice}" type="currency"/>
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
									<div class="m-1">
										<button
											class="btn btn-outline-light" data-bs-toggle="tooltip"
											data-bs-placement="right" title="장바구니에 담기"
											onclick = "location.href = 'test'">
											<i class="fas fa-shopping-basket"></i>
										</button>
									</div>
									<div class="m-1">
										<button
											class="btn btn-outline-light" data-bs-toggle="tooltip"
											data-bs-placement="right" title="찜하기">
											<i class="fas fa-heart"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
					</a>
				</div>
			<c:if test="${vs.count % 4 == 0}">
			</div>
			</c:if>
			</c:forEach>
			<div class="row my-3">
				${pageBar}
			</div>
		</div>
		<!-- 강의 리스트 끝 -->
	</div>
</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>