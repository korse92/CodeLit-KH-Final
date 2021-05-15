<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">

   	<div class="container">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-3">공부 게시판</h2>
          
          <div class="mt-4 col-sm-2">
            <select class="form-select">
              <option selected>검색</option>
              <option value="1">작성자</option>
              <option value="2">제목</option>
              <option value="3">내용</option>
            </select>
          </div>
            
          <div class="col-4 mt-4">
            <div class="input-group">  
              <div class="form-outline">
                <input type="search" id="form1" class="form-control"  placeholder="Search"/>              
              </div>
              <button type="button" class="btn btn-primary">
                <i class="fas fa-search"></i>
              </button>
            </div>
          </div>
        </div>
        
        <div class="mt-5">
          <table class="table text-center">
            <thead class="table-primary">
              <tr>
                <th scope="col">번호</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">날짜</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                  <th scope="row">1</th>
                  <td><a href="./studentBoardDetail.html">Mark</a></td>
                  <td>Otto</td>
                  <td>@mdo</td>
              </tr>
              <tr>
                <th scope="row">2</th>
                <td>Jacob</td>
                <td>Thornton</td>
                <td>@fat</td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
              </tr>
            </tbody>
          </table>
        </div>

            <div class="community-footer mt-5">
              <span class="pagination-span">
                <ul class="pagination board-paging pull-right">
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
            <button class="btn btn-primary pull-right board-write" onclick="location.href='./studentBoardWrite.html'">글쓰기</button>
          </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>