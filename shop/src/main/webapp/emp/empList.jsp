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
	String sql = null;
	sql = "select emp_id empId, emp_name empName, emp_job empJob,  hire_date hireDate, active from emp order by active asc, hire_date desc";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	ResultSet rs = null;
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmpList</title>
</head>
<body>
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
			while(rs.next()){
				String empId = rs.getString("empId");
				String empName = rs.getString("empName");
				String empJob = rs.getString("empJob");
				String hireDate = rs.getString("hireDate");
				String active = rs.getString("active");
		%>
				<tr>
					<td><%=empId %></td>
					<td><%=empName %></td>
					<td><%=empJob %></td>
					<td><%=hireDate %></td>
					<td><%=active %></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>