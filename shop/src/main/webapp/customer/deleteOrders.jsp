<%@page import="shop.dao.GoodsDAO"%>
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
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(ordersNo + "<-- deleteOrders param orderNo");
	System.out.println(amount + "<-- deleteOrders param amount");
	System.out.println(goodsNo + "<-- deleteOrders param goodsNo");

	int row = OrdersDAO.deleteOrders(ordersNo);
	
	if(row == 1){
		//주문 취소 성공
		System.out.println("주문 취소 성공");
		row = GoodsDAO.updateGoodsAmount(goodsNo, -amount);
		if(row == 1){
			//수량 수정 성공
			System.out.println("수량 취소 성공");
		} else {
			//수량 수정 실패
			System.out.println("수량 취소 실패");
		}
	} else {
		//주문 취소 실패
		System.out.println("주문 취소 실패");
	}
	
	response.sendRedirect("/shop/customer/ordersList.jsp");
%>