<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userPage(notice,lectureList).css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<div class="container">
  <div class="row mt-5">
   <h2 class=" jb-larger mt-3 col-4">알림 목록</h2>
  </div>
  <sec:authorize access="hasRole('ADMIN')">
	<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/alarm/alarmWrite.do'">알림작성</button>
  </sec:authorize>
      <div class="mt-5 text-center">
        <table class="table text-center">
          <thead class="table-primary">
            <tr>
              <th scope="col">번호</th>
              <th scope="col">알림 내용</th>
              <th scope="col">날짜</th>
              <th scope="col">받는 사람</th>
            </tr>
          </thead>
          <tbody style="">
          <c:if test="${empty list}">
          	<h1>등록된 알람이 존재하지 않습니다.</h1>
          </c:if>
          <c:if test="${not empty list}">          
          ${list}
            <c:forEach items="${list}" var="list">
	            <tr>
	              <td>${messenger.rownum}</td>
	              <td>${messenger.title}</td>
	              <td></td>
	              <td>User/Teacher/All</td>
	            </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      <div class="notice-paging mt-5">
		${pageBar}
      </div>
          </c:if>
  </div>

  
  
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>