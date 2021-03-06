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
	<jsp:param value="memberOrderTable" name="title"/>
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
        
        
          #memberOrderTable button {
            height: 2rem;
            padding: auto;
          }
          #memberOrderTable td {
            padding:  auto;
          }

        </style>

	

        <div class="container">
      
       
           <h2 class=" jb-larger mt-3 col-sm-8"><spring:message code="admin.paymentList"/></h2>
           <div class="mt-4">
           
            <table class="table text-center" id="memberOrderTable">
              <thead class="table-primary">
                <tr>
                  <th scope="col"><spring:message code="admin.orderNo"/></th>
                  <th scope="col"><spring:message code="admin.id"/></th>
                  <th scope="col"><spring:message code="admin.orderTotalPrice"/></th>
                  <th scope="col"><spring:message code="admin.orderLecCount"/></th>
                  <th scope="col"><spring:message code="admin.paymentDate"/></th>
                </tr>
        <!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
	  
     </thead>
	 	<tbody>
		
	  	 	<c:forEach items="${manageOrderList}" var="payment"   varStatus="vs">
	       	<tr>
	      	<td>${payment.payCode}</td>
	        <td>${payment.refMemberId}</td>
	        <td>${payment.payCost}</td>
	        <td>${payment.count}</td>
	        <td>${payment.payDate}</td>
	       	</tr>
	  	 	</c:forEach>
			</tbody>
		</table>
	 <div>
		  ${pageBar}  
	 </div>
	
		  </div>
		
	</div>   


<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>