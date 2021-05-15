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
<script src="${pageContext.request.contextPath}/resources/js/rolling.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/rolling.css">

<div class="container">
	<div class="col-8 row mx-auto my-lg-5">

		<div id="carouselExampleControls" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="d-block w-100"
						alt="...">
				</div>
				<div class="carousel-item">
					<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="d-block w-100"
						alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleControls" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleControls" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>

	</div>

	<div class="row justify-content-center">

		<div class="rollingPage">

			<div class="rollingHead">
				<p>추천검색</p>
			</div>

			<div class="rolling">
				<ul>
					<li><a href="#">김진하, kh 떠나나?</a></li>
					<li><a href="#">마이클황, 여행기 펴내다</a></li>
					<li><a href="#">유득삼 아직도 아이언 "사람이 아냐"</a></li>
				</ul>
			</div>
		</div>

		<div class="input-group mb-3 col-3"
			style="width: 20rem; height: 3rem;">
			<input type="text" class="form-control" placeholder="강의 검색"
				aria-label="Recipient's username" aria-describedby="button-addon2">
			<button class="btn btn-outline-secondary bg-light" type="button"
				id="button-addon2">검색</button>

		</div>
	</div>

	<hr />

	<div class="row">

		<div class="row my-4 px-5">
			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">UI/UX 설계</h5>
							<p class="card-text">김병순</p>
							<p class="card-text">
								4.5 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">66,000원</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">빅데이터 입문</h5>
							<p class="card-text">양꼬치앤 칭따오</p>
							<p class="card-text">
								3.7 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">30,000원</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">자바 기초</h5>
							<p class="card-text">김병순</p>
							<p class="card-text">
								3.2 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">54,000원</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">mySQL DB 입문</h5>
							<p class="card-text">한꼬장</p>
							<p class="card-text">
								4.8 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">28,000원</p>
						</div>
					</div>
				</a>
			</div>

		</div>
		<!-- 영상박스 row -->

		<div class="row my-4 px-5">

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">UI/UX 설계</h5>
							<p class="card-text">김병순</p>
							<p class="card-text">
								4.5 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">66,000원</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">UI/UX 설계</h5>
							<p class="card-text">김병순</p>
							<p class="card-text">
								4.5 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">66,000원</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">UI/UX 설계</h5>
							<p class="card-text">김병순</p>
							<p class="card-text">
								4.5 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">66,000원</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">UI/UX 설계</h5>
							<p class="card-text">김병순</p>
							<p class="card-text">
								4.5 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">66,000원</p>
						</div>
					</div>
				</a>
			</div>

		</div>
		<!-- 영상박스 row -->

		<div class="row my-4 px-5">

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">UI/UX 설계</h5>
							<p class="card-text">김병순</p>
							<p class="card-text">
								4.5 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">66,000원</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-3">
				<a href="#" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title">UI/UX 설계</h5>
							<p class="card-text">김병순</p>
							<p class="card-text">
								4.5 <img src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt=""> <img
									src="${pageContext.request.contextPath}/resources/images/star.png"
									style="width: 1rem; height: 1rem;" alt="">
							</p>
							<p class="card-text">66,000원</p>
						</div>
					</div>
				</a>
			</div>


		</div>
		<!-- 영상박스 row -->


	</div>



</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>