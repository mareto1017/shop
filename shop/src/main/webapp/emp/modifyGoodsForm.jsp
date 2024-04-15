<%@page import="shop.dao.CategoryDAO"%>
<%@page import="shop.dao.GoodsDAO"%>
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
	ArrayList<String> categoryList = GoodsDAO.selcetCategoryList();

	System.out.println(categoryList);

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println(goodsNo + "<-- modifyGoodsForm param goodsNo");
	
	HashMap<String, Object> m = GoodsDAO.selectGoods(goodsNo);
	
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