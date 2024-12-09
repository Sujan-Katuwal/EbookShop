<%@page import="com.DAO.UserDAOImpl" %>
<%@page import="com.DAO.UserDAO" %>
<%@page import="com.entity.AddBook" %>
<%@page import="com.entity.User" %>
<%@ page import="java.util.UUID" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	 <%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<%@include file="all_component/allCss.jsp"%>
<body style="background-color: #f0f1f2;">

<%@include file="all_component/navbar.jsp"%>
	
  <h3 class=" text-primary">Make a Payment</h3>
  
  <c:if test="${not empty succMsg }">
<p class="text-center text-success">${succMsg}</p>
<c:remove var="succMsg" scope="session"/>
</c:if>
<c:if test="${not empty faildMsg }">
<p class="text-center text-danger">${faildMsg}</p>
<c:remove var="faildMsg" scope="session"/>
</c:if>

  <%
  String bidStr = request.getParameter("bid");
 
  // Convert bid from String to int and handle potential NumberFormatException
  int bid = 0;
  try {
      bid = Integer.parseInt(bidStr);
  } catch (NumberFormatException e) {
      out.println("Error: Invalid book ID.");
      return; // Exit if book ID is invalid
  }
  
        // Generate a unique PID using UUID
        String uniquePid = UUID.randomUUID().toString();
   
    UserDAOImpl dao = new UserDAOImpl();
	AddBook addbook = dao.getBookById(bid);
	
	
	
	
	%>

	
     <form action ="<%= request.getContextPath() %>/paymentServlet" method="post">
     
     <div class="card w-50 mb-2 text-center">
  <div class="card-body">
  <div class="form-group">
  <input type="hidden" name="bid" value="<%= addbook.getBookId() %>">
  </div>
       <div class="form-group">
    <label for="exampleInputEmail1">Book Name</label>
    <input type="text" name="bname" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"  value="<%= addbook.getBookName()%>">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Author</label>
    <input type="text" name="author" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"  value="<%= addbook.getAuthorName()%>">
  </div>
    <div class="form-group">
    <label for="exampleInputEmail1">Book Price</label>
    <input type="text" name="price" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"  value="<%= addbook.getPrice()%>">
  </div>
 
    
    <button type="submit" class="btn btn-primary">Order</button><br>
  </div>
</div>
  </form>

	
	 <div class="card w-50 mb-2 text-center">
  <div class="card-body">
  <form action="https://uat.esewa.com.np/epay/main" method="POST">
        <input type="hidden" name="amt" value="<%=addbook.getPrice()%>"> <!-- Product amount -->
        <input type="hidden" name="txAmt" value="0"> <!-- Tax amount -->
        <input type="hidden" name="psc" value="0"> <!-- Service charge -->
        <input type="hidden" name="pdc" value="0"> <!-- Delivery charge -->
        <input type="hidden" name="tAmt" value="<%=addbook.getPrice()%>"> <!-- Total amount -->
        <input type="hidden" name="pid" value="<%= uniquePid %>"> <!-- Unique product ID generated -->
        <input type="hidden" name="scd" value="EPAYTEST"> <!-- eSewa merchant code -->
        <input type="hidden" name="su" value="http://localhost:8080/MyEbookShop/success"> <!-- Success URL -->
        <input type="hidden" name="fu" value="http://localhost:8080/MyEbookShop/failure"> <!-- Failure URL -->

       
         
        <button type="submit"  class="btn btn-primary">Pay with eSewa</button>
       
   </form>
   </div>
</div>
    
    
    
    <%@include file ="all_component/footer.jsp" %>
</body>
</html>