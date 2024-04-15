<%@page import="shop.dao.CustomerDAO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>
<%
	String customerEmail = request.getParameter("customerEmail");

	System.out.println(customerEmail + "<-- checkMailAction param customerEmail");
	
	String check = CustomerDAO.selectCustomerMail(customerEmail);
	
	response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkEmail=" + customerEmail + "&check=" + check);
%>