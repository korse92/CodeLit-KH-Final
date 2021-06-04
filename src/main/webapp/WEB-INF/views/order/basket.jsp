<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장바구니" name="title"/>
</jsp:include>

<!-- import 링크 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/basket.css" />

<!-- Font Awesome(아이콘) CSS -->
<script src="https://kit.fontawesome.com/0e3c91e1c6.js" crossorigin="anonymous"></script>
<head>
</head>

	<script>
		window.onload = function() {
			IMP.init('imp94594446');	
			
			const orderBtn = document.getElementById("orderBtn");
			
			orderBtn.addEventListener('click', function(e) {

				// noneBasket 문구가 있는지 여부로 결제 가능 여부 확인
				if(document.getElementById("noneBasket")) {
					e.preventDefault;
					alert("결제할 내역이 없습니다.");
					
				} else {

					var money = document.getElementById("money").innerText;
					
			        var payCode = document.getElementById("payCode");
			        var refMemberId = document.getElementById("refMemberId");
			        var payCost = document.getElementById("payCost");
			        
			        // 무료강의만 담아서 결제비용 0원일 때 처리
					if(money == 0) {
						
						if(!confirm("0원 결제는 자동 수강됩니다. 진행하시겠습니까?")) {
							e.preventDefault;
						}
						
						const ms = new Date().getTime();
						const random1 = Math.floor(Math.random() * 10);
						const random2 = Math.floor(Math.random() * 10);
						
						
				        payCode.value = "" + ms + random1 + random2;
				        refMemberId.value = 
				        	"<sec:authentication property='principal.username'/>";
				        payCost.value = money;
				        
				        $("#orderFrm").submit();
						
				        
				    // 장바구니 있고, 결제금액 있을 때의 정상 결제처리
					} else {
						
						var orderName = document.getElementById("orderName").innerText;
						var memberId = document.getElementById("memberId").innerText;
						
						IMP.request_pay({
						    pg : 'inicis', // version 1.1.0부터 지원.
						    pay_method : 'card',
						    merchant_uid : 'merchant_' + new Date().getTime(),
						    name : orderName,
						    amount : money,
						    buyer_email : 'asrisk@naver.com',	// 회원아이디 메일 사용시 memberId 지정 가능
						    buyer_name : memberId
						}, function(rsp) {
							var msg = null;
						    if ( rsp.success ) {
						        console.log('결제가 완료되었습니다.');
						        msg = '결제에 성공했습니다.';
						        payCode.value = rsp.apply_num;
						        refMemberId.value = memberId;
						        payCost.value = money;
						        
						        $("#orderFrm").submit();
						        
		// 				        msg += '고유ID : ' + rsp.imp_uid;
		// 				        msg += '상점 거래ID : ' + rsp.merchant_uid;
		// 				        msg += '결제 금액 : ' + rsp.paid_amount;
		// 				        msg += '카드 승인번호 : ' + rsp.apply_num;
						    } else {
						        msg = '결제에 실패하였습니다.';
						        msg += '에러내용 : ' + rsp.error_msg;
						    }
						    alert(msg);
						});
						
						
					} // money==0  else
					
				} // document.getElementById("noneBasket")  else
				
			}); // 결제버튼 클릭
			
		} // window.onload
		
		
		// 삭제버튼 ajax
		function deleteDiv(n, basketNo) {

			// db 삭제 ajax	
			$.ajax({
				url : "${pageContext.request.contextPath}/order/deleteBasketAjax.do",
				data :  {
					basketNo : basketNo,
					${_csrf.parameterName} : "${_csrf.token}"
				},
				method : "POST",
				success : function(data) {
					console.log("삭제 ajax 성공. basketNo");
					console.log(data);
					
					// 화면에서 삭제
					let basketDiv = document.getElementById(`basketDiv\${n}`);
					basketDiv.remove();
					
					// 이름 및 금액 조정
					let orderName = document.getElementById("orderName");
					let money = document.getElementById("money");

					if(data.length == 0) {
						let orderTableTop = document.getElementById("orderTableTop");
						orderTableTop.innerHTML = "<p id='noneBasket' class='text-center ps-5'>장바구니에 담긴 강의가 없습니다.</p>";
						money.innerText = 0;

					} else if(data.length == 1) {
						orderName.innerText = data[0].lectureName;
						money.innerText = data[0].lecturePrice;
						
					} else {
						orderName.innerText = data[0].lectureName + " 외 " + (data.length - 1) + "종";
						
						let cash = 0;
						for(var i=0 in data) {
							cash += data[i].lecturePrice;
						}
						money.innerText = cash;
					}
	
				},
				error : function() {
					console.log("삭제 ajax 실패");					
				},
				complete : function() {
					console.log("삭제 ajax 완료");
				}
			});
		}
		
	</script>
	
	<form:form id="orderFrm" method="post"
		action="${pageContext.request.contextPath}/order/paymentHandling.do">
		<input type="hidden" id="payCode" name="payCode"/>
		<input type="hidden" id="refMemberId" name="refMemberId"/>
		<input type="hidden" id="payCost" name="payCost"/>
	</form:form>
	

<div class="container">
	<h2><spring:message code="menu.cart"/></h2>
   	<hr>
	<div class="row">
		<div id="orderDiv_left me-3" class="col-7">
			<c:forEach items="${basketList}" var="basket" varStatus="vs">
			<div class="card mb-4" id="basketDiv${vs.count}">
				<div class="row">
					<div class="col-md-4" id="imgDiv">
						<c:choose>
		                	<c:when test="${empty basket.lectureThumbRenamed}">
		               			<img src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image" alt="..." id="lectureImg">
		                	</c:when>
		                	<c:otherwise>
		                    	<img src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${basket.lectureThumbRenamed}" alt="" id="lectureImg" onclick="location.href='${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${basket.refLectureNo}'">
		                	</c:otherwise>
	                	</c:choose>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<div class="row justify-content-between">
								<div class="col">
									<h5 class="card-title">${basket.lectureName}</h5>
									<h6 class="card-subtitle">${basket.teacherName}</h6>
									<h6 class="card-subtitle py-2">${basket.lecturePrice} 원</h6>
								</div>
								<!-- <button type="button" class="btn bt text-light me-2">찜이동</button> -->
								<div class="col-auto">
<!-- 								<button type="button" class="btn bt text-light mb-2">찜이동</button> -->
									<button type="button" class="btn bt text-light" onclick="deleteDiv(${vs.count}, ${basket.basketNo});"><spring:message code="admin.deleteBtn"/></button> <!-- bt text-light me-2 -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>

		</div>

		<div class="col-5">
			<div id="orderDiv_right" class="card py-4 px-5 justify-content-between">
				<div id="orderTableTop" class="row fs-4">
					<c:choose>
						<c:when test="${not empty basketList}">
							<span class="col-3"><spring:message code="login.id"/></span><p id="memberId" class="col-9 text-start ps-3">${refMemberId}</p>
				            <span class="col-3"><spring:message code="order.lecture"/>: </span><p id="orderName" class="col-9 text-start ps-3">${basketList.get(0).lectureName} 외 ${basketList.size() - 1}종</p>
						</c:when>
						<c:otherwise>
							<p id="noneBasket" class="text-center ps-5"><spring:message code="ud.noCartLecture"/></p>
						</c:otherwise>
					</c:choose>
				</div>

<!-- 				<div id="orderTableBottom" class="row">  ${sumBasket} -->
	            	<hr>
	            	<div class="row">
			            <span id="money" class="offset-6 col-4 fs-4 me-2">${sumBasket}</span><span class="col-1 fs-4 me-2">원</span>
			            <button type="button" id="orderBtn" class="btn btn-primary text-light fs-5 mt-3"><spring:message code="admin.payment"/></button>
	            	</div>
	            </div>
			</div>
		</div>
	</div>
  		<div id="orderDiv1" class="my-5">

		<%-- <form action="#"> --%>



		<%-- </form> --%>

	</div>

   <%--  <div id="orderDiv1" class="my-5">
	    <form action="#" class="row">
        <div id="orderDiv_left">
    		<c:forEach items="${basketList}" var="basket" varStatus="vs">
	            <div class="card mb-3 or_lec">
	                <div class="row g-0">
	                    <div class="col-md-4" id="imgDiv">
	                    	<c:choose>
			                	<c:when test="${empty basket.lectureThumbRenamed}">
			               			<img src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image" alt="..." id="lectureImg">
			                	</c:when>
			                	<c:otherwise>
			                    	<img src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${basket.lectureThumbRenamed}" alt="" id="lectureImg">
			                	</c:otherwise>
		                	</c:choose>
	                    </div>
	                    <div class="col-md-8">
	                    	<div class="card-body">
	                        	<div class="row">
	                        		<div class="col-auto">
			                        	<h5 class="card-title row">${basket.lectureName}</h5>
			                        	<span style="width: 10rem; padding:0.5rem;">${basket.teacherName}</span>
	                        		</div>
			                       	<div class="col-auto"> <!-- d-flex align-content-center flex-wrap -->
			                        	<button type="button" class="btn bt text-light me-2">찜이동</button>
			                        	<form:form action="${pageContext.request.contextPath}/order/deleteBasket.do" method="POST">
				                		<input name="lectureNo" type="hidden" value="${basket.refLectureNo}" type="hidden"	/>
				                        <button type="submit" class="btn bt text-light me-2">
				                        삭제
				                        </button>
				                        </form:form>
			                       	</div>
	                        	</div>
	                    	</div>
	                    </div>
	                </div>
	            </div>
	    	</c:forEach>
        </div><!-- orderDiv_left -->

	        <div id="orderDiv_right" class="p-4 d-flex justify-content-center card align-self-center">
	            <div id="orderTableTop" class="row mt-3 fs-4">
		            <p class="text-start ps-3">id : ${refMemberId}</p>
		            <p class="text-start ps-3">강의 : ${basketList.get(0).lectureName} 외 ${basketList.size()}종</p>
	            </div>

	            <div id="orderTableBottom" class="row">
	            	<hr>
		            <p class="text-end fs-4 me-2">${sumBasket}</p>
		            <button type="button" class="btn btn-primary text-light fs-5 my-0">결 제</button>
	            </div>
	        </div>
	    </form>
	</div> --%> <!-- orderDiv1 -->
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>