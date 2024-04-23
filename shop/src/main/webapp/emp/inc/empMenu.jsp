<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="#!">Bakery</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link" href="/shop/emp/empList.jsp"">Emp</a></li>
                <li class="nav-item"><a class="nav-link" href="/shop/emp/categoryList.jsp">Category</a></li>
                <li class="nav-item"><a class="nav-link" href="/shop/emp/goodsList.jsp">Goods</a></li>
                <li class="nav-item"><a class="nav-link" href="/shop/emp/customerList.jsp">Customer</a></li>
                <li class="nav-item"><a class="nav-link" href="/shop/emp/ordersList.jsp">Orders</a></li>
            </ul>
            <span class="d-flex">
            	<a href="/shop/emp/empLogout.jsp" class="btn btn-outline-dark">Logout</a>
			</span>	
        </div>
    </div>
</nav>
</div>