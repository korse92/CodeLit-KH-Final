<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${param.title}</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<!-- Bootstrap JS : JQuery load 이후에 작성할것.-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">

<!-- Font Awesome(아이콘) CSS -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
	integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk"
	crossorigin="anonymous">

<!-- websocket 관련 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.js" integrity="sha512-Kdp1G1My+u1wTb7ctOrJxdEhEPnrVxBjAg8PXSvzBpmVMfiT+x/8MNua6TH771Ueyr/iAOIMclPHvJYHDpAlfQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js" integrity="sha512-tL4PIUsPy+Rks1go4kQG8M8/ItpRMvKnbBjQm4d2DQnFwgcBYRRN00QdyQnWSCwNMsoY/MfJY8nHp2CzlNdtZA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<!-- 사용자작성 JS -->
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/alarm.js"></script>

<!-- 사용자작성 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />

<!-- redirectAttr.addFlashAttribute의 저장된 속성값 사용(1회용) -->
<c:if test="${not empty msg}">
<script>
alert("${msg}");
</script>
</c:if>

<script>
//#localChange 변경시에 lang 파라미터 추가시에 요청주소가 현재페이지가 되어야 함
//자바스크립트를 이용해서 현재 페이지주소를 가져와 처리
//현재 브라우져 주소창에 적힌 주소는 location객체가 가지고 있음

function changeLocale(lang) {

	var url;

	if(location.href.indexOf("lang=") > -1) {
		url = location.href.substring(0, location.href.indexOf("lang=") - 1);
	} else {
		url = location.href;
	}

	if(url.indexOf("?") > -1)
		url += "&";
	else
		url += "?";

	location.href = url + "lang=" + lang;

}
</script>


</head>
<body>
	<header class="sticky-top">

		<nav class="navbar navbar-expand-lg navbar-dark">
			<div class="container">
				<a class="navbar-brand me-4" href="${pageContext.request.contextPath}">CodeL!t</a>

				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarMain"
					aria-controls="navbarMain" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse col-sm-2" id="navbarMain">
					<ul class="navbar-nav">
						<li class="nav-item dropdown mx-2">
							<a 	class="nav-link dropdown-toggle" href="#"
								id="navlinkDropdownCommunity" role="button"
								data-bs-toggle="dropdown" aria-expanded="false"><spring:message code="menu.communities"/></a>
							<ul class="dropdown-menu" id="dropdownCommunity"
								aria-labelledby="navlinkDropdownCommunity">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/community/noticeList.do"><spring:message code="menu.notice"/></a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/community/studyList.do"><spring:message code="menu.community"/></a></li>
							</ul>
						</li>
						<li class="nav-item dropdown mx-2">
							<a
								class="nav-link dropdown-toggle" href="#"
								id="navlinkDropdownLecture" role="button"
								data-bs-toggle="dropdown" aria-expanded="false"><spring:message code="menu.lecture"/></a>
							<ul class="dropdown-menu" id="dropdownLecture"
								aria-labelledby="navlinkDropdownLecture">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/lectureList.do"><spring:message code="menu.allLecture"/></a></li>
								<c:forEach items="${categoryList}" var="category">
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/lectureList.do/${category.no}"><spring:message code="${category.localeKey}"/></a></li>
								</c:forEach>
							</ul>
						</li>
						<sec:authorize access="hasRole('USER') && !hasRole('ADMIN')">
						<li class="nav-item mx-2"><a class="nav-link" href="${pageContext.request.contextPath}/counsel/counselList.do"><spring:message code="menu.help"/></a></li>
						</sec:authorize>


						<sec:authorize access="hasRole('ADMIN')">
						<li class="nav-item mx-2"><a class="nav-link" href="${pageContext.request.contextPath}/counsel/counselListAdmin.do"><spring:message code="menu.help"/></a></li>
						</sec:authorize>

					</ul>
				</div>

				<!-- 비로그인 -->
				<sec:authorize access="isAnonymous()">
					<div class="collapse navbar-collapse justify-content-end"
						id="navbarMain">
						<ul class="navbar-nav">
							<li class="nav-item m-1"><a	class="btn btn-warning nav-link text-light"	href="${pageContext.request.contextPath}/member/memberLogin.do"><spring:message code="menu.login"/></a></li>
							<li class="nav-item m-1"><a
								class="btn btn-primary nav-link text-light" href="${pageContext.request.contextPath}/member/memberEnroll.do"><spring:message code="menu.join"/></a>
							</li>
						</ul>
					</div>
				</sec:authorize>

				<!-- 일반 사용자 로그인 -->
				<sec:authorize access="isAuthenticated()">

					<div class="collapse navbar-collapse justify-content-end" id="navbarMain">
						<span class="navbar-text fs-5 text-light">
							<sec:authentication property="principal.username"/>
						</span>
						<span class="navbar-text fs-6 text-light ms-1"></span>
						<ul class="navbar-nav">
							<li class="nav-item dropdown">
								<a class="nav-link btn btn-warning dropdown-toggle text-dark mx-3 mt-1" href="#" id="dropdownUserMenu" role="button" data-bs-toggle="dropdown" aria-expanded="false">
									<spring:message code="MainMenu"/>
								</a>
								<ul class="dropdown-menu" aria-labelledby="dropdownUserMenu">
									<form:form action="${pageContext.request.contextPath}/member/memberLogout.do" method="POST">
									<button class="dropdown-item" type="submit"><spring:message code="menu.logout"/></button>
									</form:form>
									<sec:authorize access="hasRole('USER') && !hasRole('ADMIN')">
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/myProfile.do"><spring:message code="menu.myPage"/></a></li>
										<!-- <li><a class="dropdown-item" href="#">내 글 보기</a></li> -->
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberLectureList.do"><spring:message code="menu.myLecture"/></a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/order/pick.do"><spring:message code="menu.favorites"/></a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/order/basket.do"><spring:message code="menu.cart"/></a></li>
										<!-- <li><a class="dropdown-item" href="#">결제내역</a></li> -->
									</sec:authorize>
									<sec:authorize access="hasRole('USER') && !hasAnyRole('TEACHER', 'ADMIN')">
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/teacher/teacherRequest.do"><spring:message code="menu.applyTeacher"/></a></li>
									</sec:authorize>
									<sec:authorize access="hasRole('TEACHER')">
										<hr/>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/teacher/teacherProfile.do"><spring:message code="Tmenu.teacherPage"/></a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/lectureEnroll.do"><spring:message code="Tmenu.enrollLecture"/></a></li>
										<%-- <li><a class="dropdown-item" href="${pageContext.request.contextPath}/teacher/lectureCalList.do">정산내역</a></li> --%>
									</sec:authorize>
									<sec:authorize access="hasRole('ADMIN')">
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/applyTeacherList.do"><spring:message code="Amenu.applyTeacherList"/></a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/applyLectureList.do"><spring:message code="Amenu.applyLectureList"/></a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/manageLectureBoard.do"><spring:message code="Amenu.manageLecture"/></a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/manageMemberIndex.do"><spring:message code="Amenu.manageMember"/></a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/alarm/alarmList.do"><spring:message code="Amenu.notification"/></a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/data.do">데이터 현황</a></li>
									</sec:authorize>

				                </ul>
			              	</li>
			              	<li class="nav-item">
			                	<a class="nav-link px-0" href="${pageContext.request.contextPath}/alarm/alarmList.do" id="alertsDropdown" style="font-size: 1.5rem;">
			                    	<c:if test="${readVal > 0}">
				                    	<i class="fas fa-bell my-auto my-bell"></i>
			                    	</c:if>
			                    	<c:if test="${readVal == 0}">
				                    	<i class="far fa-bell my-auto"></i>
			                    	</c:if>
			                    	<!-- 알림 여부에 따라 아이콘 바꾸기 -->
			                    	<span class="badge badge-danger badge-counter"></span>
			                	</a>
			              	</li>
			            </ul>
			         </div>
				</sec:authorize>
			<!-- 다국어 : 추후 아이콘으로 변경 -->
			 <nav class="ms-4" aria-label="breadcrumb">
			   <ol class="breadcrumb mt-3">
			    <li class="breadcrumb-item"><a class="text-light text-decoration-none" href="javascript:changeLocale('ko')">
			   		 <spring:message code="lang.languageKorean"/></a></li>
			    <li class="breadcrumb-item active" aria-current="page"><a class="text-light text-decoration-none" href="javascript:changeLocale('en')">
			    	<spring:message code="lang.languageEnglish"/></a></li>
			  </ol>
			</nav>

			<%--  <div>
				<!-- text속성 :일치하는 key값이 없을 때 사용하는 default 표현 -->
				<select class="form-control" id="localeChoice">
				<option selected disabled ><spring:message code="lang.choiceLanguageText" text="*"/></option>
				<option value="ko"><spring:message code="lang.languageKorean" text="*"/></option>
				<option value="en"><spring:message code="lang.languageEnglish" text="*"/></option>
				</select>
			</div>  --%>
		</nav>
	</header>

	<section id="content">
	<!-- header.jsp 끝 -->