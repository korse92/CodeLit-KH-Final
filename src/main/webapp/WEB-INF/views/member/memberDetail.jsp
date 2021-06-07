<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="수정" name="title"/>
</jsp:include>

    <script>
        window.onload = function() {

            let upFile = document.getElementById('upFile');
            let thumb = document.getElementById('photo_img');
            upFile.addEventListener('change', function(e) {

              if(upFile.files[0] != null) {
                thumb.src = URL.createObjectURL(upFile.files[0]);
              } else {
                thumb.src = "";
              }

            });


        }

        window.onload = function() {

        	let $del = $('.deleteMemberOrderFrm');

        	$del.each(function(i, elem) {

        		elem.addEventListener('submit', function(e) {

        			if(confirm("정말로 탈퇴 하시겠습니까?")) {
        				return true;
        			} else {
        				e.preventDefault();
        			}

        		});

        	});

    </script>

    <style>
        #alarm {
            width: 25px;
            height: 25px;
        }


        #detailDiv {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        #photo {
            width: 8rem;
            height: 8rem;
            border: 1px solid black;
            margin: auto;
            border-radius: 5px;
        }
        #photo_img {
          max-width: 8rem;
          max-height: 8rem;
        }

        #upFile {
          width: 14rem;
          margin: 1rem 0rem 1rem 3rem;
        }

        #teach {
            width: 50rem;
            height: 30rem;
            /* border-top: 1px solid black; */
        }

        .td {
            width: 10rem;
        }
        .td2 {
            width: 10rem;
        }
        .td3 {
          width: 22rem;
        }

        #memberDetailDiv {
        	min-height: 60rem;
        }
    </style>

<!-- 컨텐츠 시작 -->

	   <div id="detailDiv">
		<section class="container">

		  <div class="container" id="memberDetailDiv">
	        <h2 class="mt-5"><spring:message code="ud.updateProfile" /></h2>
	        <hr/>
			<div class="row justify-content-end">
				<div class="col-auto">


					<form:form method="POST" class="deleteMemberOrderFrm"
                    				action="${pageContext.request.contextPath}/member/deleteMember.do">
                    				<input type="hidden" name="memberId" value="${member.memberId}"  />

                    	<button type="submit" class="btn btn-warning me-auto mt-3 mb-6"><spring:message code="admin.withdrawBtn" /></button>

                    </form:form>

				</div>
			</div>

	        <form:form action="${pageContext.request.contextPath}/member/memberUpdate.do?${_csrf.parameterName}=${_csrf.token}"
	            		method="POST" id="memberUpdateFrm"
	            		enctype="multipart/form-data" >

	             <table id="teach" class="text-center row">
	                   <tr>
	                       <td rowspan="2" colspan="2" class="td">

	                          <div id="photo">
	        				<img src="${pageContext.request.contextPath}/resources/upload/member/${member.memberReProfile}" alt=""  id="photo_img"/>
	        			  	  </div>
	                      </td>

	                        <td colspan="1" class="td2">
	                           <label for="memberId"><spring:message code="login.id" /></label>
							</td>

	                        <td colspan="3" class="td3">
	                            <input type="text" class="form-control" name="memberId" id="memberId" value="${member.memberId}" readonly required >

	                        </td>
	                  </tr>

	                    <tr>
	                        <td colspan="1" class="td2">
	                            <label for="password"><spring:message code="login.pwd" /></label>
	                        </td>

	                        <td colspan="3" class="td3">
	                           <input type="password" class="form-control" id="password" name="memberPw"  value="" required >
	                        </td>
	                    </tr>

	                      <tr>
	                   		<td colspan="2">
	                       		   <input type="file" name="upFile" id="upFile" accept="image/jpeg, image/jpg, image/png">
	                       	</td>

	                        <td colspan="1" class="td2">
	                            <label for="chkPassword"><spring:message code="signUp.confirmPwd" /></label>
	                        </td>

	                        <td colspan="3" class="td3">
	                        <input type="password" class="form-control" id="chkPassword" required>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td colspan="1">

	                        </td>

	                        <td colspan="4">
	                          <button type="submit" class="btn btn-primary mt-3 mb-6"><spring:message code="admin.editBtn" /></button>
	                          <button type="reset" class="btn btn-warning mt-3 mb-6" onclick="location.href='${pageContext.request.contextPath}/member/myProfile.do'"><spring:message code="admin.backBtn" /></button>
	                        </td>
	                        <td colspan="1">

	                        </td>
	                    </tr>

	                </table>
			</form:form>
	        </div> <!-- 실제 등록폼만 감싸는 디브 -->
		</section>

	</div>

<script>


/* 패스워드 확인 */
$("#chkPassword").blur(function(){
	var $password = $("#password"), $chkPassword = $("#chkPassword");
	if($password.val() != $chkPassword.val()){
		alert("패스워드가 일치하지 않습니다.");
		$password.select();
	}
	return true;
});


</script>


<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>