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
	width: 100px;
}

img#thumbImage {
	width: 450px;
	height: 300px;
}
</style>

<body>
<div class="container">
            <div class="mt-5 mx-auto form-group" style="width:fit-content;">
              <form name="lectureEnrollFrm"
                action="${pageContext.request.contextPath}/counsel/counselInsert.do?${_csrf.parameterName}=${_csrf.token}"
                method="post"
                enctype="multipart/form-data">
                <div class="row justify-content-center">
                  <!-- col-auto : 내부요소 크기에 맞게 컬럼 크기 맞춤 -->
                  <div class="col-auto">
                    <h2>고객 센터 </h2>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-2 align-self-center">
                    <label class="form-label" for="lectureName">제목</label>
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
                      id="lectureName" placeholder="제목" required>
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
				<label class="form-label mb-2" for="">내용</label>
				<div class="col-sm">
					<textarea name="lectureIntro" id="lectureIntro" class="form-control" required></textarea>
				</div>
			</div>
                
                
           
                <div class="row form-group justify-content-end">
                  <div class="col-sm-auto">
                  <button type="reset" class="btn btn-danger cancel-btn" onclick="location.href='${pageContext.request.contextPath}/counsel/counselList.do'">취소</button>
                    <button type="submit" class="btn btn-primary complete-btn">완료</button>
                  </div>
                </div>
              </form>
            </div>
          </div>

</body>
</html>