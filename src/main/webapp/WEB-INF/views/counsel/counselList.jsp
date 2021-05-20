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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">
	<script type="text/javascript">
	
	</script>
	
	<sec:authorize access="isAuthenticated()">
	  <div class="container List-container" >
	        <div class="row mt-3">
	          <h2 class=" jb-larger mt-1 col-3">1:1문의 </h2>
	        </div>
	        	<form action="">
		        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        ...
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				        <button type="button" class="btn btn-primary">Save changes</button>
				      </div>
				    </div>
				  </div>
			</div>
			</form>
	        <div class="mt-3">
	          <c:if test="${empty list}">
	          	<h1 style="text-align: center">등록된 문의가 없습니다..</h1>
	          </c:if>
	          <c:if test="${not empty list}">
	          <table class="table text-center ">
	            <thead class="primary table-primary">
	              <tr>
	                <th scope="col">번호</th>
	                <th scope="col">제목</th>
	                <th scope="col">작성자</th>
	                <th scope="col">등록일</th>
	              </tr>
	            </thead>
	            
	            <c:forEach items="${list}" var="counsel" varStatus="status">
	         <!--    <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal"> 	 -->
	          	 <tr>
					<td>${counsel.counselNo }</td>
	                <td>
	                	<c:choose>
		               		<c:when test="${fn:length(counsel.counselTitle) > 20}">
				                <c:out value="${fn:substring(counsel.counselTitle,0,19)}" />...
	               		</c:when>
	               		<c:otherwise>
	               	  <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal"> <c:out value="${counsel.counselTitle}" />	 </a>
	               		</c:otherwise>
	                	</c:choose>
	                </td>
	                <td>${counsel.refMemberId}</td>
	                <td><fmt:formatDate value="${counsel.counselDate}" pattern="yy/MM/dd"/></td>
           
             	 </tr>
	            </c:forEach>
             
	          
	          </table>	
	          	          
		       ${pageBar}
	          </c:if>
		        	<button class="btn btn-primary boardList-footer" onclick="location.href='${pageContext.request.contextPath}/counsel/counselWrite.do'">글쓰기</button>		       
	        
	      </div>
	   </div>
	</sec:authorize>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>