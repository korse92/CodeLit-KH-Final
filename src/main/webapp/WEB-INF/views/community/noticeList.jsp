<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">
<script type="text/javascript">
$(() => {
	$("tr[data-no]").click(e => {
		var $tr = $(e.target).parent();
		var no = $tr.data("no");
		
		location.href = `${pageContext.request.contextPath}/community/noticeDetail.do?noticeNo=\${no}`;
	});
});
</script>

<sec:authorize access="isAuthenticated()">
  <div class="container List-container" >
        <div class="row mt-3">
          <h2 class=" jb-larger mt-1 col-3"><spring:message code="menu.notice"/></h2>
        </div>
        
        <div class="mt-3">
          <c:if test="${empty list}">
          	<h1 style="text-align: center"><spring:message code="admin.noData"/></h1>
          </c:if>
          <c:if test="${not empty list}">
          <table class="table text-center table-hover">
            <thead class="primary table-primary">
              <tr>
              <th scope="col"><spring:message code="admin.boardNo"/></th>
              <th scope="col"><spring:message code="user.boardTitle"/></th>
              <th scope="col"><spring:message code="user.boardDate"/></th>
              <th scope="col"><spring:message code="user.boardCount"/></th>
              <th scope="col"><spring:message code="admin.id"/></th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="list" varStatus="status">
              <tr data-no="${list.noticeNo}">
                <td scope="row">${list.rownum}</td>
                <td>
                	<c:choose>
                		<c:when test="${fn:length(list.noticeTitle) > 40}">
				                <c:out value="${fn:substring(list.noticeTitle,0,39)}" />...
                		</c:when>
                		<c:otherwise>
                				<c:out value="${list.noticeTitle}" />
                		</c:otherwise>
                	</c:choose>
                </td>	
                <td><fmt:formatDate value="${list.noticeDate}" pattern="yy/MM/dd HH:mm:ss"/></td>
              	<td>${list.noticeCount}</td>
              	<td>${list.refMemberId}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>		          
	       ${pageBar}
          </c:if>
	      <sec:authorize access="hasRole('ADMIN')">
	        	<button class="btn btn-primary boardList-footer" onclick="location.href='${pageContext.request.contextPath}/community/noticeWrite.do'"><spring:message code="help.writeBtn"/></button>		       
         </sec:authorize>
      </div>
   </div>
</sec:authorize>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>