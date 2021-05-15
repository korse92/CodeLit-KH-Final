<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>



      <style>
          #manageIndexDiv {
              min-height: 40rem;
          }
          #manageIndexDiv > button {
              width: 10rem;
              height: 12rem;
          }
          #manageIndexH2 {
          	width: 50rem;
          	margin: auto;
          	margin-top: 5rem;
          	padding-bottom: 2rem;
          	border-bottom: 1px solid gray;
          	text-align: center;
          }
      </style>
      
      <script>
      
      	window.onload = function() {
      		
	      	const member = document.getElementById("manageMember");
	      	const teacher = document.getElementById("manageTeacher");
	      	const order = document.getElementById("manageOrder");
	      	
	      	member.addEventListener('click', function() {
	      		location.href="${pageContext.request.contextPath}/admin/manageMember.do";
	      	});
	      	teacher.addEventListener('click', function() {
	      		location.href="${pageContext.request.contextPath}/admin/manageTeacher.do";
	      	});
	      	order.addEventListener('click', function() {
	      		location.href="${pageContext.request.contextPath}/admin/manageOrder.do";
	      	});
      		
      	}
      
      	
      	
      </script>
      
<!-- 컨텐츠 시작 -->

		<div class="container">
		
	        <h2 id="manageIndexH2">회원 관리</h2>
	
	        <div id="manageIndexDiv" class="col-6 mx-auto text-center my-5 row">
	            
	            <button type="button" id="manageMember" class="btn btn-outline-primary col-3 mx-auto mt-5 fs-4">회원 관리</button>
	            <button type="button" id="manageTeacher" class="btn btn-outline-secondary col-3 mt-5 fs-4">강사 관리</button>
	            <button type="button" id="manageOrder" class="btn btn-outline-success col-3 mx-auto mt-5 fs-4">결제 내역</button>
	
	        </div>
        
		</div>


<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>