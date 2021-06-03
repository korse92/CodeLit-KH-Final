<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<!-- 컨텐츠 시작 -->
        <style>
            #conuselContent {
                border-top : 1px solid black;
            }
            #detailDiv {
                border-bottom : 1px solid black;
                min-height: 15rem;
            }
            
            #content {
            	min-height: 20rem;
            }
        </style>

		<script>
			window.onload = function() {
				
				const answer = document.getElementById("answerBtn");
				answer.addEventListener('click', function(e) {
					location.href="${pageContext.request.contextPath}/counsel/counselAnswer.do?counselNo=${counsel.counselNo}";
				});
				
			}
		</script>

<!-- 개인 CSS, JS 위치 -->

	<div class="col-8 mx-auto">

		<div class="row mt-5">
		 	<h2 class=" jb-larger mt-3 col-2">문의사항</h2>
		</div>
		<hr>
		<div class="col-10 mx-auto mt-5" id="detailDiv">
			<div class="row header ps-2">
		    	<h5 class="col-1 board-title fs-4">제목 : </h5>
		    	<p class="col-9 fs-4">${counsel.counselTitle}</p>
		    	<p class="col-2 fs-5"><fmt:formatDate value="${counsel.counselDate}" pattern="yy/MM/dd" /></p>
		  	</div>
		  	<div class="row mb-2 ps-2">
		  		<span class="col-1 fs-5">작성자 : </span><span class="col-11 fs-5">${counsel.refMemberId}</span>
		  	</div>
		    <div class="board-container mt-3 ps-2" id= "conuselContent">
		    	<c:if test="${not empty attach}">
		    		<img src="${pageContext.request.contextPath}${attach.contentsAttachPath}/${attach.renamedFilename}" alt="">
		    	</c:if>
		
		        <p class="content mt-4 ps-3 fs-5">
		            ${counsel.counselContent}
		        </p>          
		    </div>
		
		</div>
		
		<sec:authorize access="hasRole('ADMIN')">
		
			<div class="col-10 mx-auto mt-5">
              	<form:form id = "counselAnswerFrm"
	                action="${pageContext.request.contextPath}/counsel/counselAnswer.do"
	                method="post"
	                enctype="multipart/form-data">
	                <input type="hidden" name="counselQNo" value="${counsel.counselNo}" />
					<table class="mx-auto col-11 text-center">
						<tr class="col-10 py-3">
							<td>
								<label for="counselTitle">제목</label>
							</td>
							<td>
								<input type="text" name="counselTitle" class="form-control" placeholder="제목" value="Re: ${counsel.counselTitle}"/>
							</td>
						</tr>
						<tr class="col-10 py-3">
							<td>
								<label for="upFile">첨부파일 </label>
							</td>
							<td>
								<input type="file" name="upFile" class="form-control"/>
							</td>
						</tr>
						<tr class="col-10 py-3">
							<td>
								<label for="counselContent">내용</label>
							</td>
							<td>
								<textarea name="counselContent" id="content" class="form-control"></textarea>
							</td>
						</tr>
						<tr class="col-10 py-3">
						<td></td>
							<td> 
								<input type="submit" class="btn btn-warning mt-5 py-1 px-4 fs-4" value="등록" />
							</td>
						</tr>
					</table>
				</form:form>
		
			</div>
			
		</sec:authorize>

	</div>




<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>