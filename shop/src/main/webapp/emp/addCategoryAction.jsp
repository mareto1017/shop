<%@page import="shop.dao.CategoryDAO"%>
<%@page import="java.sql.*"%>
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
	String category = request.getParameter("category");
	System.out.println(category + "<--addCateogoryAction param cateogory");	

	int row = CategoryDAO.insertCategory(category);
	
	if(row == 1){
		//추가 성공
		System.out.println("추가 성공");
	} else {
		//추가 실패
		System.out.println("추가 실패");
	}
	
	response.sendRedirect("/shop/emp/categoryList.jsp");
%>
