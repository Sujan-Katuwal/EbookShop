<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	 <%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>

<%@include file="all_component/allCss.jsp"%>


<%@include file="all_component/navbar.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<body style="background-color: #f0f1f2;">
  <c:if test="${not empty succMsg }">
<p class="text-center text-success">${succMsg}</p>
<c:remove var="succMsg" scope="session"/>
</c:if>
<c:if test="${not empty faildMsg }">
<p class="text-center text-danger">${faildMsg}</p>
<c:remove var="faildMsg" scope="session"/>
</c:if>

<form method="get"action="/MyEbookShop/DownloadImageServlet">
    <input type="hidden" name="bookId" value="1" />
    <button type="submit"  class="btn btn-primary">Get Your Order</button>
</form>

  <%@include file ="all_component/footer.jsp" %>
</body>
</html>