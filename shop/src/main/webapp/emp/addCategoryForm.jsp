<%@page import="java.net.URLEncoder"%>
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
			<div class="mt-5 col-4 bg-white rounded" style="height: 450px">
				<h1 class="text-center mt-4">카테고리 추가</h1>
				<form method="post" action="/shop/emp/addCategoryAction.jsp">
				  	<div class="ms-5 mb-3 mt-3 w-75">
				    	<label class="form-label">카테고리</label>
				    	<input type="text" class="form-control" name="category">
				  	</div>
					<button type="submit" class="ms-5 mt-3 w-75 btn" style="background-color: #A3C6C4">추가</button>
				</form>
			</div>
			<div class="col"></div>
		</div>
	</div>

</body>
</html>