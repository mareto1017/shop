<%@page import="shop.dao.GoodsDAO"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.*"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
%>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	Part part = request.getPart("goodsImage");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsContent = request.getParameter("goodsContent");
	
	
	//디버깅
	System.out.println(goodsNo + "<-- modifyGoodsAction param goodsNo");
	System.out.println(category + "<-- modifyGoodsAction param category");
	System.out.println(goodsTitle + "<-- modifyGoodsAction param goodsTitle");
	System.out.println(part + "<-- modifyGoodsAction param goodsImage");
	System.out.println(goodsPrice + "<-- modifyGoodsAction param goodsPrice");
	System.out.println(goodsAmount + "<-- modifyGoodsAction param goodsAmount");
	System.out.println(goodsContent + "<-- modifyGoodsAction param goodsContent");
	
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

	System.out.println(filename + "<-- modifyGoodsAction filename");
	
	int row = GoodsDAO.updateGoods(filename, category, goodsTitle, goodsPrice, goodsAmount, goodsContent, goodsNo);
	
	if(row == 1){
		//변경 성공
		System.out.println("변경 성공");
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
		//변경 실패
		System.out.println("변경 실패");
	}
	
	response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo=" + goodsNo);
%>