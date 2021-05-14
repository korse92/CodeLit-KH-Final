<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 신청리스트" name="title"/>
</jsp:include>
<div class="container">
<section class="container">
  <div class="page-header">
   <div class="row mt-5">
     <h2 class=" jb-larger m-3 col-sm-3">강의 신청 목록</h2>
   </div>
	<table class="table mt-3 col-sm text-center">
	<thead class="thead-light">
	    <tr>
	      <th scope="col">카테고리</th>
	      <th scope="col">강사 아이디</th>
	      <th scope="col">강의 링크</th>
	      <th scope="col">비고</th>
	    </tr>
	   <!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
	  <c:if test="${empty list}">
	    <tr>
			<td colspan="14" style="text-align:center;">조회된 데이터가 없습니다.</td>
		</tr>
	  </c:if>
	 </thead>
	  <tbody>
	  	<c:if test="${!empty list}">
	  	 <c:forEach items="list" var="lectureList">
	       <tr>
	          <td>${lectureList.lecCatName}</td>
	          <td>${lectureList.refMemberId}</td>
	          <td>${lectureList.lectureId}</td>
	          <td>
	             <button type="button" class="btn btn-secondary btn-sm">취소</button>
	             <button type="button" class="btn btn-warning btn-sm" onclick="location.href ='${pageContext.request.contextPath}/admin/approveLecture.do?id=${lectureList.refMemberId}'">승인</button>
	          </td>
	        </tr>
	  	 </c:forEach>
	  	</c:if> 
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
</div>    


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
