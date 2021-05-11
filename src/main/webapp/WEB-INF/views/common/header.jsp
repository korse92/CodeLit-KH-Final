<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	crossorigin="anonymous"></script>

<!-- Bootstrap JS : JQuery load 이후에 작성할것.-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet" crossorigin="anonymous">
<!-- Font Awesome(아이콘) CSS -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">

<!-- 사용자작성 JS -->
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>

<!-- 사용자작성 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />

<!-- redirectAttr.addFlashAttribute의 저장된 속성값 사용(1회용) -->
<c:if test="${not empty msg}">
	<script>
alert("${msg}");
</script>
</c:if>
</head>
<body>
	<header>

		<nav class="navbar navbar-expand-lg navbar-dark">
			<div class="container">
				<a class="navbar-brand me-4" href="#">CodeL!t</a>

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
								data-bs-toggle="dropdown" aria-expanded="false"> 커뮤니티 </a>
							<ul class="dropdown-menu" id="dropdownCommunity"
								aria-labelledby="navlinkDropdownCommunity">
								<li><a class="dropdown-item" href="#">공지사항</a></li>
								<li><a class="dropdown-item" href="#">공부게시판</a></li>
							</ul></li>
						<li class="nav-item dropdown mx-2"><a
							class="nav-link dropdown-toggle" href="#"
							id="navlinkDropdownLecture" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> 강의 </a>
							<ul class="dropdown-menu" id="dropdownLecture"
								aria-labelledby="navlinkDropdownLecture">
								<li><a class="dropdown-item" href="#">프런트</a></li>
								<li><a class="dropdown-item" href="#">백엔드</a></li>
								<li><a class="dropdown-item" href="#">빅데이터</a></li>
							</ul></li>
						<li class="nav-item mx-2"><a class="nav-link" href="#">문의</a>
						</li>
					</ul>
				</div>

				<div class="collapse navbar-collapse justify-content-end"
					id="navbarMain">
					<ul class="navbar-nav">
						<li class="nav-item m-1"><a	class="btn btn-warning nav-link text-light"	href="../html/login.html">Sign In</a></li>
						<!-- 로그인 Modal 버전 -->
						<!-- <li class="nav-item m-1">
             <a class="btn btn-warning nav-link text-light" data-bs-toggle="modal" data-bs-target="#exampleModal">Sign In(Modal)</a>
           </li> -->
						<li class="nav-item m-1"><a
							class="btn btn-primary nav-link text-light" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do';">Sign Up</a>
						</li>
					</ul>
				</div>
			</div>
		</nav>

		<!-- 로그인 Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header text-center">
						<h5 class="modal-title text-center" id="exampleModalLabel">CodeL!t</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"	aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="#" method="POST">
							<table class="col-10 offset-1">
								<tr>
									<td colspan="3"><input type="text my-4 p-1"
										class="form-control" name="id" placeholder="아이디"></td>
									<td rowspan="2" colspan="2">
										<button type="submit" class="btn btn-warning btn-xl py-4">로그인</button>
									</td>
								</tr>
								<tr colspan="3">
									<td><input type="password" class="form-control p-1"
										name="password" placeholder="패스워드"></td>
								</tr>
							</table>
						</form>
					</div>
					<div class="modal-footer">

						<p>추가내용</p>
					</div>
				</div>
			</div>
		</div>

	</header>

	<section id="content">
	<!-- header.jsp 끝 -->