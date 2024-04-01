<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String loginEmp = (String)session.getAttribute("loginEmp");
	System.out.println(loginEmp + " <-- loginEmp");
	if(loginEmp == null){
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
	
	String sql = null;
	sql = "update emp set active = ? where emp_id = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, active);
	stmt.setString(2, empId);
	System.out.println(stmt);
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1){
		//변경 성공
		System.out.println("변경 성공");
	} else {
		//변경 실패
		System.out.println("변경 실패");
	}
	
	response.sendRedirect("/shop/emp/empList.jsp");
%>
