<%@page import="shop.dao.GoodsDAO"%>
<%@page import="shop.dao.ReviewDAO"%>
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
	System.out.println(ordersNo + "<-- deleteReview param ordersNo");

	int row = ReviewDAO.deleteReivew(ordersNo);
	
	if(row == 1){
		//리뷰 삭제 성공
		System.out.println("삭제 성공");
	} else {
		//리뷰 삭제 실패
		System.out.println("삭제 실패");
	}
	
	response.sendRedirect("/shop/customer/ordersList.jsp");
%>