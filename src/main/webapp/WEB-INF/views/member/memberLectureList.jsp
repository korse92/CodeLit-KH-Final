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
	
<div class="container">
   <div class="row mt-5">
        <h2 class=" jb-larger mt-3 col-4">알림 목록</h2>
      </div>
      <div class="mt-5">
        <table class="table text-center">
          <thead class="table-primary">
            <tr>
              <th scope="col">글번호</th>
              <th scope="col">제목</th>
              <th scope="col">날짜</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th scope="row">1</th>
              <td><a href="./studentBoardDetail.html">새로운 공지</a></td>
              <td>2020/05/05</td>
            </tr>
            <tr>
              <th scope="row">1</th>
              <td><a href="./studentBoardDetail.html">새로운 공지</a></td>
              <td>2020/05/05</td>
            </tr>
            <tr>
              <th scope="row">1</th>
              <td><a href="./studentBoardDetail.html">새로운 공지</a></td>
              <td>2020/05/05</td>
            </tr>
            <tr>
              <th scope="row">1</th>
              <td><a href="./studentBoardDetail.html">새로운 공지</a></td>
              <td>2020/05/05</td>
            </tr>
            <tr>
              <th scope="row">1</th>
              <td><a href="./studentBoardDetail.html">새로운 공지</a></td>
              <td>2020/05/05</td>
            </tr>
            <tr>
              <th scope="row">1</th>
              <td><a href="./studentBoardDetail.html">새로운 공지</a></td>
              <td>2020/05/05</td>
            </tr>
            <tr>
              <th scope="row">1</th>
              <td><a href="./studentBoardDetail.html">새로운 공지</a></td>
              <td>2020/05/05</td>
            </tr>
            <tr>
              <th scope="row">1</th>
              <td><a href="./studentBoardDetail.html">새로운 공지</a></td>
              <td>2020/05/05</td>
            </tr>

          </tbody>
        </table>
      </div>
      <div class="notice-paging mt-5">
        <span class="pagination-span">
          <ul class="pagination board-paging">
            <li class="page-item"><a class="page-link" href="#">&#60</a></li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">4</a></li>
            <li class="page-item"><a class="page-link" href="#">5</a></li>
            <li class="page-item"><a class="page-link" href="#">&#62</a></li>
          </ul>
        </span>
      </div>
  </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>