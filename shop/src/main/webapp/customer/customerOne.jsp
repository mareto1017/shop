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
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	
	<div class="container">
		<div class="row justify-content-center mt-5">
			<div class="col"></div>
			<div class="col-8">
				<form method="post" action="/shop/customer/modifyCustomerPw.jsp">
					<input type="hidden" name="customerEmail" value="<%=loginCustomer.get("customerEmail") %>">
					<table class="table">
						<tr>
							<td>Email</td>
							<td><%=loginCustomer.get("customerEmail")%></td>
						</tr>
						<tr>
							<td>Pw</td>
							<td><input type="password" name="oldPw"></td>	
						</tr>
						<tr>
							<td>new Pw</td>
							<td>
								<input type="password" name="newPw">
								<button type="submit">비밀번호 변경</button>
							</td>
						</tr>
						<tr>
							<td>Name</td>
							<td><%=loginCustomer.get("customerName")%></td>
						</tr>
						<tr>
							<td>Gender</td>
							<td><%=loginCustomer.get("gender")%></td>
						</tr>
						<tr>
							<td>Birth</td>
							<td><%=loginCustomer.get("birth")%></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>