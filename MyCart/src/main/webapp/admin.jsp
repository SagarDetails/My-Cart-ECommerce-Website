<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>
<%
	User user=(User)session.getAttribute("current-user");
	
	if(user==null){
		session.setAttribute("message","You are not logged in!! Login first");
		response.sendRedirect("login.jsp");
		return;
	}else{
		if(user.getUserType().equals("normal")){
			session.setAttribute("message","You are not an admin!! Do not access this page");
			response.sendRedirect("login.jsp");
			return;
		}
	}
%>

<!-- Fatching Categories -->
<%
	CategoryDao categoryDao=new CategoryDao(FactoryProvider.getFactory());
	List<Category> categoryList=categoryDao.getCategories();
%>

<%
	Map<String, Long> map=Helper.getCounts(FactoryProvider.getFactory());
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Admin Panel</title>
	<%@include file="common_css_js.jsp" %>
	<%@include file="common_modals.jsp" %>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	
	<div class="container admin">
	
	<div class="container- fluid mt-3">
		<%@ include file="message.jsp" %>
	</div>
	
	
		<div class="row mt-3">
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
					
						<div class="container">
							<img style="max-width: 124;" class="image-fluid rounded-circle" src="img/user.png" alt="user_icon">
						</div>
						
						<h1><%=map.get("userCount") %></h1>
						<h1 class="text-uppercase text-muted">User</h1>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
					
						<div class="container">
							<img style="max-width: 124;" class="image-fluid rounded-circle" src="img/list.png" alt="list_icon">
						</div>
						
						<h1><%=categoryList.size() %></h1>
						<h1 class="text-uppercase text-muted">Categories</h1>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
					
						<div class="container">
							<img style="max-width: 124;" class="image-fluid rounded-circle" src="img/product.png" alt="product_icon">
						</div>
					
						<h1><%=map.get("productCount") %></h1>
						<h1 class="text-uppercase text-muted">Products</h1>
					</div>
				</div>
			</div>
		
		</div>
		
		
		
		<div class="row mt-3">
			<div class="col-md-6" data-toggle="modal" data-target="#add-category-model">
				<div class="card">
					<div class="card-body text-center">
					
						<div class="container">
							<img style="max-width: 124;" class="image-fluid rounded-circle" src="img/keys.png" alt="keys_icon">
						</div>
						
						<p class="mt-2">Click here to add new category</p>
						<h1 class="text-uppercase text-muted">Add Category</h1>
					</div>
				</div>
			</div>
			<div class="col-md-6" data-toggle="modal" data-target="#add-product-model">
				<div class="card">
					<div class="card-body text-center">
					
						<div class="container">
							<img style="max-width: 124;" class="image-fluid rounded-circle" src="img/plus.png" alt="plus_icon">
						</div>
						
						<p class="mt-2">Click here to add new product</p>
						<h1 class="text-uppercase text-muted">Add Product</h1>
					</div>
				</div>
			</div>
		
		</div>
		
	</div>
	
<!-- 	Add Catogery Model -->

	<!-- Modal -->
	<div class="modal fade" id="add-category-model" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog model-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header custom-bg text-white">
	        <h5 class="modal-title" id="exampleModalLabel">Fill Category details</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        
	        <form action="ProductOperationServlet" method="post">
	        	<input type="hidden" name="operation" value="addcategory">
	        
	        	<div class="form-group">
	        		<input type="text" class="form-control" name="catTitle" placeholder="Enter Category title">
	        	</div>
	        	<div class="form-group">
	        		<textarea style="height: 250px" class="form-control" placeholder="Enter Category description" name="catDescription" required></textarea>
	        	</div>
	        	<div class="container text-center">
	        		<button class="btn btn-outline-success">Add Category</button>
	        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        	</div>
	        </form>
	        
	      </div>
	   
	    </div>
	  </div>
	</div>

<!-- 	End Catogery Model -->

<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<!-- Start Product Model -->

	<!-- Modal -->
	<div class="modal fade" id="add-product-model" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Product details</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
			<!-- Form -->
			
	        	<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
	        	
	        		<input type="hidden" name="operation" value="addproduct">
	        	
	        		<div class="form-group">
	        			<input type="text" class="form-control" name="pName" placeholder="Enter product title" required>
	        		</div>
	        		
	        		<div class="form-group">
	        			<textarea style="height: 150px;" type="text" class="form-control" name="pDesc" placeholder="Enter product descrition"></textarea>
	        		</div>
	        		
	        		<div class="form-group">
	        			<input type="number" class="form-control" name="pPrice" placeholder="Enter product price" required>
	        		</div>
	        		
	        		<div class="form-group">
	        			<input type="number" class="form-control" name="pDiscount" placeholder="Enter product discount" required>
	        		</div>
	        		
	        		<div class="form-group">
	        			<input type="number" class="form-control" name="pQuantity" placeholder="Enter product quantity" required>
	        		</div>
	        		
	        		
					
	        		
	        		<div class="form-group">
	        			<select name="catId" class="form-control">
	        				<%
	        					for(Category category:categoryList){
	        				%>
	        			
	        				<option value="<%=category.getCategoryId() %>"><%=category.getCategoryTitle() %></option>
	        				
	        				<%
	        					}
	        				%>
	        			</select>
	        		</div>
	        		
	        		<div class="form-group">
	        			<label for="pPic">Select picture for product</label>
	        			<br>
	        			<input type="file" id="pPic" name="pPic" required>
	        		</div>
	        		
	        		<div class="container text-center">
	        			<button class="btn btn-outline-success">Add product</button>
	        		</div>
	        	</form>
	        
	        <!-- End Form -->
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>

<!-- End Product Model -->



</body>
</html>