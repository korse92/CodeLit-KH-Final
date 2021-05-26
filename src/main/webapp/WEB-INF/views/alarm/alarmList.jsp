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

<script type="text/javascript">
$(() => {
	$("tr[data-no]").click(e => {
		var $tr = $(e.target).parent();
		var no = $tr.data("no");
		location.href = `${pageContext.request.contextPath}/alarm/alarmDetail.do?msgNo=\${no}`;
	});
});
</script>

<div class="container">
  <div class="row mt-5">
   <h2 class=" jb-larger mt-3 col-4">알림 목록</h2>
  </div>
  <sec:authorize access="hasRole('ADMIN')">
	<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/alarm/alarmWrite.do'">알림작성</button>
  </sec:authorize>
      <div class="mt-5 text-center">
        <table class="table text-center table-hover">
          <c:if test="${empty message}">
          	<h1>등록된 알람이 존재하지 않습니다.</h1>
          </c:if>
          <c:if test="${not empty message}">          
          <thead class="table-primary">
            <tr>
              <th scope="col">번호</th>
              <th scope="col">제목</th>
              <th scope="col">날짜</th>
              <th scope="col">보낸사람</th>
              <th scope="col">수신여부</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${message}" var="message">
	            <tr data-no="${message.msgNo}">
	              <td>${message.rownum}</td>
	              <td>${message.msgTitle}</td>
	              <td><fmt:formatDate value="${message.msgDate}" pattern="yy/MM/dd HH:mm:ss"/></td>
	              <td>${message.refWriterId}</td>
	              <td>${message.readYN eq 'N' ? '읽지않음' : '읽음'}</td>
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