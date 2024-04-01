<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//로그인 인증 분기
	String loginEmp = (String)session.getAttribute("loginEmp");
	System.out.println(loginEmp + " <-- loginEmp");
	if(loginEmp != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
	
%>

<%
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	//디버깅
	System.out.println(empId + "<-- empLoginAction param empId");
	System.out.println(empPw + "<-- empLoginAction param empPw");
	
	
	String sql = null;
	sql = "select emp_id empId from emp where active='ON' and emp_id =? and emp_pw = password(?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	System.out.println(stmt);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	
	if(rs.next()){
		//로그인 성공
		System.out.println("로그인성공");
		session.setAttribute("loginEmp", rs.getString("empId"));
		
		response.sendRedirect("/shop/emp/empList.jsp");
	} else {
			//로그인 실패
			System.out.println("로그인 실패");
			String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
			response.sendRedirect("shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
	}
		
	//자원반납
	rs.close();
	stmt.close();
	conn.close();

%>