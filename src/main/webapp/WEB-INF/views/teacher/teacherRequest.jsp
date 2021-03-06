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
	<jsp:param value="teacherRequest" name="title"/>
</jsp:include>

    <script>
        window.onload = function() {

            let upFile = document.getElementById('upFile');
            let thumb = document.getElementById('photo_img');
            upFile.addEventListener('change', function(e) {
              
              if(upFile.files[0] != null) {
                thumb.src = URL.createObjectURL(upFile.files[0]);
              } else {
                thumb.src = "";
              }

            });


        }

    </script>
    
    <style>
        #alarm {
            width: 25px; 
            height: 25px;
        }


        #registerDiv {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        #photo {
            width: 8rem;
            height: 8rem;
            border: 1px solid black;
            margin: auto;
            border-radius: 5px;
        }
        #photo_img {
          max-width: 8rem;
          max-height: 8rem;
        }

        #upFile {
          width: 14rem;
          margin: 1rem 0rem 1rem 3rem;
        }

        #teach {
            width: 50rem;
            height: 30rem;
            /* border-top: 1px solid black; */
        }

        .td {
            width: 10rem;
        }
        .td2 {
            width: 10rem;
        }
        .td3 {
          width: 22rem;
        }
        
        #teacherRequestDiv {
        	min-height: 60rem;
        	align-items: center;
        }
        
        #formDiv {
        	border : 1px solid gray;
        	width: 52rem;
        	min-height : 50rem;
        	padding-top: 3rem;
        }
    </style>
    
<!-- 컨텐츠 시작 -->
	
	   <div id="registerDiv">
		<section class="container">

		<div class="container" id="teacherRequestDiv">
	        <h2 class="mt-5"><spring:message code="Tmenu.enrollTeacher" /></h2>
	        <hr/>
	            <div id="formDiv" class="mx-auto">
	            
		            <form:form action="${pageContext.request.contextPath}/teacher/teacherRequest.do" 
		            		method="POST" id="teachRegisterFrm"
		            		enctype="multipart/form-data" >
		        		<input type="hidden" value="${loginMember.memberId}" name="refMemberId" readonly/>
		                <table id="teach" class="text-center row">
		                    <tr>
		                        <td rowspan="2" colspan="2" class="td">
		                            <div id="photo">
		                              <img src="" alt="" id="photo_img">
		                            </div>
		                        </td>
		                        
		                        <td colspan="1" class="td2">
		                            <label for="teacherName"><spring:message code="teacher.name" /></label>
		                        </td>
		                        <td colspan="3" class="td3">
		                            <input type="text" class="form-control" placeholder="이름을 입력해주세요." name="teacherName" id="teacherName" />
		                        </td>
		                    </tr>
		        
		                    <tr>
		                        <td colspan="1" class="td2">
		                            <label for="teacherPhone"><spring:message code="teacher.phone" /></label>
		                        </td>
		                        <td colspan="3" class="td3">
		                            <input type="text" class="form-control" placeholder="전화번호 (- 없이)" name="teacherPhone" id="teacherPhone">
		                        </td>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                          <input type="file" name="upFile" id="upFile" accept="image/jpeg, image/jpg, image/png">
		                        </td>
		                        <td colspan="1" class="td2">
		                            <label for="teacherLink"><spring:message code="teacher.git" /></label>
		                        </td>
		                        <td colspan="3" class="td3">
		                            <input type="text" class="form-control" placeholder="깃허브 또는 블로그 주소" name="teacherLink" id="teacherLink">
		                        </td>
		                    </tr>
		                    <tr>
		                        <td colspan="1">
		                            <label for="refLecCatNo"><spring:message code="teacher.lecPart" /></label>
		                        </td>
		                        <td colspan="5">
		                            <select class="form-select" aria-label="희망분야" name="refLecCatNo" id="refLecCatNo">
		                              <option selected>카테고리 선택</option>
		                              <c:forEach items="${catList}" var="list">
		                              	<option value="${list.no}">${list.name}</option>
		                              </c:forEach>
		                            </select>
		                        </td>
		                    </tr>
		
		                    <tr>
		                      <td colspan="1" class="td">
		                        <label for="teacherBank"><spring:message code="teacher.bank" /></label>
		                      </td>
		                      <td colspan="5">
		                        <input type="text" class="form-control" placeholder="은행명" name="teacherBank" id="teacherBank">
		                      </td>
		                    </tr>
		                    <tr>
		                        <td colspan="1" class="td">
		                            <label for="teacherAccount"><spring:message code="teacher.account" /></label>
		                        </td>
		                        <td colspan="5">
		                            <input type="text" class="form-control" placeholder="계좌번호 (- 없이)" name="teacherAccount" id="teacherAccount">
		                        </td>
		                    </tr>
		                    <tr>
		                        <td colspan="1" class="td">
		                            <label for="teacherAccName"><spring:message code="teacher.bankName" /></label>
		                        </td>
		                        <td colspan="5">
		                            <input type="text" class="form-control" placeholder="예금주" name="teacherAccName" id="teacherAccName">
		                        </td>
		                    </tr>
		                    <tr>
		                        <td colspan="1" class="td">
		                            <label for="teacherIntroduce"><spring:message code="teacher.intro" /></label>
		                        </td>
		                        <td colspan="5">
		                            <textarea name="teacherIntroduce" id="teacherIntroduce" class="form-control" cols="30" rows="10"></textarea>
		                        </td>
		                    </tr>
		        
		                    <tr>
		                        <td colspan="2">
		                            
		                        </td>
		        
		                        <td colspan="2">
		                          <button type="reset" class="btn btn-warning col-5 mt-3 mb-5"><spring:message code="admin.backBtn" /></button>
		                          <button type="submit" class="btn btn-primary col-5 mt-3 mb-5"><spring:message code="admin.applyBtn" /></button>
		                        </td>
		                        <td colspan="2">
		                            
		                        </td>
		                    </tr>
		        
		                </table>
		            </form:form>
	            
	            </div> <!-- 실제 등록폼만 감싸는 디브 -->
	        </div>
		</section>
		</div>


<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>