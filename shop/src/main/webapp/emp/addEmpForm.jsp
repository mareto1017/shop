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
	
	<h1>Emp 회원 가입</h1>
	
	<form method="post" action="/shop/emp/addEmpAction.jsp">
		<div>
			Id :
			<input type="text" name="empId">
		</div>		
		<div>
			Pw :
			<input type="password" name="empPw">
		</div>
		<div>
			Name :
			<input type="text" name="empName">
		</div>	
		<div>
			Job :
			<input type="text" name="empJob">
		</div>	
		<div>
			HireDate :
			<input type="date" name="hireDate">
		</div>	
		<button type="submit">회원가입</button>
	</form>
</body>
</html>