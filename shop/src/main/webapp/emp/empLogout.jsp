<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	String loginEmp = (String)session.getAttribute("loginEmp");
	System.out.println(loginEmp + " <-- loginEmp");
	if(loginEmp == null){
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
		return;
	}

%>
<%
	session.invalidate();
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
%>