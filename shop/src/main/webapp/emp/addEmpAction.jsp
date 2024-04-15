<%@page import="shop.dao.EmpDAO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
	
%>
<%
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	String empName = request.getParameter("empName");
	String empJob = request.getParameter("empJob");
	String hireDate = request.getParameter("hireDate");

	
	System.out.println(empId + "<-- addCustomerAction param customerEmail");
	System.out.println(empPw + "<-- addCustomerAction param customerPw");
	System.out.println(empName + "<-- addCustomerAction param customerName");
	System.out.println(empJob + "<-- addCustomerAction param birth");
	System.out.println(hireDate + "<-- addCustomerAction param gender");
	
	int row = EmpDAO.insertEmp(empId, empPw, empName, empJob, hireDate);
	
	if(row == 1){
		//회원가입 성공
		System.out.println("회원가입 성공");
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
	} else {
		//회원가입 실패
		System.out.println("회원가입 실패");
		response.sendRedirect("/shop/emp/addEmpForm.jsp");
	}
%>