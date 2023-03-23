package com.learn.mycart.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
			try {
				String userName=request.getParameter("user_name");
				String userEmail=request.getParameter("user_email");
				String userPassword=request.getParameter("user_password");
				String userPhone=request.getParameter("user_phone");
				String userAddress=request.getParameter("user_address");
				
				if(userName.isEmpty()) {
					out.println("Name is Empty!");
					return;
				}
				
				User user=new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress, "normal");
				Session hibernetSession=FactoryProvider.getFactory().openSession();
				Transaction tx=hibernetSession.beginTransaction();
				
				int userId=(Integer) hibernetSession.save(user);
				
				tx.commit();
				hibernetSession.close();
				
				HttpSession httpSession=request.getSession();
				httpSession.setAttribute("message", "Registration Sucessfully !! "+userId);
				response.sendRedirect("register.jsp");
			}
			catch(Exception e) {
				e.printStackTrace();
			}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request,response);
	}

}
