<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dao.OrdersDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
		return;
	}
	
%>
<%	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<-- empList currentPage");
	
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	
	ArrayList<HashMap<String, Object>> ordersList =  OrdersDAO.selectOrdersList(startRow, rowPerPage);
	
	int count = OrdersDAO.selectOrdersCount();
	
	int lastPage = 0;
	if(count % rowPerPage == 0){
		lastPage = count / rowPerPage;
	} else {
		lastPage = count / rowPerPage + 1;
	}
	
	
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	
	
	<table>
		<tr>
			<th>주문번호</th>
			<th>상품이름</th>
			<th>상품가격</th>
			<th>상품갯수</th>
			<th>합계</th>
			<th>주문상태</th>
			<th>주문날짜</th>
			<th>업데이트날짜</th>
		</tr>
		<%
			for(HashMap<String, Object> m : ordersList){
		%>
				<tr>
					<td><%=(Integer)(m.get("ordersNo")) %></td>
					<td><%=(String)(m.get("ordersName")) %></td>
					<td><%=(Integer)(m.get("goodsPrice")) %></td>
					<td><%=(Integer)(m.get("totalAmount")) %></td>
					<td><%=(Integer)(m.get("totalPrice")) %></td>
					<form>
					</form>
					<td>
						<form method="post" action="/shop/emp/modifyOrdersState.jsp">
							<input type="hidden" name="ordersNo" value="<%=(Integer)(m.get("ordersNo")) %>">
							<select name="state">
								<%
									if(((String)(m.get("state"))).equals("접수")){
								%>
										<option value="접수" selected>접수</option>
										<option value="배송중">배송중</option>
										<option value="배송완료">배송완료</option>
								<%
									} else if(((String)(m.get("state"))).equals("배송중")){
								%>
										<option value="접수">접수</option>
										<option value="배송중" selected>배송중</option>
										<option value="배송완료">배송완료</option>
								<%
									} else if(((String)(m.get("state"))).equals("배송완료")){
								%>
										<option value="접수">접수</option>
										<option value="배송중" >배송중</option>
										<option value="배송완료" selected>배송완료</option>
								<%
									}
								%>
							</select>
							<button type="submit">변경</button>
						</form>
					</td>
					<td><%=(String)(m.get("createDate")) %></td>
					<td><%=(String)(m.get("updateDate")) %></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<div>
		<%
			if(currentPage > 1){
		%>
				  	<a class="page-link" href="/shop/emp/orderssList.jsp?currentPage=1">처음</a>
				  	<a class="page-link" href="/shop/emp/ordersList.jsp?currentPage=<%=currentPage - 1 %>">이전</a>
		<%
			}
			if(currentPage < lastPage){
		%>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage + 1 %>">다음</a>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage %>">마지막</a>
		<%
			} 
		%>
	</div>

</body>
</html>