package com.user.servlet;

import java.io.IOException;

import com.DAO.UserDAO;
import com.DAO.UserDAOImpl;
import com.entity.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/paymentServlet")
public class PaymentServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		    int bid = Integer.parseInt(request.getParameter("bid"));
			String bname = request.getParameter("bname");
			String author = request.getParameter("author");
			double price = Double.parseDouble(request.getParameter("price"));
			
			Order order = new Order();
			order.setBid(bid);
			order.setBookName(bname);
			order.setAuthorName(author);
			order.setPrice(price);
			
			HttpSession session = request.getSession();
			 UserDAO userDao = new UserDAOImpl();
			 if(userDao.payment(order)) {
				 session.setAttribute("succMsg", "Order Success");
			        response.sendRedirect("downloadBook.jsp");
			        System.out.println("Payment Success");			 }
			 else {
		        	session.setAttribute("faildMsg", "Order Faild, Something Wrong on Server !!!");
		        	response.sendRedirect("downloadBook.jsp");
		        	 System.out.println("Payment faild");		
		        }
			
		}
		catch (Exception e) {
			
			e.printStackTrace();
		}
}
}
