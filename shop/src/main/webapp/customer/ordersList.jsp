<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dao.OrdersDAO"%>
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
	String mail = (String)(loginCustomer.get("customerEmail"));
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<-- goodsList currentPage");
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	
	int lastPage = 0;
	int cnt = OrdersDAO.selectOrdersCount();
	
	if(cnt % rowPerPage == 0){
		lastPage = cnt / rowPerPage;
	} else {
		lastPage = cnt / rowPerPage + 1;
	}
	
	
	ArrayList<HashMap<String, Object>> ordersList = OrdersDAO.selectOrdersListByCustomer(mail, startRow, rowPerPage);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주문 내역</h1>
	<table border="1">
		<tr>
			<td>상품 이름</td>
			<td>상품 갯수</td>
			<td>배송 주소</td>
			<td>총 가격</td>
			<td>주문 날짜</td>
			<td>주문 상태</td>
		</tr>
		<%
			for(HashMap<String, Object> m : ordersList){
		%>
				<tr>
					<td><%=(String)(m.get("goodsTitle")) %></td>
					<td><%=(Integer)(m.get("totalAmount")) %></td>
					<td><%=(String)(m.get("address")) %></td>
					<td><%=(Integer)(m.get("totalPrice")) %></td>
					<td><%=(String)(m.get("createDate")) %></td>
					<td><%=(String)(m.get("state")) %></td>
		<%
					if(((String)(m.get("state"))).equals("배송완료")){
		%>
						<td><a href="/shop/customer/addReviewForm.jsp?ordersNo=<%=(Integer)(m.get("ordersNo")) %>">리뷰 작성</a></td>
		<%
					}
		%>

		<%
			}
		%>
	</table>
</body>
</html>