<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>
<div>
	<a href="/shop/customer/goodsList.jsp">상품</a>
	<a href="/shop/customer/customerOne.jsp">회원정보</a>
	<a href="/shop/customer/ordersList.jsp">주문내역</a>
	<a href="/shop/customer/logout.jsp">로그아웃</a>

</div>