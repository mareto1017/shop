<%@page import="shop.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
%>

<%
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	//디버깅
	System.out.println(empId + "<-- modifyEmpAction param empId");
	System.out.println(active + "<-- modifyEmpAction param active");
	
	if(active.equals("ON")){
		active = "OFF";
	} else {
		active = "ON";
	}
	
	int row = EmpDAO.updateEmp(active, empId);
	
	if(row == 1){
		//변경 성공
		System.out.println("변경 성공");
	} else {
		//변경 실패
		System.out.println("변경 실패");
	}
	
	response.sendRedirect("/shop/emp/empList.jsp");
%>
