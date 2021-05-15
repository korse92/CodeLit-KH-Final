<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lecturerPage.css">

    <div class="container">
  
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-5">강의 등록 내역</h2>
        </div>
        
        <div class="mt-5">
          <table class="table text-center table-hover">
            <thead class="primary table-primary">
              <tr>
                <th scope="col">글 번호</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">등록 날짜</th>
                <th scope="col">강의 종류</th>
                <th scope="col">강의 상태</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1</td>
                <td>내 강의</td>
                <td>홍길동</td>
                <td>2021/03/21</td>
                <td><i class="far fa-calendar-minus"></i></td>
                <td><button type="button" class="btn btn-primary"><i class="far fa-eye"></i></button></td>
              </tr>
              <tr>
                <td>2</td>
                <td>내 강의</td>
                <td>홍길동</td>
                <td>2021/03/21</td>
                <td><i class="fas fa-font"></i></td>
                <td><button type="button" class="btn btn-success"><i class="fas fa-edit"></i></button></td>
              </tr>
              <tr>
                <td>3</td>
                <td>내 강의</td>
                <td>홍길동</td>
                <td>2021/03/21</td>
                <td><i class="fas fa-video"></i></td>
                <td><button type="button" class="btn btn-danger"><i class="far fa-trash-alt"></i></button></td>
              </tr>
            </tbody>
          </table>
        </div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>