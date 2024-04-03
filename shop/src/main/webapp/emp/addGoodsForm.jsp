<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
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
	String sql = null;
	sql = "select category from goods group by category";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	ArrayList<String> categoryList = new ArrayList<String>();
	
	while(rs.next()){
		categoryList.add(rs.getString("category"));
	}
	
	System.out.println(categoryList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	
	<h1>상품 등록</h1>
	
	<form method="post" action="/shop/emp/addGoodsAction.jsp">
		<div>
			category :
			<select name="category">
				<option value="">선택</option>
				<%
					for(String c : categoryList) {
				%>
						<option value="<%=c%>"><%=c%></option>
				<%		
					}
				%>
			</select>
		</div>
		<div>
			goodsTitle :
			<input type="text" name="goodsTitle">
		</div>
		
		<div>
			goodsPrice :
			<input type="text" name="goodsPrice">
		</div>
		<div>
			goodsAmount :
			<input type="number" name="goodsAmount">
		</div>
		<div>
			goodsContent :
			<textarea row="5" col="50" name="goodsContent"></textarea>
		</div>
		<button type="submit">상품등록</button>
	</form>
</body>
</html>