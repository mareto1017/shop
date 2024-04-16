<%@page import="shop.dao.CustomerDAO"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		Email : <%=loginCustomer.get("customerEmail")%>
	</div>
	<form method="post" action="/shop/customer/modifyCustomerPw.jsp">
		<input type="hidden" name="customerEmail" value="<%=loginCustomer.get("customerEmail") %>">
		<div>
			Pw : <input type="password" name="oldPw">
		</div>
		<div>
			new Pw : <input type="password" name="newPw">
		</div>
		<button type="submit">비밀번호 변경</button>
	</form>
	<div>
		Name : <%=loginCustomer.get("customerName")%>
	</div>
	<div>
		Gender : <%=loginCustomer.get("gender")%>
	</div>
	<div>
		Birth : <%=loginCustomer.get("birth")%>
	</div>
</body>
</html>