<%@page import="java.nio.file.Files"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*" %>
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
	request.getParameter("UTF-8");

	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));

	String category = request.getParameter("category");
	String empId = (String)(loginEmp.get("empId"));
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	
	Part part = request.getPart("goodsImage");
	
	System.out.println(category + "<-- addGoodsAction param category");
	System.out.println(empId + "<-- addGoodsAction param empId");
	System.out.println(goodsTitle + "<-- addGoodsAction param goodsTitle");
	System.out.println(goodsContent + "<-- addGoodsAction param goodsContent");
	System.out.println(goodsPrice + "<-- addGoodsAction param goodsPrice");
	System.out.println(goodsAmount + "<-- addGoodsAction param goodsAmount");
	
	String originalName = null;
	int dotIdx = 0;
	String ext = null;
	String filename = null;
	if(part.getSize() > 0){
		originalName = part.getSubmittedFileName();
		dotIdx = originalName.lastIndexOf(".");
		ext = originalName.substring(dotIdx);
		UUID uuid = UUID.randomUUID();
		filename = uuid.toString().replace("-", "");
		filename = filename + ext;
	}
	
	System.out.println(filename + "<-- addGoodsAction filename");

	
	String sql = null;
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	if(filename == null){
		sql = "insert into goods (category, emp_id, goods_title, goods_content, goods_price, goods_amount) values (?, ?, ?, ?, ?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setString(2, empId);
		stmt.setString(3, goodsTitle);
		stmt.setString(4, goodsContent);
		stmt.setInt(5, goodsPrice);
		stmt.setInt(6, goodsAmount);
		System.out.println(stmt);
	} else {
		sql = "insert into goods (category, emp_id, goods_title, goods_content, goods_price, goods_amount, file_name) values (?, ?, ?, ?, ?, ?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setString(2, empId);
		stmt.setString(3, goodsTitle);
		stmt.setString(4, goodsContent);
		stmt.setInt(5, goodsPrice);
		stmt.setInt(6, goodsAmount);
		stmt.setString(7, filename);
		System.out.println(stmt);
	}
	
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1){
		//입력 성공
		System.out.println("입력성공");
		if(filename != null){
			InputStream is = part.getInputStream();
			String filePath = request.getServletContext().getRealPath("upload");
			File f = new File(filePath, filename);
			OutputStream os = Files.newOutputStream(f.toPath());
			is.transferTo(os);
			
			os.close();
			is.close();
		}
	} else {
		//입력 실패
		System.out.println("입력실패");
	}
	
	response.sendRedirect("/shop/emp/goodsList.jsp");
%>