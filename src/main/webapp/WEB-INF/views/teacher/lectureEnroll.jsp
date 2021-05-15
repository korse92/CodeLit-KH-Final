<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 등록" name="title"/>
</jsp:include>
<!-- 컨텐츠 시작 -->
<!-- 개인 CSS, JS 위치 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor/ckeditor.js"></script>
<style>
.form-group .row {
	margin-top: 1rem;
	margin-bottom: 1rem;
}

.form-group .form-label {
	margin-bottom: 0px;
}

img#thumbImage {
	width: 450px;
	height: 300px;
}
</style>

<div class="container">
	<div class="mt-5 mx-auto form-group" style="width:fit-content;">
		<form name="lectureEnrollFrm"
			action="${pageContext.request.contextPath}/teacher/lectureEnroll.do?${_csrf.parameterName}=${_csrf.token}"
			method="post"
			enctype="multipart/form-data">
			<div class="row justify-content-center">
				<!-- col-auto : 내부요소 크기에 맞게 컬럼 크기 맞춤 -->
				<div class="col-auto">
					<h2>강의 등록</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lectureName">강의 제목</label>
				</div>
				<div class="col-sm-4">
					<select class="form-select" name="refLecCatNo" required>
						<option value="" disabled selected>카테고리 선택</option>
						<c:forEach items="${categoryList}" var="category">
						<option value="${category.no}">${category.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-6">
					<input class="form-control" type="text" name="lectureName"
						id="lectureName" placeholder="강의 제목" required>
				</div>
			</div>
			<div class="row justify-content-between">
				<div class="col-sm-2 align-self-center">
					<label class="form-label">강의 종류</label>
				</div>
				<div class="col-sm-auto">
					<input class="form-check-input" type="radio" name="lectureType"	id="lectureType1" value="V" required>
					<label class="form-check-label me-3" for="lectureType1">일반 강의</label>
					<input class="form-check-input" type="radio" name="lectureType"	id="lectureType2">
					<label class="form-check-label"	for="lectureType2" value="S">스트리밍 강의</label>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lecturePrice">수강료</label>
				</div>
				<div class="col-sm">
					<input class="form-control" type="number" name="lecturePrice" min="0"
						id="lecturePrice" placeholder="무료 강의일 경우 0을 입력해주세요." required>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lectureHandout">첨부파일</label>
				</div>
				<div class="col-sm">
					<input class="form-control" type="file" name="lectureHandout"
						id="lectureHandout">
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lectureThumbnail">썸네일</label>
				</div>
				<div class="col-sm-10">
					<img
						src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image"
						class="img-thumbnail w-100" id="thumbImage" alt="썸네일 이미지">
					<input
						class="form-control d-none" type="file" name="lectureThumbnail"
						id="lectureThumbnail">
				</div>
			</div>
			<div class="row">
				<label class="form-label mb-2" for="">강의 소개글</label>
				<div class="col-sm">
					<textarea name="lectureIntro" id="lectureIntro" class="form-control"></textarea>
				</div>
			</div>
			<div id="selectedVideo" class="row">
				<div class="row">
					<label class="form-label mb-2" for="lectureGuideline">가이드라인 (권장하는 하루에 들을 영상개수)</label>
					<div class="col-sm">
						<input class="form-control" type="number" name="lectureGuideline" min="1" max="10"
							id="lectureGuideline" placeholder="입력안할 시 기본값 1, 최대 10">
					</div>
				</div>
			</div>
			
			<div id="selectedStreaming" class="d-none row">
				<label class="form-label mb-2" for="">강의일정</label>
				<div class="col-sm">
					<p>풀캘린더 들어갈곳</p>
					<input type="hidden" name="streamingDateList" />
				</div>
			</div>
			<div class="row form-group justify-content-end">
				<div class="col-sm-auto">
					<input class="btn btn-warning btn" type="reset" value="리셋">
					<input class="btn btn-primary" type="submit" value="등록 요청">
				</div>
			</div>
		</form>
	</div>
</div>
<script>
  $(thumbImage).click(e => {
    $(lectureThumbnail).trigger('click');
  });

  $(lectureThumbnail).change(e => {
    const target = e.target;
    const files = target.files;

    // FileReader support
    if (FileReader && files && files.length) {
        var fr = new FileReader();
        fr.onload = function () {
            document.getElementById("thumbImage").src = fr.result;
        }
        fr.readAsDataURL(files[0]);
    }
    // Not supported
    else {
        // fallback -- perhaps submit the input to an iframe and temporarily store
        // them on the server until the user's session ends.
        document.getElementById("thumbImage").src = "https://via.placeholder.com/450x300.png?text=Thumbnail+Image";
    }
  });

  $("[name=lectureEnrollFrm").on('reset', e => {
    document.getElementById("thumbImage").src = "https://via.placeholder.com/450x300.png?text=Thumbnail+Image";
  });
  
  //ckeditor 생성
  CKEDITOR.replace('lectureIntro', {
	  height: 500
  });
  
  $("[name=lectureEnrollFrm]").submit(e => {
	  var $lectureGuideline = $(lectureGuideline)
	  if(!$lectureGuideline.val()){
		  $lectureGuideline.val(1);
		  
	  }
  });

</script>

<!-- 컨텐츠 끝 -->