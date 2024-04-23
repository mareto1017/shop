<%@page import="shop.dao.GoodsDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
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
	String goodsTitle = request.getParameter("goodsTitle");
	String order = request.getParameter("order");
	System.out.println(category + "<-- goodsList param category");
	System.out.println(goodsTitle + "<-- goodsList param goodsTitle");
	System.out.println(order + "<-- goodsList param order");
	
	if(goodsTitle == null){
		goodsTitle = "";
	}
	
	if(order == null){
		order = "create_date";
	}
	

	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.selectGoodsCount(goodsTitle);
	
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
	

	ArrayList<HashMap<String, Object>> goodsList = GoodsDAO.selectGoodsList(category, goodsTitle, order, startRow, rowPerPage);

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/shop/css/goods.css">
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	
	<div>
		<form method="get" action="/shop/customer/goodsList.jsp">
			<input type="text" name="goodsTitle" placeholder="상품 이름" value="<%=goodsTitle %>">
			<button type="submit">검색</button>
		</form>
	</div>
	
	
	<div>
		<a href="/shop/customer/goodsList.jsp?order=<%=order %>&goodsTitle=<%=goodsTitle %>">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
				<a href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category")) %>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">
					<%=(String)(m.get("category")) %>
					(<%=(Integer)(m.get("cnt")) %>)
				</a>
		<%
			}
		%>
	</div>
	
	<div>
		<a href="/shop/customer/goodsList.jsp?order=goods_title&category=<%=category%>&goodsTitle=<%=goodsTitle %>">이름순</a>
		<a href="/shop/customer/goodsList.jsp?order=goods_price&category=<%=category%>&goodsTitle=<%=goodsTitle %>">가격순</a>
		<a href="/shop/customer/goodsList.jsp?order=create_date&category=<%=category%>&goodsTitle=<%=goodsTitle %>">최신순</a>
	</div>
	
	<div>
		<ul class="goodsList">
			<%
				for(HashMap m : goodsList) {
			%>
					<li class="goods">
						<div class="goodsImg">
							<a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">
								<img src="../upload/<%=(String)(m.get("filename")) %>">
							</a>
						</div>
						<div class="goodsInfo">
							<a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">
								<%=(String)(m.get("goodsTitle")) %>
							</a>
							<p><%=(Integer)(m.get("goodsPrice")) %></p>
						</div>
					</li>
			<%
				}
			%>
		</ul>
	</div>
	
	<div>
		<%
			if(currentPage > 1){
		%>
				  	<a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">처음</a>
				  	<a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage - 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">이전</a>
		<%
			}
			if(currentPage < lastPage){
		%>
				  	<a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">다음</a>
				  	<a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">마지막</a>
		<%
			} 
		%>
	</div>
</body>
</html>