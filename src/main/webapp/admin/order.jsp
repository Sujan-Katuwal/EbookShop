
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List" %>
<%@page import="com.DAO.AdminDAO" %>
<%@page import="com.DAO.AdminDAOImpl" %>
<%@page import="com.entity.AddBook" %>
<%@page import="com.entity.Order" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	 <%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: Orders</title>
<%@include file="allCss.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>
<h3 class="text-center"> Books Order</h3>

<c:if test="${not empty succMsg }">
<p class="text-center text-success">${succMsg}</p>
<c:remove var="succMsg" scope="session"/>
</c:if>
<c:if test="${not empty faildMsg }">
<p class="text-center text-danger">${faildMsg}</p>
<c:remove var="faildMsg" scope="session"/>
</c:if>
<table class="table table-striped">
  <thead class="bg-primary text-white">
    <tr>
     <th scope="col">ID</th>
      <th scope="col">Book ID</th>
      <th scope="col">Book Name</th>
      <th scope="col">Author</th>
       <th scope="col">Price</th>
    </tr>
  </thead>
  <tbody>
  
  <%
  AdminDAO dao = new AdminDAOImpl();
  List<Order> list = dao.getAllOrder();
  for(Order b:list)
  {
  %>
	
		  <tr>
		  <td><%=b.getId() %></td>
		   <td><%=b.getBid() %></td>
		  <td><%=b.getBookName() %></td>
		  <td><%=b.getAuthorName() %></td>
		   <td>Rs. <%=b.getPrice() %></td>
		 
		  
		</tr>

	<%  
  }
  %>
   
  </tbody>
</table>
<div style="margin-top:80px;">
<%@include file="footer.jsp" %>
</div>
</body>
</html>