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
	int rowPerPage = 12;
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
	
	<!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                </div>
            </div>
        </header>
	
	
	
	<section class="py-5">
    	<div class="container px-4 px-lg-5 mt-5">
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
    		<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-left">
				<%
					for(HashMap m : goodsList) {
				%>
						<div class="col mb-5">
							<div class="card h-100">
		                            <!-- Product image-->
		                            <a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">
		                            	<img class="card-img-top img-fluid" src="../upload/<%=(String)(m.get("filename")) %>">
		                           	</a>
		                            <!-- Product details-->
		                            <div class="card-body p-4">
		                                <div class="text-center">
		                                    <!-- Product name-->
		                                    <h5 class="fw-bolder">
		                                    	<a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>">
													<%=(String)(m.get("goodsTitle")) %>
												</a>
											</h5>
		                                    <!-- Product price-->
		                                    <p><%=(Integer)(m.get("goodsPrice")) %></p>
		                                </div>
		                            </div>
							</div>
						</div>
				<%
					}
				%>
			</div>
		</div>
	</section>
	
	<div>
		<ul class="mb-4 pagination justify-content-center">
			<%
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">처음</a></li>
				  	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage - 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">이전</a></li>
			<%
				}else {
			%>
					<li class="page-item disabled"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">처음</a></li>
				  	<li class="page-item disabled"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage - 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">이전</a></li>		
			<%
				}
				if(currentPage < lastPage){
			%>
			  		<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">다음</a></li>
				  	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">마지막</a></li>
			<%
				} else { 
			%>
					<li class="page-item disabled"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">다음</a></li>
				  	<li class="page-item disabled"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>&order=<%=order %>&goodsTitle=<%=goodsTitle %>">마지막</a></li>
			<%
				}
			%>
		</ul>
	</div>
</body>
</html>