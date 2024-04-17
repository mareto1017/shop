<%@page import="shop.dao.CustomerDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.*"%>
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
	String paramCustomerMail = request.getParameter("customerMail");
	String order = request.getParameter("order");
	System.out.println(paramCustomerMail + "<-- customerList param paramCustomerMail");
	System.out.println(order + "<-- customerList param order");
	
	if(paramCustomerMail == null){
		paramCustomerMail = "";
	}
	
	if(order == null){
		order = "mail";
	}

	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<-- customerList currentPage");
	
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	
	ArrayList<HashMap<String, Object>> list = CustomerDAO.selectCustomerList(order, paramCustomerMail, startRow, rowPerPage);
	
	int count = CustomerDAO.selectCustomerCount(paramCustomerMail);
	
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
<title>Insert title here</title>
</head>
<body>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	
	<h1>사원목록</h1>
	
	<div>
		<form method="get" action="/shop/emp/customerList.jsp">
			<input type="text" name="customerMail" placeholder="이메일" value="<%=paramCustomerMail%>">
			<button type="submit">검색</button>
		</form>
	</div>
	
	<div>
		<a href="/shop/emp/customerList.jsp?order=mail&customerMail=<%=paramCustomerMail%>">이메일</a>
		<a href="/shop/emp/customerList.jsp?order=name&customerMail=<%=paramCustomerMail%>">이름</a>
		<a href="/shop/emp/customerList.jsp?order=gender&customerMail=<%=paramCustomerMail%>">성별</a>
		<a href="/shop/emp/customerList.jsp?order=birth&customerMail=<%=paramCustomerMail%>">생일</a>
	</div>
	
	<table>
		<tr>
			<th>Mail</th>
			<th>Name</th>
			<th>Gender</th>
			<th>Birth</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list){
		%>
				<tr>
					<td><%=(String)(m.get("customerMail")) %></td>
					<td><%=(String)(m.get("customerName")) %></td>
					<td><%=(String)(m.get("gender")) %></td>
					<td><%=(String)(m.get("birth")) %></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<%
		if(currentPage > 1){
	%>
			  	<a class="page-link" href="/shop/emp/customerList.jsp?currentPage=1&order=<%=order %>&customerMail=<%=paramCustomerMail%>">처음</a>
			  	<a class="page-link" href="/shop/emp/customerList.jsp?currentPage=<%=currentPage - 1 %>&order=<%=order %>&customerMail=<%=paramCustomerMail%>">이전</a>
	<%
			}
		if(currentPage < lastPage){
	%>
			  	<a class="page-link" href="/shop/emp/customerList.jsp?currentPage=<%=currentPage + 1 %>&order=<%=order %>&customerMail=<%=paramCustomerMail%>">다음</a>
			  	<a class="page-link" href="/shop/emp/customerList.jsp?currentPage=<%=lastPage %>&order=<%=order %>&customerMail=<%=paramCustomerMail%>">마지막</a>
	<%
		}
	%>
</body>
</html>