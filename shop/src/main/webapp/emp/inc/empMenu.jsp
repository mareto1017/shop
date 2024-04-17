<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>
<div>
	<a href="/shop/emp/empList.jsp">사원관리</a>
	<a href="/shop/emp/categoryList.jsp">카테고리관리</a>
	<a href="/shop/emp/goodsList.jsp">상품관리</a>
	<a href="/shop/emp/customerList.jsp">회원관리</a>
	<a href="/shop/emp/empLogout.jsp">로그아웃</a>
	<span>
		<a href="/shop/emp/empOne.jsp">
			<%=(String)(loginEmp.get("empName")) %>
		</a>
		반갑습니다.
	</span>

</div>