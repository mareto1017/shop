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
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo + "<-- addReviewForm param ordersNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="addReviewAction.jsp">
		<input type="hidden" name="ordersNo" value="<%=ordersNo %>">
		<div>
			점수 : <input type="number" name="score" max="10">
		</div>
		<div>
			리뷰 :<textarea rows="5" cols="30" name="content"></textarea>
		</div>
		<button type="submit">리뷰 작성</button>
	</form>
</body>
</html>