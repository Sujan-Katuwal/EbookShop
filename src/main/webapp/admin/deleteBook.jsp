<%@page import="com.DAO.UserDAOImpl" %>
<%@page import="com.entity.AddBook" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
   
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	 <%@page isELIgnored="false" %>
	 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Book Page</title>
<%@include file="allCss.jsp" %>
</head>
<body style="background-color: #f0f1f2;">
<%@include file="navbar.jsp" %>

<div class="container">
<div class="row">
<div class="col-md-4 offset-md-4">
<div class="card">
<div class="card-body">
<h4 class="text-center">Delete Book</h4>

  <c:if test="${not empty succMsg }">
<p class="text-center text-success">${succMsg}</p>
<c:remove var="succMsg" scope="session"/>
</c:if>
<c:if test="${not empty faildMsg }">
<p class="text-center text-danger">${faildMsg}</p>
<c:remove var="faildMsg" scope="session"/>
</c:if>


<%
String myid = request.getParameter("id");
int id = Integer.parseInt(myid);
UserDAOImpl dao = new UserDAOImpl();
AddBook b = dao.getBookById(id);
%>
<form action="../deleteBookServlet" method="post">
  <div class="form-group">
  <input type="hidden" name="Bid" value="<%=b.getBookId() %>">
    <label for="exampleInputEmail1">Book Name</label>
    <input type="text" name="bname" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" value="<%=b.getBookName() %>">
  </div>
    <div class="form-group">
    <label for="exampleInputEmail1">Author Name</label>
    <input type="text" name="author" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"  value="<%=b.getAuthorName() %>">
  </div>
    <div class="form-group">
    <label for="exampleInputEmail1">Price</label>
    <input type="number" name="price" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"  value="<%=b.getPrice() %>">
  </div>
  


<div class="form-groupl">
<label for="inputState">Book Status</label>
<select id="inputState" name="status" class="form-control">
<%if("Active".equals(b.getBookStatus())){
	%>
	
  <option value="Active">Active</option>
  <option value="Inactive">Inactive</option>
	
	<% 
}else{
%>
  <option value="Inactive">Inactive</option>
   <option value="Active">Active</option>
<%}%>

  </select>
</div>

  <button type="submit" class="btn btn-primary">Delete</button>
  

</form>


</div>
</div>
</div>
</div>
</div>
<div style="margin-top:80px;">
<%@include file="footer.jsp" %>
</div>
</body>
</html>