<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*" %>
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

	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<-- empList currentPage");
	
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	

	String sql = null;
	sql = "select emp_id empId, emp_name empName, emp_job empJob,  hire_date hireDate, active from emp order by hire_date desc limit ? , ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		String empId = rs.getString("empId");
		String empName = rs.getString("empName");
		String empJob = rs.getString("empJob");
		String hireDate = rs.getString("hireDate");
		String active = rs.getString("active");
		
		m.put("empId", empId);
		m.put("empName", empName);
		m.put("empJob", empJob);
		m.put("hireDate", hireDate);
		m.put("active", active);
		
		list.add(m);
		
	}
	
	String sql2 = null;
	sql2 = "select count(*) cnt from emp";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = stmt2.executeQuery();
	
	int count = 0;
	if(rs2.next()){
		 count = rs2.getInt("cnt");
	}
	
	int lastPage = 0;
	if(count % rowPerPage == 0){
    	lastPage = count / rowPerPage;
	} else {
		lastPage = count / rowPerPage + 1;
	}
	
	//자원반납
	rs.close();
	stmt.close();
	rs2.close();
	stmt2.close();
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmpList</title>
</head>
<body>
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	<h1>사원목록</h1>
	<table>
		<tr>
			<th>empId</th>
			<th>empName</th>
			<th>empJob</th>
			<th>hireDate</th>
			<th>active</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list){
		%>
				<tr>
					<td><%=(String)(m.get("empId")) %></td>
					<td><%=(String)(m.get("empName")) %></td>
					<td><%=(String)(m.get("empJob")) %></td>
					<td><%=(String)(m.get("hireDate")) %></td>
					<td><%=(String)(m.get("active")) %> <a href="/shop/emp/modifyEmpActive.jsp?empId=<%=(String)(m.get("empId")) %>&active=<%=(String)(m.get("active"))%>">변경</a></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<%
		if(currentPage > 1 && currentPage < lastPage){
	%>
			
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">처음</a>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage - 1 %>">이전</a>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage + 1 %>">다음</a>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage %>">마지막</a>
	<%
		} else if(currentPage == 1){
	%>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage + 1 %>">다음</a>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage %>">마지막</a>
	<%
		} else {
	%>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">처음</a>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage - 1 %>">이전</a>
	<%
		}
	%>
</body>
</html>