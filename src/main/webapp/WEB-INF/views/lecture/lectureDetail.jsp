<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
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
<style>
.card-body {
	padding-left: 3rem;
	padding-right: 3rem;
}
</style>

<script>
$(() => {

/* 	$('.accordion-collapse').on('show.bs.collapse', function () {
		if(!$(".accordion-collapse").hasClass('show'))
			$(allCollapseBtn).text('모두 접기');
	});
	$('.accordion-collapse').on('hide.bs.collapse', function () {
		if($(".accordion-collapse").hasClass('show'))
			$(allCollapseBtn).text('모두 펼치기');
	}); */
});

</script>

<div class="container my-3">
	<div class="card mx-auto">
		<div class="card-header mb-3">
		<!-- 분기처리 -->
			<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
				<ol class="breadcrumb mb-0">
					<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecture/lectureList.do" class="text-decoration-none">전체 목록</a></li>
					<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecture/lectureList.do/${lecture.refLecCatNo}" class="text-decoration-none">${categoryMap.get(lecture.refLecCatNo)}</a></li>
					<li class="breadcrumb-item active" aria-current="page">현재 페이지</li>
				</ol>
			</nav>
		</div>
		<div class="card-body">
			<div class="row justify-content-between">
				<div class="col-sm-6">
					<img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${lecture.lectureThumbRenamed}" alt=""/>
				</div>
				<div class="col-sm-5 align-self-end">
					<div class="row">
						<h2 class="card-title">${lecture.lectureName}</h2>
						<div class="card-subtitle text-muted mt-2">
							<div class="row">
							<!-- 분기처리 -->
							<sec:authorize access="!hasRole('ADMIN')">
								<div class="col-sm-auto">
								<c:forEach var="i" begin="1" end="5">
									<i class="${i <= lecture.avgLecAssessment ? 'fas' : 'far'} fa-star text-warning"></i>
								</c:forEach>
								</div>
								<div class="col-sm-auto">후기 : ${lecture.lectureCommentList.size()} 개</div>
								<div class="col-auto">수강생 : 몇명</div>
							</sec:authorize>
							</div>
							<div class="row my-1">
								<div class="col-sm-auto">
									<i class="fas fa-chalkboard-teacher"></i>
								</div>
								<div class="col-auto">
									<a href="${lecture.teacher.teacherLink}" class="text-muted" target="_blank">${lecture.teacher.teacherName}</a>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<p class="h3 text-end">
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
					<sec:authorize access="!hasRole('ADMIN')">
					<div class="row">
						<div class="col-sm-2 p-0 me-2">
							<button type="button" class="btn btn-outline-danger w-100" data-bs-toggle="tooltip" data-bs-placement="left" title="찜하기">
								<i class="fas fa-heart"></i>
							</button>
						</div>
						<div class="col-sm p-0">
							<button type="button" class="btn btn-warning w-100" data-bs-toggle="tooltip" data-bs-placement="right" title="장바구니에 담기">
								결제
							</button>
						</div>
						</sec:authorize>
					
				</div>

			</div>

		</div>
		<div class="card-body">
			<ul class="nav nav-tabs mb-3" id="DetailTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link ${!reviewOpen ? 'active' : ''}" id="intro-tab" data-bs-toggle="tab"
						data-bs-target="#intro" type="button" role="tab"
						aria-controls="intro" aria-selected="${!reviewOpen ? 'true' : 'false'}">강의 소개</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="curriculum-tab" data-bs-toggle="tab"
						data-bs-target="#curriculum" type="button" role="tab"
						aria-controls="curriculum" aria-selected="false">커리큘럼</button>
				</li>
				<sec:authorize access="!hasRole('ADMIN')">
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
						data-bs-target="#review" type="button" role="tab"
						aria-controls="review" aria-selected="false">강의 후기</button>
				</li>
				</sec:authorize>
			</ul>
			<div class="tab-content p-2" id="DetailTabContent" style="min-height: 500px;">
				<div class="tab-pane fade show active" id="intro" role="tabpanel"
					aria-labelledby="home-tab">
					${lecture.lectureIntro}
				</div>
				<div class="tab-pane fade" id="curriculum" role="tabpanel"
					aria-labelledby="profile-tab">
					<button id="allCollapseBtn"
						class="btn btn-primary d-block ms-auto mb-3" type="button" data-bs-toggle="collapse"
						data-bs-target=".accordion-collapse" aria-expanded="false">모두 펼치기 / 접기</button>
					<div class="accordion" id="curriculumAccordionPanels">
						<c:forEach items="${lecture.partList}" var="part" varStatus="pvs">
						<div class="accordion-item">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#collapseChapterOfPart${part.lecturePartNo}"
									aria-expanded="false" aria-controls="collapseChapterOfPart${part.lecturePartNo}">
									<i class="fas fa-bars me-3"></i>
									<span>파트 ${pvs.count }. ${part.lecturePartTitle}</span>
									<span class="badge bg-primary ms-2">${part.chepterList.size()}</span>
								</button>
							</h2>
							<div id="collapseChapterOfPart${part.lecturePartNo}"
								class="accordion-collapse collapse"
								aria-labelledby="partPanel${part.lecturePartNo}">
								<div class="accordion-body px-0">
									<ul class="list-group-flush p-0 m-0">
										<c:forEach items="${part.chepterList}" var="chapter" varStatus="cvs">
										<li class="list-group-item">
											<i class="fas fa-play-circle"></i>
											<span>챕터 ${cvs.count}. ${chapter.lecChapterTitle}</span>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
						</c:forEach>
					</div>
				</div>
				<div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="contact-tab">
					<!-- Nav tabs -->
					<c:if test="${!empty lecture.lectureCommentList}">
						<ul class="nav nav-pills justify-content-end" id="myTab" role="tablist">
						<c:forEach var="i" begin="1" end="${totalCmtPage}" varStatus="vs">
							<li class="nav-item" role="presentation">
								<button class="nav-link ${vs.first ? 'active' : ''}" id="cmt-pageBtn${i}" data-bs-toggle="tab" data-bs-target="#cmt-page${i}" type="button" role="tab" aria-controls="cmt-page${i}" aria-selected="true">${i}</button>
							</li>
						</c:forEach>
							<!--
							<li class="nav-item" role="presentation">
						  		<button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">2</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="messages-tab" data-bs-toggle="tab" data-bs-target="#messages" type="button" role="tab" aria-controls="messages" aria-selected="false">3</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="settings-tab" data-bs-toggle="tab" data-bs-target="#settings" type="button" role="tab" aria-controls="settings" aria-selected="false">4</button>
							</li>
							-->
						</ul>


						<!-- Tab panes -->
						<div class="tab-content">
							<c:forEach items="${lecture.lectureCommentList}" var="cmt" varStatus="vs">
							<c:if test="${vs.count % numPerCmtPage == 1 or vs.first}"> <%-- ${(int)Math.ceil((double)lecture.getLectureCommentList().size() / numPerCmtPage) } --%>
							<fmt:parseNumber var="pageNo" integerOnly="true" value="${vs.count/numPerCmtPage + 1}"/>
							<div class="tab-pane ${vs.first ? 'active' : ''}" id="cmt-page${pageNo}" role="tabpanel" aria-labelledby="cmt-pageBtn${pageNo}">
							</c:if>
								<div class="row">

									${cmt}
								</div>
							<c:if test="${vs.count % numPerCmtPage == 0 or vs.last}">
							</div>
							</c:if>
							</c:forEach>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>