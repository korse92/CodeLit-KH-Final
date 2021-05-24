<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--form:form 태그용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 신청리스트" name="title"/>
</jsp:include>

<script>

function deleteLecture(no) {
	if(confirm(`강의 신청을 거절하시겠습니까?`)){
		
	  var $frm = $(document.deleteLectureFrm);
	  $frm.find("[name=no]").val(no);
	  $frm.submit();
	}

}

</script>
<!-- 컨텐츠 시작 -->
<div class="container">
<section class="container">
  <div class="page-header">
   <div class="row mt-5">
     <h2 class=" jb-larger m-3 col-sm-3">강의 신청 목록</h2>
   </div>
	<table class="table mt-3 col-sm text-center">
	<thead class="thead-light">
	    <tr>
	     <td class="" style="display:none">강의 번호</td>
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
	  	 <c:forEach items="${list}" var="lectureList">
	       <tr>
	          <td style="display:none">${lectureList.lectureNo}</td>
	          <td>${lectureList.lecCatName}</td>
	          <td>${lectureList.refMemberId}</td>
	          <td><a href="${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${lectureList.lectureNo}">강의 상세보기</a></td>
	          <td>
	             <button type="button" class="btn btn-warning btn-sm" onclick="location.href ='${pageContext.request.contextPath}/admin/approveLecture.do?no=${lectureList.lectureNo}';">승인</button>
	             <button type="button" class="btn btn-secondary btn-sm" onclick="deleteLecture('${lectureList.lectureNo}');">거절</button>
	          </td>
	        </tr>
	  	 </c:forEach>
	  	</c:if> 
	</table>
	  <form:form name="deleteLectureFrm" 
	  		action="${pageContext.request.contextPath}/admin/deleteLecture.do"
	  		method="POST"	>
	  	<input type="hidden" name="no">
	  </form:form>	    	
	 <!-- 페이지 바 -->
	  <!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
	 	<c:if test="${!empty list}">
		 <div>
		  ${pageBar}
		 </div>
		</c:if> 
</div>
</section>
</div>    


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
