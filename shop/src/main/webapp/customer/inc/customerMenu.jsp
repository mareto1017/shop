<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>
 <!-- Navigation-->
 <nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container px-4 px-lg-5">
         <a class="navbar-brand">Bakery</a>
         <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
         <div class="collapse navbar-collapse" id="navbarSupportedContent">
             <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                 <li class="nav-item"><a class="nav-link" href="/shop/customer/goodsList.jsp"">Goods</a></li>
                 <li class="nav-item"><a class="nav-link" href="/shop/customer/ordersList.jsp">OrderList</a></li>
                 <li class="nav-item"><a class="nav-link" href="/shop/customer/customerOne.jsp">My Info</a></li>
             </ul>
             
             <%
             	if(loginCustomer != null){
             %>
	             <span class="d-flex">
	             	<a href="/shop/customer/logout.jsp" class="btn btn-outline-dark">Logout</a>
	             </span>
             <%
             	}
             %>
         </div>
     </div>
 </nav>