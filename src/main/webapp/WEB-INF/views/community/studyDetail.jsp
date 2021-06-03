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
	<sec:authentication property="principal.username" var="name" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">
	<div class="container">
       <div class="row mt-5">
         <h2 class=" jb-larger mt-3 col-2"><spring:message code="menu.community"/></h2>
       </div>
       <div class="row mt-3 header">
         <h5 class="col-1 board-title"><spring:message code="user.boardTitle"/></h5>
         <p class="col-7">[${stdBrd.lectureName}] ${stdBrd.stdBrdTitle}</p>
         <p class="col-1"><i class="fas fa-user"></i> ${stdBrd.refMemberId}</p>
         <p class="col-2"><i class="fas fa-clock"></i> <fmt:formatDate value="${stdBrd.stdBrdDate}" pattern="yy/MM/dd HH:mm:ss" /></p>
         <p class="col-1"><i class="fas fa-eye"></i> ${stdBrd.stdBrdCount}</p>
       </div>
       <div class="board-container">
         <h5 class="content-title"><spring:message code="user.boardContent"/></h5>
			<c:if test="${not empty attach}">
	            <img src='${pageContext.request.contextPath}${attachPath}' />
          	</c:if>
           <p class="content">
           	${stdBrd.stdBrdContent}
           </p>          
       </div>
         <div class="board-footer">
         <c:if test="${stdBrd.refMemberId == name}">
           <button type="button" class="btn btn-primary update-btn" onclick="location.href='${pageContext.request.contextPath}/community/studyUpdate.do?stdBrdNo=${stdBrd.stdBrdNo}'"><spring:message code="admin.editBtn"/></button>
           <button type="button" class="btn btn-danger delete-btn" onclick='del();'><spring:message code="admin.deleteBtn"/></button>
         </c:if>
           <button type="button" class="btn btn-primary list-btn" onclick="location.href='${pageContext.request.contextPath}/community/studyList.do'"><spring:message code="admin.backBtn"/></button>
         </div>
           <br>
           <br>
           <br>
           
           <div class="comment-title">댓글</div>
			<c:forEach items="${listCmt}" var="listCmt">
           		<div class="row comment-body${listCmt.stdCmtNo} cmtShow">
						<div class="col-2 comment-writer">
							<i class="fas fa-user"></i> ${listCmt.refMemberId}  :
	           	 	 	</div>
		           	<div class="col-7 cmtShow" id="comment-content">
							${listCmt.stdCmtContent}
		           	</div>
		           	<div class="col-3">
						<i class="fas fa-clock"></i> <fmt:formatDate value="${listCmt.stdCmtDate}" pattern="yy/MM/dd HH:mm:ss" />
                  
		           <c:if test="${listCmt.refMemberId == name}">
		           		<span>
				           		<button type="button" class="btn btn-primary btn-sm cmtShow" id="comment-update-btn" onclick="updateCmt(${listCmt.stdCmtNo})">수정</button>
		               			<button type="button" class="btn btn-danger btn-sm cmtShow" id="comment-delete-btn" onclick='location.href="${pageContext.request.contextPath}/community/deleteCmt.do?stdCmtNo=${listCmt.stdCmtNo}"'>삭제</button>
		           		</span>
		           </c:if>
	           	</div>
	           	</div>

	           	<form action="${pageContext.request.contextPath}/community/updateComment.do?stdCmtNo=${listCmt.stdCmtNo}&&${_csrf.parameterName}=${_csrf.token}" method="post">
                  <div class="comment-form-group mt-5 updateCmtForm${listCmt.stdCmtNo}" id="" style="display:none;">
			     		<textarea class="form-control rounded-0${listCmt.stdCmtNo}" rows="2" id="updateCmt" name="stdCmtContent" placeholder="댓글입력">${listCmt.stdCmtContent}</textarea>
			    	 	<button id="cmtUpdate" class="btn btn-primary btn-sm comment-submit-btn">전송</button>
			    	 	<input type="reset" id="cmtUpdateCanel" class="btn btn-danger btn-sm comment-submit-btn" onclick="newUpdateCmt(${listCmt.stdCmtNo})" value="취소">
						<input type="hidden" id="refStdBrdNo" name="refStdBrdNo" value="${stdBrd.stdBrdNo}">
					</div>
	           	</form>
			
			</c:forEach>
        	<form action="${pageContext.request.contextPath}/community/insertComment.do?${_csrf.parameterName}=${_csrf.token}" method="post"
        	id="commentForm" name="commentForm" onsubmit="return commentSubmit();">
             <div class="updateCmtForm mt-5">
             	<table class="table">
             		<tr>
           				<td>
	                 		<textarea class="form-control rounded-0" rows="2" id="stdCmtContent" name="stdCmtContent" placeholder="댓글입력"></textarea>
            			</td>
             		</tr>
           			<tr>
            			<td>
                 	 		<button type="submit"  class="btn btn-primary comment-submit-btn">전송</button>
            			</td>
           			<tr>
             	</table>
             <input type="hidden" id="refStdBrdNo" name="refStdBrdNo" value="${stdBrd.stdBrdNo}">
             </div>
        </form>
     </div>
</div>

  <script>
	function del(){
		if(confirm("삭제 하시겠습니까?")){
			location.href=`${pageContext.request.contextPath}/community/studyDelete.do?stdBrdNo=${stdBrd.stdBrdNo}`;
		} else{
			return false;
		}
	};
	function commentSubmit() {
		const input = $("[name=stdCmtContent]");
		if(/^(.|\n)+$/.test(input.val()) == false){
			alert("내용을 입력하세요");
			return false;
		}
		return true;
	}
	
	function updateCmt(no){
		$('.comment-body'+no).hide();
		$('.updateCmtForm'+no).show();
	}
	function newUpdateCmt(no){
		$('.comment-body'+no).show();
		$('.updateCmtForm'+no).hide();
	}
  </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>