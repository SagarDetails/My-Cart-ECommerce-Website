package com.learn.mycart.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
			try {
				
//				Servlet-2:
//				1. Add Category
//				2. Add Product
				String op=request.getParameter("operation");
				
				if(op.trim().equals("addcategory")) {
					//1. Add Category
					//Faching Catogery data
					String title=request.getParameter("catTitle");
					String description=request.getParameter("catDescription");
					
					Category category=new Category();
					category.setCategoryTitle(title);
					category.setCategoryDescription(description);
					
					CategoryDao categoryDao=new CategoryDao(FactoryProvider.getFactory());
					int categoryId=categoryDao.saveCategory(category);
					
					HttpSession httpSession=request.getSession();
					httpSession.setAttribute("message", "Category Added Successfully: "+categoryId);
					response.sendRedirect("admin.jsp");
					
					return;
				}else if(op.trim().equals("addproduct")) {
					//2. Add Product
					String pName=(String) request.getParameter("pName");
					String pDesc=(String) request.getParameter("pDesc");
					int pPrice=Integer.parseInt(request.getParameter("pPrice"));
					int pDiscount=Integer.parseInt(request.getParameter("pDiscount"));
					int pQuantity=Integer.parseInt(request.getParameter("pQuantity"));
					int pCategoryId=Integer.parseInt(request.getParameter("catId"));
//					String pString=request.getParameter("pPic");
//					System.out.println("Pic: "+pString);
					Part part=request.getPart("pPic");
					System.out.println(part.getSubmittedFileName());
					
					Product product=new Product();
					product.setProductName(pName);
					product.setProductDescription(pDesc);
					product.setProductPrice(pPrice);
					product.setProductDiscount(pDiscount);
					product.setProductQuantity(pQuantity);
					
					CategoryDao categoryDao=new CategoryDao(FactoryProvider.getFactory());
					Category category=categoryDao.getCategoryById(pCategoryId);
					
					product.setCategory(category);
					
					product.setProductPic(part.getSubmittedFileName());
					
					
					ProductDao productDao=new ProductDao(FactoryProvider.getFactory());
					int productId=productDao.saveProduct(product);
					
//					String path=request.getRealPath("img")+File.separator+"products"+File.separator+part.getSubmittedFileName();
//					System.out.println(path);
//					
//					FileOutputStream fileOutputStream=new FileOutputStream("C:\\Users\\LENOVO\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\MyCart\\img\\products\\C:UsersLENOVODesktopAlexandra Daddario Cuit Picswallpaperflare.com_wallpaper.jpg");
//					System.out.println("After path...");
//					InputStream inputStream=part.getInputStream();
//					
//					byte []data=new byte[inputStream.available()];
//					System.out.println("After data decleration...");
//					fileOutputStream.write(data);
//					fileOutputStream.close();
//					System.out.println("After fileOutputStream closed...");
//					
////					C:\Users\LENOVO\eclipse-workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\MyCart\img
//					int productId=1;
					
					HttpSession httpSession=request.getSession();
					httpSession.setAttribute("message", "Product Added Successfully: "+productId);
					response.sendRedirect("admin.jsp");
					
				}
				
				
			}
			catch(Exception e) {
				e.printStackTrace();
			}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
