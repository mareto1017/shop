<%@page import="java.awt.Graphics2D"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="shop.dao.GoodsDAO"%>
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
	request.setCharacterEncoding("UTF-8");

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

	int row = GoodsDAO.insertGoods(filename, category, empId, goodsTitle, goodsContent, goodsPrice, goodsAmount);
	
	if(row == 1){
		//입력 성공
		System.out.println("입력성공");
		if(filename != null){
			InputStream is = part.getInputStream();
			
			//이미지 크기 조정
			BufferedImage originalImage = ImageIO.read(is);
        	int targetWidth = 300;
        	int targetHeight = 300;
        
        	BufferedImage resizedImage = new BufferedImage(targetHeight, targetHeight, originalImage.getType());
        	Graphics2D g = resizedImage.createGraphics();
        	g.drawImage(originalImage, 0, 0, targetWidth, targetHeight, null);
        	g.dispose();

        	// 조정된 이미지를 저장
        	String filePath = request.getServletContext().getRealPath("upload");
        	File f = new File(filePath, filename);
        	ImageIO.write(resizedImage, "png", f);
			
			is.close();
		}
	} else {
		//입력 실패
		System.out.println("입력실패");
	}
	
	response.sendRedirect("/shop/emp/goodsList.jsp");
%>