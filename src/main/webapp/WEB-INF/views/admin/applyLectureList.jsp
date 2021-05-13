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
	      <th scope="col">번호</th>
	      <th scope="col">카테고리</th>
	      <th scope="col">아이디</th>
	      <th scope="col">신청자</th>
	      <th scope="col">GitHub</th>
	      <th scope="col">날짜</th>
	      <th scope="col">비고</th>
	    </tr>
	 </thead>
	  <tbody>
	       <tr>
	          <td>0</td>
	          <td>백엔드</td>
	          <td>jisuco</td>
	          <td>김지수</td>
	        <%--  <td><a href="${}">/github/jisu0011</a></td> --%>
	        <!-- <a href="https://github.com/"/> -->
	          <td>2021/05/05</td>
	          <td>
	             <button type="button" class="btn btn-secondary btn-sm">취소</button>
	             <button type="button" class="btn btn-warning btn-sm">승인</button>
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
</div>    


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
