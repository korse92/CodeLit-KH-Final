<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 상세페이지" name="title"/>
</jsp:include>

<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->

<div class="container my-3">
	<div class="card">
		<div class="card-header">
			<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecture/lectureList.do">전체 목록</a></li>
					<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecture/lectureList.do/${lecture.refLecCatNo}">${categoryMap.get(lecture.refLecCatNo)}</a></li>
					<li class="breadcrumb-item active" aria-current="page">현재 페이지</li>
				</ol>
			</nav>
		</div>
		<div class="card-body">
			<h2 class="card-title">${lecture.lectureName}</h2>
			<div class="card-subtitle text-muted">
				<div class="row">
					<div class="col-auto">
					<c:forEach var="i" begin="1" end="5">
						<i class="${i <= lecture.avgLecAssessment ? 'fas' : 'far'} fa-star text-warning"></i>
					</c:forEach>


					</div>
					<div class="col-auto">후기 : ${lecture.lectureCommentList.size()} 개</div>
					<div class="col-auto">수강생 : 몇명</div>
				</div>
				<div class="row">
					<div class="col-auto">
						<i class="fas fa-chalkboard-teacher"></i>
					</div>
					<div class="col-auto">
						<a href="${lecture.teacher.teacherLink}" target="_blank">${lecture.teacher.teacherName}</a>
					</div>
				</div>
			</div>
			<div class="row lec-thumbnail w-50">
				<img src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${lecture.lectureThumbRenamed}" alt="" />
			</div>
		</div>
		<div class="card-body">
			<ul class="nav nav-tabs mb-3" id="DetailTab" role="tablist">
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
			<div class="tab-content" id="DetailTabContent" style="min-height: 500px;">
				<div class="tab-pane fade show active" id="intro" role="tabpanel"
					aria-labelledby="home-tab">
					${lecture.lectureIntro}
				</div>
				<div class="tab-pane fade" id="curriculum" role="tabpanel"
					aria-labelledby="profile-tab">
					<div class="accordion" id="curriculumAccordionPanels">
						<c:forEach items="${lecture.partList}" var="part">
						<div class="accordion-item">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#collapseChapterOfPart${part.lecturePartNo}"
									aria-expanded="false" aria-controls="collapseChapterOfPart${part.lecturePartNo}">
									<i class="fas fa-bars me-3"></i><span>${part.lecturePartTitle}</span>
								</button>
							</h2>
							<div id="collapseChapterOfPart${part.lecturePartNo}"
								class="accordion-collapse collapse"
								aria-labelledby="partPanel${part.lecturePartNo}">
								<div class="accordion-body">
							<c:forEach items="${part.chepterList}" var="chapter">
								<h5>${chapter.lecChapterTitle}</h5>
							</c:forEach>
								</div>
							</div>
						</div>
						</c:forEach>
					</div>
				</div>
				<div class="tab-pane fade" id="review" role="tabpanel"
					aria-labelledby="contact-tab">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>