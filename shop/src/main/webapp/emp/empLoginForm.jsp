<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmpLoginForm</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>	
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 col-4" style="height: 450px">
				<h1 class="text-center mt-4">Login</h1>
				<form method="post" action="/shop/emp/empLoginAction.jsp">
				  	<div class="ms-5 mb-3 mt-3 w-75">
				    	<label class="form-label">Id</label>
				    	<input type="text" class="form-control" name="empId">
				  	</div>
				  	<div class="ms-5 mb-3 w-75">
				    	<label class="form-label">Password</label>
				    	<input type="password" class="form-control" name="empPw">
				  	</div>
					<button type="submit" class="ms-5 mt-3 w-75 btn" style="background-color: #A3C6C4">로그인</button>
				</form>
				<a href="/shop/emp/addEmpForm.jsp" class="ms-5 mt-3 w-75 btn" style="background-color: #A3C6C4">회원가입</a>
			</div>
			
			<div class="col"></div>
		</div>
	</div>
</body>
</html>