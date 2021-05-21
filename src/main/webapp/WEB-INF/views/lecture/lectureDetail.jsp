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

<div class="container my-5">
	<div class="page-header">
		<h5>${categoryMap.get(lecture.refLecCatNo) }</h5>
		<h2 class="row">${lecture.lectureName}</h2>
		<div class="row">
			<div class="col-auto">${lecture. }</div>
			<div class="col-auto">${lecture.lectureCommentList.size()} / </div>
			<div class="col-auto">몇명의 수강생</div>
		</div>
		<div class="row">
			<div class="col-auto"><i class="fas fa-chalkboard-teacher"></i></div>
			<div class="col-auto"><a href="">${lecture.teacherName}</a></div>
		</div>
		<div class="row lec-thumbnail w-50">
			<img src="${pageContext.request.contextPath}/resources/upload/banner1.jpg" alt="" />
		</div>
	</div>
	<div class="page-body row my-3">
		<div class="tab-content col-8">
			<ul class="nav nav-tabs justify-content-start" id="myTab"
				role="tablist">
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
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade show active" id="intro" role="tabpanel"
					aria-labelledby="home-tab">
					${lecture.lectureIntro}
				</div>
				<div class="tab-pane fade" id="curriculum" role="tabpanel"
					aria-labelledby="profile-tab">
					<c:forEach items="${lecture.partList}" var="part">
					<h5>${part.lecturePartTitle}</h5>
					<ul>
						<c:forEach items="${part.chepterList}" var="chapter">
						<li>${chapter.lecChapterTitle}</li>
						</c:forEach>
					</ul>
					</c:forEach>
					<div class="accordion" id="accordionPanelsStayOpenExample">
						<div class="accordion-item">
							<h2 class="accordion-header" id="panelsStayOpen-headingOne">
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#panelsStayOpen-collapseOne"
									aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
									Accordion Item #1</button>
							</h2>
							<div id="panelsStayOpen-collapseOne"
								class="accordion-collapse collapse show"
								aria-labelledby="panelsStayOpen-headingOne">
								<div class="accordion-body">
									<strong>This is the first item's accordion body.</strong> It is
									shown by default, until the collapse plugin adds the
									appropriate classes that we use to style each element. These
									classes control the overall appearance, as well as the showing
									and hiding via CSS transitions. You can modify any of this with
									custom CSS or overriding our default variables. It's also worth
									noting that just about any HTML can go within the
									<code>.accordion-body</code>
									, though the transition does limit overflow.
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#panelsStayOpen-collapseTwo"
									aria-expanded="false"
									aria-controls="panelsStayOpen-collapseTwo">Accordion
									Item #2</button>
							</h2>
							<div id="panelsStayOpen-collapseTwo"
								class="accordion-collapse collapse"
								aria-labelledby="panelsStayOpen-headingTwo">
								<div class="accordion-body">
									<strong>This is the second item's accordion body.</strong> It
									is hidden by default, until the collapse plugin adds the
									appropriate classes that we use to style each element. These
									classes control the overall appearance, as well as the showing
									and hiding via CSS transitions. You can modify any of this with
									custom CSS or overriding our default variables. It's also worth
									noting that just about any HTML can go within the
									<code>.accordion-body</code>
									, though the transition does limit overflow.
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="panelsStayOpen-headingThree">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#panelsStayOpen-collapseThree"
									aria-expanded="false"
									aria-controls="panelsStayOpen-collapseThree">
									Accordion Item #3</button>
							</h2>
							<div id="panelsStayOpen-collapseThree"
								class="accordion-collapse collapse"
								aria-labelledby="panelsStayOpen-headingThree">
								<div class="accordion-body">
									<strong>This is the third item's accordion body.</strong> It is
									hidden by default, until the collapse plugin adds the
									appropriate classes that we use to style each element. These
									classes control the overall appearance, as well as the showing
									and hiding via CSS transitions. You can modify any of this with
									custom CSS or overriding our default variables. It's also worth
									noting that just about any HTML can go within the
									<code>.accordion-body</code>
									, though the transition does limit overflow.
								</div>
							</div>
						</div>
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