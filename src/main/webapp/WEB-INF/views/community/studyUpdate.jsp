<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">
<script>
window.onload = function() {
  let upFile = document.getElementById('upFile');
  let thumb = document.getElementById('photo_img');
  upFile.addEventListener('change', function(e) {
    
    if(upFile.files[0] != null) {
      thumb.src = URL.createObjectURL(upFile.files[0]);
    } else {
      thumb.src = "";
    }
  });
}
//유효성검사
function checkContent() {
	const title = $("[name=stdBrdTitle]");
	const content = $("[name=stdBrdContent]");
	if(/^(.|\n)+$/.test(title.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	if(/^(.|\n)+$/.test(content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
</script>

  <div class="container">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-3">공부게시판</h2>
        </div>
        <!-- 파일전송-->
        <form action="${pageContext.request.contextPath}/community/studyUpdate.do?${_csrf.parameterName}=${_csrf.token}"
  			enctype="multipart/form-data" 
        	method="post" 
        	onsubmit="return checkContent();">
          <div class="row title-group">
            <h5 class="col-sm-2 board-title">제목</h5>
            <div class="col-sm-10">
  	          <select name="selectBox">
		          <c:forEach items="${list}" var="list">
		         	<option value="${list.lectureNo}" id="refLectureNo" name="refLectureNo">${list.lectureName}</option>
		          </c:forEach>
	       	 </select>
              <input class="form-control" name="stdBrdTitle" id="stdBrdTitle" value="${stdBrd.stdBrdTitle}" type="text" value="원래제목">
            </div>
          <div class="board-container">
            <!-- 이미지가 들어가면 콘텐츠에서 보여줘야함. 어떻게 서버처리할지 생각해볼것. -->
            <div class="form-group content">
              <textarea class="form-control" name="stdBrdContent" id="stdBrdContent" rows="10">${stdBrd.stdBrdContent}</textarea>
              	<div class="custom-file">
	              	<c:if test="${not empty attach}">
	              		<img src="${pageContext.request.contextPath}${attachPath}" alt="" id="photo_img">
	              	</c:if>
	              	<c:if test="${empty attach}">
	              		<img src="" alt="" id="photo_img">	              	
	              	</c:if>
	              	
	                <input type="file" value="${attach.originalFilename}" class="custom-file-input" name="upFile" id="upFile" accept="image/jpeg, image/jpg, image/png">
              	</div>
            </div>
          </div>
          <div class="board-footer float-right">
            <input name="stdBrdNo" type="hidden" value="${stdBrd.stdBrdNo}">
            <button type="reset" class="btn btn-danger cancel-btn" onclick="location.href='${pageContext.request.contextPath}/community/studyList.do'">취소</button>
            <button type="submit" class="btn btn-primary complete-btn">완료</button>
          </div>
        </form>
      </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>