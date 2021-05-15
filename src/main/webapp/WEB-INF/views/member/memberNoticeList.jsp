<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userPage(notice,lectureList).css">

   <div class="userpage-container">
            <div class="titlt-box">
                <h2 class="userPage-jb-larger">내 강의</h2>
            </div>
            <div class="content-box">
                <div class="row content">
                    <div class="col-8 image-box">
                        <img class="content-img" src="./다운로드.jpg" alt="">
                    </div>
                    <div class="col-1">
                        <select class="form-select-sm" aria-label=".form-select-lg example">
                            <option selected>학습중</option>
                            <option value="1">완강</option>
                            <option value="2">모두보기</option>
                        </select>
                    </div>
                    <div class="col-3">
                        <select class="form-select-sm" aria-label=".form-select-lg example">
                            <option selected>최근 수강신청</option>
                            <option value="1">최근 공부한 순</option>
                            <option value="2">제목순</option>
                        </select>
                    </div>
                </div>
            <div class="row">
                <div class="col-4">
                    <div class="card-container">
                        <div class="card">
                            <img class="card-img-top" src="./다운로드.jpg"  alt="Card image"  style="width:100%">
                            <div class="card-body">
                                <h4 class="card-title">강의 제목</h4>
                                <p class="card-text">강의 소개 간략하게</p>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#qwe">자세히</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="card-container">
                        <div class="card">
                            <img class="card-img-top" src="./다운로드.jpg"  alt="Card image"  style="width:100%">
                            <div class="card-body">
                                <h4 class="card-title">강의 제목</h4>
                                <p class="card-text">강의 소개 간략하게</p>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#qwe">자세히</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-4">
                    <div class="card-container">
                        <div class="card">
                            <img class="card-img-top" src="./다운로드.jpg"  alt="Card image"  style="width:100%">
                            <div class="card-body">
                                <h4 class="card-title">강의 제목</h4>
                                <p class="card-text">강의 소개 간략하게</p>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#qwe">자세히</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="card-container">
                        <div class="card">
                            <img class="card-img-top" src="./다운로드.jpg"  alt="Card image"  style="width:100%">
                            <div class="card-body">
                                <h4 class="card-title">강의 제목</h4>
                                <p class="card-text">강의 소개 간략하게</p>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#qwe">자세히</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
  </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>