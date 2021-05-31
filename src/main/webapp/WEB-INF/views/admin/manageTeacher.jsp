<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->

        <style>
			#alarm {
			  width: 25px; 
			  height: 25px;
			}
			.jb-larger { 
			  font-weight: 900;
			}
			.Page{
			  display: inline-block;
			}
			.pagination-span{
			  position: absolute;
			  left: 44%;
			}
			.pagination{
			  width: 100%;
			  height: 100%;
			  margin: 0 auto;
			}
			.board-write{
			  float: right;
			}
        
        
        
          #memberBoardTable button {
            height: 2rem;
            padding: auto;
          }
          #memberBoardTable td {
            padding:  auto;
          }
          

        </style>

		<script>
			window.onload = function() {
				let $del = $('.deleteTeacherFrm');
				
				$del.each(function(i, elem) {
					
					elem.addEventListener('submit', function(e) {
						
						if(confirm("정말로 삭제하시겠습니까?")) {
						    
							//지헌 - 알림관련 추가 스크립트
						    const $id = $("[name=memberId]").val();
						    sendMessage("/app/reject/"+$id);
							
						    return true;
						} else {
							e.preventDefault();
						}
						
					});
					
				});
				
				
				
				
			}
		</script>


        <div class="container">

          <div class="mt-5">
            <h2 class=" jb-larger mt-3">강사 관리</h2>
            
	        <form method="GET" id="teacherSearchFrm" action="${pageContext.request.contextPath}/admin/manageTeacher.do">
            	<div class="row col-8 mt-5 ms-1">
		            
		            <table>
		            	<tr>
		            		<td class="col-2">
		            			<select class="form-select" name="category">
					                <option selected>주 강의분야</option>
					                <c:forEach items="${categoryList}" var="cat">
					                	<option value="${cat.no}">${cat.name}</option>
					                </c:forEach>
					        	</select>
		            		</td>
		            		<td class="col-3">
		            			<input type="search" id="form1" name="keyword" class="form-control offset-1"  placeholder="아이디"/>              
		            		</td>
		            		<td>
			               		<button type="submit" class="btn btn-primary offset-4" id="searchBtn">
			                  		<i class="fas fa-search"></i>
			               		</button>
		            		</td>
		            		<td>
		            			<span>둘 중 하나만 설정 후 검색도 가능</span>
		            		</td>
		            	</tr>
        
		            </table>
		            
            	</div>
            </form>
          </div>
          
          <div class="mt-4">
            <table class="table text-center" id="teacherBoardTable">
              <thead class="table-primary">
                <tr>
                  <th scope="col">번호</th>
                  <th scope="col">주 강의분야</th>
                  <th scope="col">아이디</th>
                  <th scope="col">개설강의</th>
                  <th scope="col">권한</th>
                </tr>
              </thead>
              <tbody>
              	<c:forEach items="${teacherList}" var="teacher" varStatus="vs">
                <tr>
                    <td>${vs.count}</td>
                    <td>
						<c:forEach items="${categoryList}" var="cat">
							<c:if test="${teacher.refLecCatNo eq cat.no}">
								${cat.name}
							</c:if>
						</c:forEach>
                    </td>
                    <td>${teacher.refMemberId}</td>
                    <td>
                    	<a href="#">
                    		개설강의 표시
                    	</a>
                    </td>
                    <td>
                    	<form:form method="POST" class="deleteTeacherFrm"
                    				action="${pageContext.request.contextPath}/admin/deleteTeacherAndAuth.do">
	                    	<input type="hidden" name = "refMemberId" value="${teacher.refMemberId}" />		
	                        <button type="submit" class="btn btn-danger text-light">권한삭제</button>
                    	</form:form>
                    </td>
                </tr>
                <!-- 지헌 알림 관련 태그 추가 -->
                   	<input type="hidden" name="memberId" value="${teacher.refMemberId}" />
              	<!-- 지헌 알림 관련 태그 종료 -->
                </c:forEach>
              </tbody>
            </table>
          </div>
				${pageBar}
            </div>

        </div> <!-- 컨테이너-->

			<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
			<hr/>



<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>