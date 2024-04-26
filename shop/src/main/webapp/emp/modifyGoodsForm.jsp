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
	ArrayList<HashMap<String, String>> categoryList = CategoryDAO.selectCategoryList();

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
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	
	
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 col-6 bg-white rounded" style="height: 450px">
				<h1 class="text-center mt-4">상품 수정</h1>
				<form method="post" action="/shop/emp/modifyGoodsAction.jsp" enctype="multipart/form-data">
					<div class="ms-5 mb-3 mt-3 w-75">
						category :
						<select name="category">
							<option value="">선택</option>
							<%
								for(HashMap cm : categoryList) {
									if(cm.get("category").equals((String)(m.get("category")))){
							%>
										<option value="<%=cm.get("category")%>" selected><%=cm.get("category")%></option>
							<%
									} else {
							%>
										<option value="<%=cm.get("category")%>"><%=cm.get("category")%></option>
							<%			
									}
								}
							%>
						</select>
					</div>
					<input type="hidden" name="goodsNo" value='<%=(Integer)(m.get("goodsNo"))%>'>
				  	<div class="ms-5 mb-3 mt-3 w-75">
				    	<label class="form-label">goodsTitle</label>
				    	<input type="text" class="form-control" name="goodsTitle" value='<%=(String)(m.get("goodsTitle"))%>'>
				  	</div>
				  	<div class="ms-5 mb-3 mt-3 w-75">
				    	<label class="form-label">goodsImage</label>
				    	<input type="file" class="form-control" name="goodsImage">
				  	</div>
				  	<div class="ms-5 mb-3 mt-3 w-75">
				    	<label class="form-label">goodsPrice</label>
				    	<input type="number" class="form-control" name="goodsPrice" value='<%=(Integer)(m.get("goodsPrice"))%>'>
				  	</div>
				  	<div class="ms-5 mb-3 mt-3 w-75">
				    	<label class="form-label">goodsAmount</label>
				    	<input type="number" class="form-control" name="goodsAmount" value='<%=(Integer)(m.get("goodsAmount")) %>'>
				  	</div>
				  	<div class="ms-5 mb-3 mt-3 w-75">
				    	<label class="form-label">goodsContent</label>
				    	<textarea rows="5" cols="50" class="form-control" name="goodsContent"><%=(String)(m.get("goodsContent")) %></textarea>
				  	</div>
					<button type="submit" class="ms-5 mt-3 w-75 btn" style="background-color: #A3C6C4">상품 수정</button>
				</form>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>