<%@page import="java.util.*"%>
<%@page import="shop.dao.CustomerDAO"%>
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
	String customerPw = request.getParameter("pw");
	System.out.println(customerPw + " <-- deleteCustomerAction param customerPw");
	
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	String customerEmail = (String)(loginCustomer.get("customerEmail"));
	
	int row = CustomerDAO.deleteCustomer(customerEmail, customerPw);
	
	if(row == 1){
		//탈퇴 성공
		System.out.println("탈퇴 성공");
		session.invalidate();
		response.sendRedirect("/shop/customer/loginForm.jsp");
	} else {
		//탈퇴 실패
		System.out.println("탈퇴 실패");
		response.sendRedirect("/shop/customer/deleteCustomerForm.jsp");
	}
%>