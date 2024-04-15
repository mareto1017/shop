<%@page import="shop.dao.CustomerDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String customerEmail = request.getParameter("customerEmail");
	String customerPw = request.getParameter("customerPw");
	
	System.out.println(customerEmail + "<-- loginAction param customerEmail");
	System.out.println(customerPw + "<-- loginAction param customerPw");

	HashMap<String, Object> loginCustomer = CustomerDAO.selectCustomer(customerEmail, customerPw);
	
	if(loginCustomer != null){
		
		session.setAttribute("loginCustomer", loginCustomer);
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
		System.out.println((String)(m.get("customerEmail")));
		System.out.println((String)(m.get("customerName")));
		System.out.println((String)(m.get("birth")));
		System.out.println((String)(m.get("gender")));
		
		response.sendRedirect("/shop/customer/goodsList.jsp");
	} else {
		//로그인 실패
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
		response.sendRedirect("/shop/customer/loginForm.jsp?errMsg=" + errMsg);
	}
%>