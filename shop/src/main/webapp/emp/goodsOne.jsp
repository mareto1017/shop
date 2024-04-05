<%@page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*" %>
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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	System.out.println(goodsNo + "<-- goodsOne param goodsNo");
	
	String sql = null;
	sql = "select goods_no goodsNo, category, emp_id empId, goods_title " + 
			"goodsTitle, file_name filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
			"update_date updateDate, create_date createDate from goods where goods_no = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, goodsNo);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	
	HashMap<String, Object> m = new HashMap<>();
	if(rs.next()){
		
		m.put("goodsNo", rs.getInt("goodsNo"));
		//m.put("category", rs.getString("category")); 안쓰이고있음
		m.put("empId", rs.getString("empId"));
		m.put("goodsTitle", rs.getString("goodsTitle"));
		m.put("filename", rs.getString("filename"));
		m.put("goodsContent", rs.getString("goodsContent"));
		m.put("goodsPrice", rs.getInt("goodsPrice"));
		m.put("goodsAmount", rs.getInt("goodsAmount"));
		m.put("updateDate", rs.getString("updateDate"));
		m.put("createDate", rs.getString("createDate"));
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
		<div>
			<img src="../upload/<%=(String)(m.get("filename")) %>" width="300px" height="300px">
		</div>
		<div>
			<div>
				상품 번호 : <%=(Integer)(m.get("goodsNo")) %>
			</div>
			<div>
				상품 이름 : <%=(String)(m.get("goodsTitle")) %>
			</div>
			<div>
				등록 사원 : <%=(String)(m.get("empId")) %>
			</div>
			<div>
				상품 가격 : <%=(Integer)(m.get("goodsPrice")) %>
			</div>
			<div>
				상품 재고 : <%=(Integer)(m.get("goodsAmount")) %>
			</div>
			<div>
				상품 내용 : <%=(String)(m.get("goodsContent")) %>
			</div>
			<div>
				상품 수정 일자 : <%=(String)(m.get("updateDate")) %>
			</div>
			<div>
				상품 등록 일자 : <%=(String)(m.get("createDate")) %>
			</div>
		</div>
	</div>
	
	<div>
		<a href="/shop/emp/modifyGoodsForm.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">수정</a>
		<a href="/shop/emp/deleteGoods.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>"">삭제</a>
	</div>
</body>
</html>