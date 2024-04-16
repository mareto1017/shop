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
	String customerEmail = request.getParameter("customerEmail");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	int row = CustomerDAO.updateCustomerPw(customerEmail, oldPw, newPw);
	
	if(row == 1){
		//수정 성공
		System.out.println("수정 성공");
	} else {
		//수정 실패
		System.out.println("수정 실패");
	}
	
	response.sendRedirect("/shop/customer/customerOne.jsp");
%>