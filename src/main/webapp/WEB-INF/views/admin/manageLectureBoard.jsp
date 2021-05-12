<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script>
$(() => {
	$("#rejectTeacherRight")
	.modal()
	.on('hide.bs.modal', e => {
		//modal 비활성화(X,취소,모달외 영역 클릭시) 이전페이지로 이동한다. //bs의 이벤트핸들링
		location.href = '${empty header.referer || fn:contains(header.referer, '/member/login.do') ? pageContext.request.contextPath : header.referer}'; //referer가 없거나,로그인페이지를 경로로 들어간 경우 contextPath로 이동
	})
});



</script>

</head>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 관리 게시판" name="title"/>
</jsp:include>
<div class="container">
	<section class="container">
      <div class="page-header">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-3">강의 관리 게시판</h2>
        
        <div class="mt-4 col-sm-2">
          <select class="form-select">
            <option selected>카테고리</option>
            <option value="1">프론트엔드</option>
            <option value="2">백엔드</option>
            <option value="3">빅데이터</option>
          </select>
        </div>
        <div class="col-4 mt-4">
          <div class="input-group">  
            <div class="form-outline">
              <input type="search" id="form1" class="form-control"  placeholder="강의자 / 강의명"/>              
             </div>
            <button type="button" class="btn btn-primary">
              <i class="fas fa-search"></i>
            </button>
          </div>
         </div>
        </div>
      </div>
	<table class="table mt-3 col-sm text-center">
	<thead class="thead-light">
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">카테고리</th>
	      <th scope="col">강의자 아이디</th>
	      <th scope="col">강의자 명</th>
	      <th scope="col">강의 링크</th>
	      <th scope="col">비고</th>
	    </tr>
	 </thead>
	  <tbody>
	       <tr>
	          <td>0</td>
	          <td>백엔드</td>
	          <td>jisuco</td>
	          <td>김지수</td>
	         
	       	 <td><a href="${pageContext.request.contextPath}/admin/manageLectureBoard.do">강의 상세보기</a></td>
	       	<%--  <td><a href="${pageContext.request.contextPath}/admin/manageLectureBoard.do?detail="\${teacher.link}>강의관리 게시판</a></td> --%>
	       	      
	       	 
	          <td>
	             <button type="button" class="btn btn-warning btn-sm" href="${pageContext.request.contextPath}/admin/rejectTeacherRight.do">권한 해지</button>
	             <button type="button" class="btn btn-secondary btn-sm">취소</button>
	          </td>
	        </tr>
	</table>
	
		<!-- 페이지 바 -->
	     <ul class="pagination d-flex justify-content-center">
	       <li class="page-item"><a class="page-link" href="#"><</a></li>
	       <li class="page-item"><a class="page-link" href="#">1</a></li>
	       <li class="page-item active"><a class="page-link" href="#">2</a></li>
	       <li class="page-item"><a class="page-link" href="#">3</a></li>
	       <li class="page-item"><a class="page-link" href="#">4</a></li>
	       <li class="page-item"><a class="page-link" href="#">5</a></li>
	       <li class="page-item"><a class="page-link" href="#">></a></li>
	     </ul>
</div>
</section>

             


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
