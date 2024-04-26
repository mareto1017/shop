<%@page import="shop.dao.ReviewDAO"%>
<%@page import="shop.dao.GoodsDAO"%>
<%@page import="java.util.*"%>
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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	System.out.println(goodsNo + "<-- goodsOne param goodsNo");
	
	HashMap<String, Object> goods = GoodsDAO.selectGoods(goodsNo);
	
	ArrayList<HashMap<String, Object>> reviewList = ReviewDAO.selectReviewList(goodsNo);
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
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	
	<section class="py-5">
    	<div class="container px-4 px-lg-5 mt-5">
    		<div class="row justify-content-center">
			    <div class="col"></div>
				<div class="col-8">
					<div class="row">
						<div class="col">
							<div>
								<img src="../upload/<%=(String)(goods.get("filename")) %>" width="400px" height="400px">
							</div>
						</div>
						<div class="col">
							<div>
								<table class="table">
									<tr>
										<td>상품 이름</td>
										<td><%=(String)(goods.get("goodsTitle")) %></td>
									</tr>
									<tr>
										<td>상품 가격</td>
										<td><%=(Integer)(goods.get("goodsPrice")) %></td>
									</tr>
									<tr>
										<td>상품 내용 </td>
										<td><%=(String)(goods.get("goodsContent")) %></td>
									</tr>
								</table>
							</div>
							<div>
								<form method="post" action="/shop/customer/addOrders.jsp?">
									<div class="ms-5 mb-3 mt-3 w-75">
								    	수량  <input type="text" class="form-control" name="amount">
								  	</div>
								  	<div class="ms-5 mb-3 w-75">
								    	<label class="form-label">주소</label>
								    	<input type="text" class="form-control" name="address">
								  	</div>
									<input type="hidden" name="goodsPrice" value="<%=(Integer)(goods.get("goodsPrice")) %>">
									<input type="hidden" name="goodsNo" value="<%=goodsNo%>">
									<button type="submit">주문</button>
								</form>
							</div>
						</div>
					</div>
					<div>
						<div class="mt-3 mb-3"><h3>상품후기</h3></div>
						<hr>
						<%
							for(HashMap m : reviewList){
						%>
								<div class="mt-3">
									<div>
						<%
										for(int i = 0; i < (Integer)(m.get("score") ); i++){
						%>
											&#11088;
						<%	
										}
						%>	
									</div>
									<div class="mt-3"><%=m.get("content") %></div>
									<hr>
								</div>
						<%
							}
						%>
					</div>
				</div>
				<div class="col"></div>
			</div>
   		</div>
	</section>
	
	
	
</body>
</html>