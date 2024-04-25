<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>
<%
	String checkedEmail = request.getParameter("checkEmail");
	String check = request.getParameter("check");

	System.out.println(checkedEmail + "<-- addCustomerAction param checkedEmail");
	System.out.println(check + "<-- addCustomerAction param check");
	
	//검사한 이메일 checkEmail, 검사 완료 후 사용가능 판정난 이메일 checkedEmail
	String checkEmail = "";
	String checkMsg = "사용 가능한 이메일입니다.";
	
	if(check == null){
		check = "";
		checkMsg = "";
	}
	
	if(checkedEmail == null){
		checkedEmail = "";
	} else{
		checkEmail = checkedEmail;
	}
	
	if(check.equals("X")){
		checkedEmail = "";
		checkMsg = "사용할 수 없는 이메일입니다.";
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
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	
	<div class="container" >
		<div class="row">
			<div class="col"></div>
			<div class="col-4 mt-5">
				<h1 style="text-align: center">회원가입</h1>
				<form method="post" action="/shop/customer/checkMailAction.jsp">
					<div class="mb-3 mt-3">
						EmailCheck <input type="email" class="form-control" name="customerEmail" value="<%=checkEmail %>">
						<button type="submit" class="btn mt-2" style="background-color: #A3C6C4">확인</button>
					</div>
					<div>
						<p><%=checkMsg %></p>
					</div>
				</form>
				<form method="post" action="/shop/customer/addCustomerAction.jsp" >
					<div class="mb-3 mt-3">
					    <label class="form-label">Email</label>
					    <input type="text" class="form-control" name="customerEmail" value="<%=checkedEmail %>">
				  	</div>
				  	
				  	<div class="mb-3">
				    	<label class="form-label">Pw</label>
					    <input type="password" class="form-control" name="customerPw">
				  	</div>
				  	<div class="mb-3">
				    	<label class="form-label">Name</label>
					    <input type="text" class="form-control" name="customerName">
				  	</div>
				  	<div class="mb-3">
				    	<label class="form-label">Birth</label>
					    <input type="date" class="form-control" name="birth">
				  	</div>
				  	<div class="mb-3">
				    	<label class="form-label">Gender</label>
						<input type="radio" name="gender" value="남">남
						<input type="radio" name="gender" value="여">여
				  	</div>
				  	
				  	<button type="submit" class="w-100 btn" style="background-color: #A3C6C4">가입</button>
			  	</form>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>