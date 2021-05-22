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

	<div class="container">
    	<div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-3">정산 내역</h2>
        </div>
     <div class="mt-5">
      <table class="table text-center ">
        <thead class="primary table-primary">
          <tr>
            <th scope="col">날짜</th>
            <th scope="col">강의 제목</th>
            <th scope="col">정산 내역</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach>
          <tr>
            <td scope="row"></td>
            <td>rkd</td>
            <td>0</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>