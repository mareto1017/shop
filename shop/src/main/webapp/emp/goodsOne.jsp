<%@page import="shop.dao.GoodsDAO"%>
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
	
	HashMap<String, Object> m = GoodsDAO.selectGoods(goodsNo);
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
	
		<section class="py-5">
	    	<div class="container px-4 px-lg-5 mt-5">
	    		<div class="row justify-content-center">
				    <div class="col"></div>
					<div class="col-8">
						<div class="row">
							<div class="col">
								<div>
									<img src="../upload/<%=(String)(m.get("filename")) %>" width="400px" height="400px">
								</div>
							</div>
							<div class="col">
								<div>
									<table class="table">
										<tr>
											<td>상품 이름</td>
											<td><%=(String)(m.get("goodsTitle")) %></td>
										</tr>
										<tr>
											<td>상품 가격</td>
											<td><%=(Integer)(m.get("goodsPrice")) %></td>
										</tr>
										<tr>
											<td>상품 내용 </td>
											<td><%=(String)(m.get("goodsContent")) %></td>
										</tr>
									</table>
								</div>
							</div>
							<div>
								<a href="/shop/emp/modifyGoodsForm.jsp?goodsNo=<%=(Integer)(m.get("goodsNo")) %>" class="mt-3 w-100 btn" style="background-color: #A3C6C4">수정</a>
							</div>
						</div>
					</div>
					<div class="col"></div>
			</div>
   		</div>
	</section>
	
</body>
</html>