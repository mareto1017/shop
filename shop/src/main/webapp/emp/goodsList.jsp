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

	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<-- goodsList currentPage");
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	
	String category = request.getParameter("category");
	System.out.println(category + "<-- goodsList category");
	
	
	
	
	String sql = null;
	sql = "select category, count(*) cnt from goods group by category order by category";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();		
		m.put("category", rs.getString("category"));
		m.put("cnt", rs.getInt("cnt"));
		
		categoryList.add(m);
		
	}
	
	int lastPage = 0;
	int cnt = 0;
	for(HashMap m : categoryList) {
		if(((String)(m.get("category"))).equals(category)){
			cnt = (Integer)(m.get("cnt"));
			break;
		}
		
		// 전체면 모든 카테고리의 카운트 값을 더함. 맞는게있으면 그 값을 cnt에 대입하고 break;
		cnt += (Integer)(m.get("cnt"));
	}
	
	if(cnt % rowPerPage == 0){
		lastPage = cnt / rowPerPage;
	} else {
		lastPage = cnt / rowPerPage + 1;
	}
	
	String sql2 = null;
	PreparedStatement stmt2 = null;
	if(category == null || category.equals("null")){
		sql2 = "select goods_no goodsNo, category, emp_id empId, goods_title " + 
				"goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
				"update_date updateDate, create_date createDate from goods order by goods_no desc limit ?, ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, startRow);
		stmt2.setInt(2, rowPerPage);
		System.out.println(stmt2);
	} else {
		sql2 = "select goods_no goodsNo, category, emp_id empId, goods_title " + 
				"goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
				"update_date updateDate, create_date createDate from goods where category = ? order by goods_no desc limit ?, ?";
		
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, category);
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
		System.out.println(stmt2);
	}
	
	
	ResultSet rs2 = null;
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
	
	while(rs2.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();		
		m.put("goodsNo", rs2.getInt("goodsNo"));
		m.put("category", rs2.getString("category"));
		m.put("empId", rs2.getString("empId"));
		m.put("goodsTitle", rs2.getString("goodsTitle"));
		m.put("goodsContent", rs2.getString("goodsContent"));
		m.put("goodsPrice", rs2.getInt("goodsPrice"));
		m.put("goodsAmount", rs2.getInt("goodsAmount"));
		m.put("updateDate", rs2.getString("updateDate"));
		m.put("createDate", rs2.getString("createDate"));
		
		goodsList.add(m);
		
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
	
	<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
	</div>
	
	<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
				<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category")) %>">
					<%=(String)(m.get("category")) %>
					(<%=(Integer)(m.get("cnt")) %>)
				</a>
		<%
			}
		%>
	</div>
	
	<div>
		<table border="1">
			<tr>
				<th>상품 번호</th>
				<th>카테고리</th>
				<th>사원 아이디</th>
				<th>상품 이름</th>
				<th>상품 내용</th>
				<th>상품 가격</th>
				<th>상품 재고</th>
				<th>수정 날짜</th>
				<th>생성 날짜</th>
			</tr>
			<%
				for(HashMap m : goodsList) {
			%>
					<tr>
						<td><%=(Integer)(m.get("goodsNo")) %></td>
						<td><%=(String)(m.get("category")) %></td>
						<td><%=(String)(m.get("empId")) %></td>
						<td><%=(String)(m.get("goodsTitle")) %></td>
						<td><%=(String)(m.get("goodsContent")) %></td>
						<td><%=(Integer)(m.get("goodsPrice")) %></td>
						<td><%=(Integer)(m.get("goodsAmount")) %></td>
						<td><%=(String)(m.get("updateDate")) %></td>
						<td><%=(String)(m.get("createDate")) %></td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
	
	<div>
		<%
			if(currentPage > 1 && currentPage < lastPage){
		%>
				
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음</a>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage - 1 %>&category=<%=category%>">이전</a>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>">다음</a>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>">마지막</a>
		<%
			} else if(currentPage == 1){
		%>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>">다음</a>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>">마지막</a>
		<%
			} else {
		%>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음</a>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage - 1 %>&category=<%=category%>">이전</a>
		<%
			}
		%>
	</div>
</body>
</html>