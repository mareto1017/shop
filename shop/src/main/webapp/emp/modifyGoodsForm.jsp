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

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println(goodsNo + "<-- modifyGoodsForm param goodsNo");
	
	String sql2 = null;
	sql2 = "select goods_no goodsNo, category, emp_id empId, goods_title " + 
			"goodsTitle, file_name filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
			"update_date updateDate, create_date createDate from goods where goods_no = ?";

	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, goodsNo);
	System.out.println(stmt2);
	ResultSet rs2 = null;
	rs2 = stmt2.executeQuery();
	
	HashMap<String, Object> m = new HashMap<>();
	if(rs2.next()){
		
		m.put("goodsNo", rs2.getInt("goodsNo"));
		m.put("category", rs2.getString("category"));
		m.put("empId", rs2.getString("empId"));
		m.put("goodsTitle", rs2.getString("goodsTitle"));
		m.put("filename", rs2.getString("filename"));
		m.put("goodsContent", rs2.getString("goodsContent"));
		m.put("goodsPrice", rs2.getInt("goodsPrice"));
		m.put("goodsAmount", rs2.getInt("goodsAmount"));
		m.put("updateDate", rs2.getString("updateDate"));
		m.put("createDate", rs2.getString("createDate"));
	}
	
	System.out.println((String)(m.get("category")));
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
	
	<form method="post" action="/shop/emp/modifyGoodsAction.jsp" enctype="multipart/form-data">
		<input type="hidden" name="goodsNo" value='<%=(Integer)(m.get("goodsNo"))%>'>
		<div>
			category :
			<select name="category">
				<option value="">선택</option>
				<%
					for(String c : categoryList) {
						if(c.equals((String)(m.get("category")))){
				%>
							<option value="<%=c%>" selected><%=c%></option>
				<%
						} else {
				%>
							<option value="<%=c%>"><%=c%></option>
				<%			
						}
					}
				%>
			</select>
		</div>
		<div>
			goodsTitle :
			<input type="text" name="goodsTitle" value='<%=(String)(m.get("goodsTitle"))%>'>
		</div>
		
		<div>
			goodsImage :
			<input type="file" name="goodsImage" value='<%=(String)(m.get("filename")) %>'>
		</div>
		
		<div>
			goodsPrice :
			<input type="number" name="goodsPrice" value='<%=(Integer)(m.get("goodsPrice"))%>'>
		</div>
		<div>
			goodsAmount :
			<input type="number" name="goodsAmount" value='<%=(Integer)(m.get("goodsAmount")) %>'>
		</div>
		<div>
			goodsContent :
			<textarea row="5" col="50" name="goodsContent"><%=(String)(m.get("goodsContent")) %></textarea>
		</div>
		<button type="submit">상품 수정</button>
	</form>
</body>
</html>