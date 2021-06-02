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
<style>
.container > .card > .card-body {
	padding-left: 3rem;
	padding-right: 3rem;
}
.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('${pageContext.request.contextPath}/resources/images/grade_img.png')no-repeat;}
.star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;}
.star-input>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}
.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
star-input>.input.focus{outline:1px dotted #ddd;}
.star-input>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input>.input>label:hover~label{background-image: none;}
.star-input>.input>label[for="p1"]{width:30px;z-index:5;}
.star-input>.input>label[for="p2"]{width:60px;z-index:4;}
.star-input>.input>label[for="p3"]{width:90px;z-index:3;}
.star-input>.input>label[for="p4"]{width:120px;z-index:2;}
.star-input>.input>label[for="p5"]{width:150px;z-index:1;}
.star-input>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}</style>
<script>
/* 	$('.accordion-collapse').on('show.bs.collapse', function () {
		if(!$(".accordion-collapse").hasClass('show'))
			$(allCollapseBtn).text('모두 접기');
	});
	$('.accordion-collapse').on('hide.bs.collapse', function () {
		if($(".accordion-collapse").hasClass('show'))
			$(allCollapseBtn).text('모두 펼치기');
	}); */
</script>
<c:if test="${not empty commentInserted}">
<script>
$(review-tab).trigger("click");
</script>
</c:if>

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
									<i class="${i <= lecture.avgLecAssessment ? 'fas' : 'far'} fa-star text-danger"></i>
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
					<c:set var="contains" value="false"/>
						<c:forEach var="item" items="${orderedlectureNoList}">
							<c:if test="${item eq lecture.lectureNo}">
								<c:set var="contains" value="true"/>
							</c:if>
						</c:forEach>
						<c:choose>
						<c:when test="${contains}">
<!-- 							<p id="commented" class="text-center ps-5">수강중인 강의 입니다!</p> -->
							<button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/lecture/lecture.do?lectureNo=${lecture.lectureNo}';">강의 듣기</button>
						</c:when>
						<c:otherwise>
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
							</div>
							</sec:authorize>
						</c:otherwise>
						</c:choose>
				</div>

			</div>
		</div>
		<div class="card-body">
			<ul class="nav nav-tabs mb-3" id="DetailTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="intro-tab" data-bs-toggle="tab"
						data-bs-target="#intro" type="button" role="tab"
						aria-controls="intro" aria-selected="true">강의 소개</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="curriculum-tab" data-bs-toggle="tab"
						data-bs-target="#curriculum" type="button" role="tab"
						aria-controls="curriculum" aria-selected="false">커리큘럼</button>
				</li>
				<sec:authorize access="!hasRole('ADMIN')">
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="review-tab" data-bs-toggle="tab"
						data-bs-target="#review" type="button" role="tab"
						aria-controls="review" aria-selected="false">강의 후기</button>
				</li>
				</sec:authorize>
			</ul>
			<div class="tab-content p-2" id="DetailTabContent" style="min-height: 500px;">
				<div class="tab-pane fade show active" id="intro" role="tabpanel"
					aria-labelledby="intro-tab">
					${lecture.lectureIntro}
				</div>
				<div class="tab-pane fade" id="curriculum" role="tabpanel"
					aria-labelledby="curriculum-tab">
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
				<!-- #review.tab-pane -->
				<div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
					<!-- Nav tabs -->
					<c:if test="${!empty lecture.lectureCommentList}">
					<ul class="nav nav-pills justify-content-end" id="reviewList-tab" role="tablist">
					<c:forEach var="i" begin="1" end="${totalCmtPage}" varStatus="vs">
						<li class="nav-item" role="presentation">
							<button class="nav-link ${vs.first ? 'active' : ''}" id="cmt-pageBtn${i}" data-bs-toggle="pill" data-bs-target="#cmt-page${i}" type="button" role="tab" aria-controls="cmt-page${i}" aria-selected="${vs.first ? 'true' : 'false'}">${i}</button>
						</li>
					</c:forEach>
					</ul>
					</c:if><!-- Nav tabs -->

					<!-- 후기 작성 row 시작 -->
					<c:set var="contains" value="false"/>
					<c:forEach var="item" items="${orderedlectureNoList}">
						<c:if test="${item eq lecture.lectureNo}">
							<c:set var="contains" value="true"/>
						</c:if>
					</c:forEach>
					<c:set var="commented" value="false"/>
					<c:forEach var="cmt" items="${lecture.lectureCommentList}">
						<c:if test="${cmt.refMemberId eq memberId}">
							<c:set var="commented" value="true"/>
						</c:if>
					</c:forEach>
					<c:choose>
					<c:when test="${contains and not commented}">
					<div class="row">
						<div class="input-group my-3">
							<form:form id="cmtFrm" action="${pageContext.request.contextPath}/lecture/cmtInsert.do" method="POST">
							<span class="star-input">
								<span class="input">
							    	<input type="radio" name="lecAssessment" value="1" id="p1">
							    	<label for="p1">1</label>
							    	<input type="radio" name="lecAssessment" value="2" id="p2">
							    	<label for="p2">2</label>
							    	<input type="radio" name="lecAssessment" value="3" id="p3">
							    	<label for="p3">3</label>
							    	<input type="radio" name="lecAssessment" value="4" id="p4">
							    	<label for="p4">4</label>
							    	<input type="radio" name="lecAssessment" value="5" id="p5">
							    	<label for="p5">5</label>
							  	</span>
							  	<output for="lecAssessment" id="lecAssessment"><b>0</b>점</output>
							</span>
						<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
						<script src="${pageContext.request.contextPath}/resources/js/star.js"></script>
						</div>
						<div class="input-group my-3">
							<input name="refLectureNo" id="refLectureNo" type="hidden" value="${lecture.lectureNo}" type="hidden" />
							<input class="form-control" id="lecComment" name="lecComment" type="text" placeholder="후기 작성">
							<button type="submit" class="btn btn-primary" id="cmtInsertBtn"><i class="fas fa-edit"></i> 입력 </button>
							</form:form>
						</div>
					</div>
					</c:when>
					<c:when test="${commented}">
						<p id="commented" class="text-center ps-5 my-3">이미 수강후기를 남기셨습니다.</p>
					</c:when>
					<c:otherwise>
						<p id="noPayment" class="text-center ps-5 my-3">수강하지 않은 강의 입니다.</p>
					</c:otherwise>
					</c:choose>
					<!-- 후기 작성 row 끝 -->

					<!-- 후기리스트 tab-content -->
					<div class="tab-content" id="reviewList-tabContent">
						<!-- 후기리스트 tabpane 시작 -->
						<c:choose>
							<c:when test="${!empty lecture.lectureCommentList}">
								<c:forEach items="${lecture.lectureCommentList}" var="cmt" varStatus="vs">
									<c:if test="${vs.count % numPerCmtPage == 1 or vs.first}">
									<fmt:parseNumber var="pageNo" integerOnly="true" value="${vs.count/numPerCmtPage + 1}"/>
									<!-- Tab panes(후기 리스트) -->
									<div class="tab-pane fade ${vs.first ? 'show active' : ''}" id="cmt-page${pageNo}" role="tabpanel" aria-labelledby="cmt-pageBtn${pageNo}">
									</c:if>
										<!-- 후기 개별card 시작 -->
										<div class="card my-3 text-dark bg-light cmtGroup">
											<div class="card-header">
												<h5 class="card-title">${cmt.refMemberId}</h5>
												<h6 class="card-subtitle">
												<input type="hidden" class="lecAssessment" value="${cmt.lecAssessment}"/>
													<c:forEach var="i" begin="1" end="5">
														<i class="${i <= cmt.lecAssessment ? 'fas' : 'far'} fa-star text-danger"></i>
													</c:forEach>
												</h6>
											</div>
											<div class="card-body">
												<p class="card-text lecComment">${cmt.lecComment}</p>
											</div>
											<div class="card-footer text-muted text-end">
												<p class="fs-6 m-0">
													<fmt:formatDate value="${cmt.lecCmtEnrollDate}" pattern="yy/MM/dd"/>
													<c:if test="${cmt.refMemberId eq memberId}">
													<button type="button" class="btn" onclick="updateCmt(event);"><i class="far fa-edit"></i></button>
													</c:if>
												</p>
											</div>
										</div>
										<!-- 후기 개별card 끝 -->
									<c:if test="${vs.count % numPerCmtPage == 0 or vs.last}">
									</div><!-- Tab panes(후기 리스트) -->
									</c:if>
								</c:forEach>
								<!-- 후기리스트 tabpane 끝 -->
							</c:when>
							<c:otherwise>
								<p id="noReview" class="text-center ps-5">아직 후기가 없습니다.</p>
							</c:otherwise>
						</c:choose>

					</div><!-- 후기리스트 tab-content -->
				</div><!-- #review.tab-pane -->
			</div>
		</div>
	</div>
</div>
<!-- 컨텐츠 끝 -->
<script>
$("#cmtInsertBtn").on('click', function(){
	var lecComment = $("#lecComment").val();
	var checked = $('input:radio[name="lecAssessment"]:checked').length;
	if(lecComment === ''){
		alert('후기를 작성해 주세요!');
		return false;
	}
	if(checked == 0){
		alert('점수를 남겨주세요!');
		return false;
	}
});
function updateCmt(e){
	$("#updateCmt").modal("show");
	var $cardParent = $(e.target).parents(".cmtGroup");
	var $lecAssessment = $cardParent.find('.lecAssessment').val();
	var $lecComment = $cardParent.find('.lecComment').text();
	console.log($cardParent);
	console.log($lecAssessment);
	console.log($lecComment);
	$("#updateCmt #lecComment").val($lecComment);
	$("#updateCmt #p" + $lecAssessment + "[name=lecAssessment]").prop("checked", true);
	//var lecAssessment = $('input:radio[name="lecAssessment"]:checked').val();
	//console.log(content);
	//console.log(lecAssessment);
	//$("#lecComment").val(content);
	//$('input:radio[name="lecAssessment"]').val(lecAssessment);
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>