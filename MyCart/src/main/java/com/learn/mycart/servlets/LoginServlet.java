package com.learn.mycart.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.learn.mycart.dao.UserDao;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
			try {
				String email=(String)request.getParameter("email");
				String password=(String)request.getParameter("password");
				UserDao userDao=new UserDao(FactoryProvider.getFactory());
				User user=userDao.getUserByEmailAndPassword(email, password);
//				System.out.println(user);
				HttpSession httpSession=request.getSession();
				if(user==null) {
					httpSession.setAttribute("message","Invalid Details!! Try with another one");
					response.sendRedirect("login.jsp");
					return;
				}
				else {
					out.print("<h1> Welcome "+user.getUserName()+" </h1>");
					
					httpSession.setAttribute("current-user", user);
					if(user.getUserType().equals("admin")) {
						//admin:- admin.jsp
						response.sendRedirect("admin.jsp");
					}else if(user.getUserType().equals("normal")) {
						//normal:- normal.jsp
						response.sendRedirect("normal.jsp");
					}else {
						out.println("We not indentify user type!!");
					}
					
					
					
					
				}
				
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
		processRequest(request, response);
	}

}
