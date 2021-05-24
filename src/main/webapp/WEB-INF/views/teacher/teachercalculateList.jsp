<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lecturerPage.css">
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
</script>

	<div class="container">
    	<div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-3">정산 내역</h2>
        </div>
        <!-- 파일전송-->
        <form action="">
          <div class="row title-group">
            <h5 class="col-sm-2 board-title">제목</h5>
            <div class="col-sm-10">
              <input class="form-control " type="text" placeholder="title">
            </div>
          </div>
          <div class="board-container">
            <!-- 이미지가 들어가면 콘텐츠에서 보여줘야함. 어떻게 서버처리할지 생각해볼것. -->
            <div class="form-group content">
              <textarea class="form-control" name="" id=""rows="10" placeholder="content"></textarea>
              <img src="" alt="" id="photo_img">
                <input type="file" name="upFile" id="upFile" accept="image/jpeg, image/jpg, image/png">
            </div>
          </div>
          <div class="board-footer">
            <!-- 관리자-->
            <button type="button" class="btn btn-danger cancel-btn" onclick="location.href='./studentBoardList.html'">취소</button>
            <button type="submit" class="btn btn-primary complete-btn">완료</button>
          </div>
        </form>
      </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>