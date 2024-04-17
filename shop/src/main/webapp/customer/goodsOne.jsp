<%@page import="shop.dao.GoodsDAO"%>
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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	System.out.println(goodsNo + "<-- goodsOne param goodsNo");
	
	HashMap<String, Object> m = GoodsDAO.selectGoods(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	
	<div>
		<div>
			<img src="../upload/<%=(String)(m.get("filename")) %>" width="300px" height="300px">
		</div>
		<div>
			<div>
				상품 이름 : <%=(String)(m.get("goodsTitle")) %>
			</div>
			<div>
				상품 가격 : <%=(Integer)(m.get("goodsPrice")) %>
			</div>
			<div>
				상품 내용 : <%=(String)(m.get("goodsContent")) %>
			</div>
		</div>
	</div>
	
	<div>
		<a href="/shop/customer/.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>"">주문</a>
	</div>
</body>
</html>