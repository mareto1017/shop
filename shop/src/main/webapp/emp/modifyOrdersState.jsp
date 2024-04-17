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
	String state = request.getParameter("state");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(state + "<-- modifyOrdersState param state");
	System.out.println(ordersNo + "<-- modifyOrdersState param ordersNo");
	
	int row = OrdersDAO.updateOrdersState(ordersNo, state);
	
	if(row == 1){
		System.out.println("변경 성공");
	} else {
		System.out.println("변경 실패");
	}
	
	response.sendRedirect("/shop/emp/ordersList.jsp");
%>