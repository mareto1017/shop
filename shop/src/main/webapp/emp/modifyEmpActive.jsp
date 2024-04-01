<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String loginEmp = (String)session.getAttribute("loginEmp");
	System.out.println(loginEmp + " <-- loginEmp");
	if(loginEmp == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyEmpActive</title>
</head>
<body>

</body>
</html>