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
		
		location.href = `${pageContext.request.contextPath}/community/studyDetail.do?stdBrdNo=\${no}`;
	});
});
</script>


   	<div class="container">
        <form method="GET" id="searchFrm"  
         action="${pageContext.request.contextPath}/community/studyList.do">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-3"><spring:message code="menu.community"/></h2>
          <div class="mt-4 col-sm-2">
            <select class="form-select" id="searchType" name="searchType">
              <option value="std_brd_title" ${param.searchType eq 't' ? 'selected' : ''}>제목</option>
              <option value="ref_member_id" ${param.searchType eq 'w' ? 'selected' : ''}>작성자</option>
            </select>
          </div>
          <div class="col-4 mt-4">
            <div class="input-group">  
              <div class="form-outline">
                <input type="search" id="searchKeyword" name="searchKeyword" class="form-control"  placeholder="Search"/>              
              </div>
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i>
              </button>
            </div>
          </div>
          <c:if test="${empty list}">
          	<h1 style="text-align: center; margin-top: 3rem;" ><spring:message code="admin.noData"/></h1>
          </c:if>
          <c:if test="${not empty list}">
        </div>
      </form>
        

        <div class="mt-5">

          <table class="table text-center table-hover">
            <thead class="table-primary">
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
	              <tr data-no="${list.stdBrdNo}">
	                <td scope="row">${list.rownum}</td>
	                <td>
	                [${list.lectureName}]
						<c:choose>
	                		<c:when test="${fn:length(list.stdBrdTitle) > 20}">
					                <c:out value="${fn:substring(list.stdBrdTitle,0,19)}" />...
	                		</c:when>
	                		<c:otherwise>
	                				<c:out value="${list.stdBrdTitle}" />
	                		</c:otherwise>
	                	</c:choose>
					</td>
	                <td>
	                	<fmt:formatDate value="${list.stdBrdDate}" pattern="yy/MM/dd HH:mm:ss" />
	                </td>
	              	<td>${list.stdBrdCount}</td>
	              	<td>${list.refMemberId}</td>
	              </tr>
          	    </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>
        ${pageBar}
      	<sec:authorize access="isAuthenticated()">
          <button class="btn btn-primary pull-right board-write" onclick="location.href='${pageContext.request.contextPath}/community/studyWrite.do'"><spring:message code="help.writeBtn"/></button>
      	</sec:authorize>
        </div>
      	<div>
      	</div>
       </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>