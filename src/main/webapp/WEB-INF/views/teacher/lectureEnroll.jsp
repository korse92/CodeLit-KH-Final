<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 등록" name="title"/>
</jsp:include>
<!-- 컨텐츠 시작 -->
<!-- 개인 CSS, JS 위치 -->
<style>
.form-group .row {
	margin-top: 1rem;
	margin-bottom: 1rem;
}

.form-group .form-label {
	margin-bottom: 0px;
}
</style>

<div class="container">
	<div class="mt-5 mx-auto form-group" style="width: fit-content;">
		<form name="lectureEnrollFrm" action="" method="post"
			enctype="multipart/form-data">
			<div class="row justify-content-center">
				<!-- col-auto : 내부요소 크기에 맞게 컬럼 크기 맞춤 -->
				<div class="col-auto">
					<h2>강의 등록</h2>
				</div>
			</div>
			<input type="hidden" name="memberId">
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lectureName">강의 제목</label>
				</div>
				<div class="col-sm-4">
					<select class="form-select" name="refLecCatNo" required>
						<option value="" disabled selected>카테고리 선택</option>
						<option value="1">백앤드</option>
						<option value="2">프론트앤드</option>
						<option value="3">빅데이터</option>
						<option value="4">보안</option>
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
					<input class="form-check-input" type="radio" name="lectureType"	id="lectureType1" required>
					<label class="form-check-label me-3" for="lectureType1">일반 강의</label>
					<input class="form-check-input" type="radio" name="lectureType"	id="lectureType2">
					<label class="form-check-label"	for="lectureType2">스트리밍 강의</label>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lecturePrice">수강료</label>
				</div>
				<div class="col-sm">
					<input class="form-control" type="number" name="lecturePrice"
						id="lecturePrice" required>
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
				<div class="col-sm">
					<img
						src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image"
						class="img-thumbnail w-100" id="thumbImage" alt="썸네일 이미지">
					<input
						class="form-control d-none" type="file" name="lectureThumbnail"
						id="lectureThumbnail">
				</div>
			</div>
			<div class="row form-group justify-content-end">
				<div class="col-sm-auto">
					<input class="btn btn-warning btn" type="reset" value="취소 or 뒤로">
					<input class="btn btn-primary" type="submit" value="다음">
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
</script>

<!-- 컨텐츠 끝 -->