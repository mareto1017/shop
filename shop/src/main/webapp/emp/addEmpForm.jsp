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
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	
	<div class="container" >
		<div class="row">
			<div class="col"></div>
			<div class="col-4 mt-5">
				<h1 style="text-align: center">회원가입</h1>
				<form method="post" action="/shop/emp/addEmpAction.jsp" >
					<div class="mb-3 mt-3">
					    <label class="form-label">Id</label>
					    <input type="text" class="form-control" name="empId">
				  	</div>
				  	
				  	<div class="mb-3">
				    	<label class="form-label">Pw</label>
					    <input type="password" class="form-control" name="empPw">
				  	</div>
				  	<div class="mb-3">
				    	<label class="form-label">Name</label>
					    <input type="text" class="form-control" name="empName">
				  	</div>
				  	<div class="mb-3">
				    	<label class="form-label">Job</label>
					    <input type="text" class="form-control" name="empJob">
				  	</div>
				  	<div class="mb-3">
				    	<label class="form-label">HireDate</label>
					    <input type="text" class="form-control" name="hireDate">
				  	</div>
				  	
				  	<button type="submit" class="w-100 btn" style="background-color: #A3C6C4">가입</button>
			  	</form>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>