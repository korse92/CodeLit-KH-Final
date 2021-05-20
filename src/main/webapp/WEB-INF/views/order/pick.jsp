<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="찜목록" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pick.css" />

<!-- Font Awesome(아이콘) CSS -->
<script src="https://kit.fontawesome.com/0e3c91e1c6.js" crossorigin="anonymous"></script>
<head>
</head>

<section class="container-pick">
    <h2 class="mt-5">찜 목록</h2>
    <hr/>

    <div class="orderBy">
        <div class="dropdown">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-bs-toggle="dropdown" aria-expanded="false">
                정렬 기준
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                <li><button class="dropdown-item" type="button">최신순</button></li>
                <li><button class="dropdown-item" type="button">제목순</button></li>
                <li><button class="dropdown-item" type="button">카테고리순</button></li>
                <li><button class="dropdown-item" type="button">수강료순</button></li>
            </ul>
        </div>
    </div>

    <div class="pick">
        <div class="lecture">
            <div class="show">
                <div class="img">
                    <img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" alt="">
                </div>
                <div class="info">
                    <span class="title">강의제목</span>
                    <span class="name">강사이름</span>
                    <span class="price">수강료</span>
                    <span class="avgLecAssessment">별점</span>
                <span class="category">카테고리</span>
                </div>
            </div> <!-- show -->
            <div class="hide">
                <div class="link_info">
                    <a href='http://www.google.com' class="moreInfo">
                        <span class="info">
                            Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                            Blanditiis porro ipsa ullam, vel sunt omnis culpa. Voluptate, itaque necessitatibus.
                            Natus reprehenderit et similique autem tempora ad culpa officia ab dolore.
                        </span>
                    </a>
                </div>
                <ul class="addLecture">
                    <li>
                        <button class="btn bt text-light col-8 me-2">
                            <i class="fas fa-shopping-basket"><span>&nbsp&nbsp장바구니 추가</span></i>
                        </button>
                    </li>
                    <li>
                        <button class="btn bt text-light col-6 me-2">
                            <i class="fas fa-heart"><span>&nbsp&nbsp찜 추가</span></i>
                        </button>
                    </li>
                </ul>
            </div> <!--hide -->
        </div> <!-- lecture -->

        <div class="lecture">
            <div class="show">
                <div class="img">
                    <img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" alt="">
                </div>
                <div class="info">
                    <span class="title">강의제목</span>
                    <span class="name">강사이름</span>
                    <span class="price">수강료</span>
                    <span class="avgLecAssessment">별점</span>
                <span class="category">카테고리</span>
                </div>
            </div> <!-- show -->
            <div class="hide">
                <div class="link_info">
                    <a href='http://www.google.com' class="moreInfo">
                        <span class="info">
                            Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                            Blanditiis porro ipsa ullam, vel sunt omnis culpa. Voluptate, itaque necessitatibus.
                            Natus reprehenderit et similique autem tempora ad culpa officia ab dolore.
                        </span>
                    </a>
                </div>
                <ul class="addLecture">
                    <li>
                        <button class="btn bt text-light col-8 me-2">
                            <i class="fas fa-shopping-basket"><span>&nbsp&nbsp장바구니 추가</span></i>
                        </button>
                    </li>
                    <li>
                        <button class="btn bt text-light col-6 me-2">
                            <i class="fas fa-heart"><span>&nbsp&nbsp찜 추가</span></i>
                        </button>
                    </li>
                </ul>
            </div> <!--hide -->
        </div> <!-- lecture -->

        <div class="lecture">
            <div class="show">
                <div class="img">
                    <img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" alt="">
                </div>
                <div class="info">
                    <span class="title">강의제목</span>
                    <span class="name">강사이름</span>
                    <span class="price">수강료</span>
                    <span class="avgLecAssessment">별점</span>
                <span class="category">카테고리</span>
                </div>
            </div> <!-- show -->
            <div class="hide">
                <div class="link_info">
                    <a href='http://www.google.com' class="moreInfo">
                        <span class="info">
                            Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                            Blanditiis porro ipsa ullam, vel sunt omnis culpa. Voluptate, itaque necessitatibus.
                            Natus reprehenderit et similique autem tempora ad culpa officia ab dolore.
                        </span>
                    </a>
                </div>
                <ul class="addLecture">
                    <li>
                        <button class="btn bt text-light col-8 me-2">
                            <i class="fas fa-shopping-basket"><span>&nbsp&nbsp장바구니 추가</span></i>
                        </button>
                    </li>
                    <li>
                        <button class="btn bt text-light col-6 me-2">
                            <i class="fas fa-heart"><span>&nbsp&nbsp찜 추가</span></i>
                        </button>
                    </li>
                </ul>
            </div> <!--hide -->
        </div> <!-- lecture -->

        <div class="lecture">
            <div class="show">
                <div class="img">
                    <img src="${pageContext.request.contextPath}/resources/images/banner1.jpg" alt="">
                </div>
                <div class="info">
                    <span class="title">강의제목</span>
                    <span class="name">강사이름</span>
                    <span class="price">수강료</span>
                    <span class="avgLecAssessment">별점</span>
                <span class="category">카테고리</span>
                </div>
            </div> <!-- show -->
            <div class="hide">
                <div class="link_info">
                    <a href='http://www.google.com' class="moreInfo">
                        <span class="info">
                            Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                            Blanditiis porro ipsa ullam, vel sunt omnis culpa. Voluptate, itaque necessitatibus.
                            Natus reprehenderit et similique autem tempora ad culpa officia ab dolore.
                        </span>
                    </a>
                </div>
                <ul class="addLecture">
                    <li>
                        <button class="btn bt text-light col-8 me-2">
                            <i class="fas fa-shopping-basket"><span>&nbsp&nbsp장바구니 추가</span></i>
                        </button>
                    </li>
                    <li>
                        <button class="btn bt text-light col-6 me-2">
                            <i class="fas fa-heart"><span>&nbsp&nbsp찜 추가</span></i>
                        </button>
                    </li>
                </ul>
            </div> <!--hide -->
        </div> <!-- lecture -->
    </div> <!-- picList -->
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>