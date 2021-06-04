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

</script>

	<sec:authorize access="hasRole('ADMIN')">
	
		<div class="container List-container" >
	        <div class="row mt-5">
	          	<h2 class=" jb-larger mt-1 col-3"><spring:message code="counsel.inqury"/></h2>
	        </div>
	        
	        <div class="my-5">
	        
	          	<c:if test="${empty list}">
	          		<h1 style="text-align: center"><spring:message code="counsel.noData"/></h1>
	          	</c:if>
	          	
	          	<c:if test="${not empty list}">
	          	
	          		<table class="table text-center table-hover">
	            		<thead class="primary table-primary">
	              			<tr>
	                			<th scope="col"><spring:message code="user.boardNo"/></th>
	                			<th scope="col"><spring:message code="user.boardTitle"/></th>
	                			<th scope="col"><spring:message code="user.boardWriter"/></th>
	                			<th scope="col"><spring:message code="user.boardDate"/></th>
	              			</tr>
			            </thead>
			            
	             		<tbody>
				            <c:forEach items="${list}" var="list" varStatus="status">
				        		<tr data-no="${list.counselNo}">
									<td>${list.counselNo }</td>
				                	<td>
				                		<a class="detailLink" href="${pageContext.request.contextPath}/counsel/counselDetail.do?counselNo=${list.counselNo}">
					                		<c:choose>
					                			<c:when test="${fn:length(list.counselTitle) > 20}">
									            	<c:out value="${fn:substring(list.counselTitle,0,19)}" />...
					                			</c:when>
					                			<c:otherwise>
					                				<c:out value="${list.counselTitle}" />
					                			</c:otherwise>
					                		</c:choose>
				                		</a>
				                	<td>${list.refMemberId}</td>
				                	<td><fmt:formatDate value="${list.counselDate}" pattern="yy/MM/dd"/></td>
				         		</tr>
				         	</c:forEach>
				         </tbody> 
	          		</table>
	          				          
		       		${pageBar}
		       		
	          	</c:if>
	          	
			</div>
		</div>
	</sec:authorize>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>