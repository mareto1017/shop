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
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo + "<-- addReviewForm param ordersNo");
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
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 col-4 bg-white rounded" style="height: 450px">
				<h1 class="text-center mt-4">Reivew</h1>
				<form method="post" action="/shop/customer/addReviewAction.jsp">
					<input type="hidden" name="ordersNo" value="<%=ordersNo %>">
				  	<div class="ms-5 mb-3 mt-3 w-75">
				    	<label class="form-label">별점</label>
				    	<input type="number" class="form-control" name="score" max="5">
				  	</div>
				  	<div class="ms-5 mb-3 w-75">
				    	<label class="form-label">리뷰</label>
				    	<textarea rows="5" class="form-control" cols="30" name="content"></textarea>
				  	</div>
					<button type="submit" class="ms-5 mt-3 w-75 btn" style="background-color: #A3C6C4">작성</button>
				</form>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>