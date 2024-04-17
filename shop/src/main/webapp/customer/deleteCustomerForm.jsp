<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	<h1>회원탈퇴</h1>
	<form method="post"	action="deleteCustomerAction.jsp">
		Pw : <input type="password" name="pw">
		<button type="submit">탈퇴</button>
	</form>
</body>
</html>