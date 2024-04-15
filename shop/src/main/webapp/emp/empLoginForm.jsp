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
</head>
<body>
	<form method="post" action="empLoginAction.jsp">
		id : <input type="text" name="empId">
		pw : <input type="password" name="empPw">
		<button type="submit">login</button>
	</form>
	
	<a href="/shop/emp/addEmpForm.jsp">회원가입</a>
</body>
</html>