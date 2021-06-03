<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!-- footer.jsp 시작 -->
</section>

  <style>
  	#commonFooter {
  		border-top: 1px solid gray;
  		margin-top: 6rem;
  	}
  </style>

<footer id = "commonFooter" class="d-flex align-items-center justify-content-center">
  <div class="container">
    <div class="row">
      <p class="mb-0 text-center">
      	<a href="${pageContext.request.contextPath}/admin/data.do">
      	&lt;<spring:message code="footer.msg"/>&gt;
      	</a>
      </p>
    </div>
  </div>
</footer>

</body>
</html>
<!-- footer.jsp 끝 -->