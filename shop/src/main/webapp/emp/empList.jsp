<%@page import="shop.dao.EmpDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*" %>
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
	String paramEmpName = request.getParameter("empName");
	String order = request.getParameter("order");
	System.out.println(paramEmpName + "<-- empList param paramEmpName");
	System.out.println(order + "<-- empList param order");
	
	if(paramEmpName == null){
		paramEmpName = "";
	}
	
	if(order == null){
		order = "hire_date";
	}

	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<-- empList currentPage");
	
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	
	ArrayList<HashMap<String, Object>> list = EmpDAO.selectEmpList(order, paramEmpName, startRow, rowPerPage);
	
	int count = EmpDAO.selectEmpCount(paramEmpName);
	
	int lastPage = 0;
	if(count % rowPerPage == 0){
    	lastPage = count / rowPerPage;
	} else {
		lastPage = count / rowPerPage + 1;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmpList</title>
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	
	<h1>사원목록</h1>
	
	<div>
		<form method="get" action="/shop/emp/empList.jsp">
			<input type="text" name="empName" placeholder="사원 이름" value="<%=paramEmpName%>">
			<button type="submit">검색</button>
		</form>
	</div>
	
	<div>
		<a href="/shop/emp/empList.jsp?order=emp_id&empName=<%=paramEmpName%>">아이디</a>
		<a href="/shop/emp/empList.jsp?order=grade&empName=<%=paramEmpName%>">레벨</a>
		<a href="/shop/emp/empList.jsp?order=emp_name&empName=<%=paramEmpName%>">이름</a>
		<a href="/shop/emp/empList.jsp?order=emp_job&empName=<%=paramEmpName%>">직업</a>
		<a href="/shop/emp/empList.jsp?order=active&empName=<%=paramEmpName%>">액티브</a>
		<a href="/shop/emp/empList.jsp?order=hire_date&empName=<%=paramEmpName%>">입사일</a>
	</div>
	
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
					<td>
						<%=(String)(m.get("active")) %> 
						<%
							HashMap<String, Object> sm = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
							if((Integer)(sm.get("grade")) > 0){
						%>
								<a href="/shop/emp/modifyEmpActive.jsp?empId=<%=(String)(m.get("empId")) %>&active=<%=(String)(m.get("active"))%>">변경</a>
						<%
							}
						%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	
	<%
		if(currentPage > 1){
	%>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=1&order=<%=order %>&empName=<%=paramEmpName%>">처음</a>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage - 1 %>&order=<%=order %>&empName=<%=paramEmpName%>">이전</a>
	<%
			}
		if(currentPage < lastPage){
	%>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage + 1 %>&order=<%=order %>&empName=<%=paramEmpName%>">다음</a>
			  	<a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage %>&order=<%=order %>&empName=<%=paramEmpName%>">마지막</a>
	<%
		}
	%>
</body>
</html>