<%@page import="shop.dao.EmpDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*" %>
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
	//디버깅
	System.out.println(empId + "<-- empLoginAction param empId");
	System.out.println(empPw + "<-- empLoginAction param empPw");
	
	Map<String, Object> loginEmp =  new HashMap<String, Object>();
	loginEmp = EmpDAO.selectEmp(empId, empPw);
	
	if(loginEmp != null){
		//로그인 성공
		System.out.println("로그인성공");
		
		
		session.setAttribute("loginEmp", loginEmp);
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
		System.out.println((String)(m.get("empId")));
		System.out.println((String)(m.get("empName")));
		System.out.println((Integer)(m.get("grade")));
		
		response.sendRedirect("/shop/emp/empList.jsp");
	} else {
			//로그인 실패
			System.out.println("로그인 실패");
			String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
			response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
	}

%>