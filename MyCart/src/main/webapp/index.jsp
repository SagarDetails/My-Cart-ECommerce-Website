<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="com.learn.mycart.entities.User"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
	<title>My Cart - Home</title>
	<%@include file="common_css_js.jsp" %>
	<%@include file="common_modals.jsp" %>
<!-- 	<link rel="stylesheet" type="text/css" href="style.css"> -->
</head>
<body>
	<%@ include file="navbar.jsp" %>
<!-- 	<h2>Hello World!</h2> -->
<!-- 	<h3>Creating Session Factory</h3> -->

	<div class="row mt-3 mx-2">
	<%
		String catId=request.getParameter("category");
		System.out.println("before categoryDao");
		
		CategoryDao categoryDao=new CategoryDao(FactoryProvider.getFactory());
		System.out.println("after categoryDao");
		
		List<Category> categories=categoryDao.getAllCategories();
	
		ProductDao productDao=new ProductDao(FactoryProvider.getFactory());
		List<Product> products=productDao.getAllProducts();
		
		System.out.println("before if...  ");
		System.out.println(catId);
		if(catId!=null){
			System.out.println(catId.equals("all"));
			System.out.println(catId.equals(null));
			if(catId.equals("all")){
				System.out.println("in if...  ");
				products=productDao.getAllProducts();
			}else{
				System.out.println("in else if...  ");
				if(catId!=null && catId!="all"){
					int categoryId=Integer.parseInt(catId.trim());
					products=productDao.getProductsByCatId(categoryId);
				}else{
					System.out.println("Category is null");
				}
			}
		}
	%>
	
<!-- 		fatching categoryes -->
		<div class="col-md-4">
			<div class="list-group">
				<a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
			    	All Products
			  	</a>
			<%
				for(Category category:categories){
			%>
			<a href="index.jsp?category=<%=category.getCategoryId() %>" class="list-group-item list-group-item-action"><%=category.getCategoryTitle() %></a>
			<%
				}
			%>
			</div>
			
		</div>
		
<!-- 		facthing products -->
		<div class="col-md-8">
			
			<div class="row">
			
				<div class="col-md-12">
					
					<div class="card-columns">
				
						<%
							for(Product product:products){
										
						%>
							<div class="card product-card">
								<div class="container">
									<img alt="<%=product.getProductPic() %>" class="card-img-top" src="">
								</div>
								<div class="card-body">
								
									<h3 class="card-title"><%=product.getProductName() %></h3>
									<p class="card-text">
										<%=Helper.get10Words(product.getProductDescription()) %>
									</p>
								</div>
								
								<div class="card-footer text-center">
									<button class="btn custom-bg text-white" onclick="add_to_cart(<%=product.getProductId()%>,'<%=product.getProductName()%>',<%=product.getPriceAfterApplyingDiscount() %>)">Add to Cart</button>
									<button class="btn btn-outline-primary"> &#8377; <%=product.getPriceAfterApplyingDiscount() %>/- <span class="text-secondary discount-label">&#8377;<%=product.getProductPrice() %>, <%=product.getProductDiscount()%>% off</span></button>
								</div>
							
							</div>
							
							
							<script>
								function add_to_cart(pId,pName,pPrice){
									let cart=localStorage.getItem("cart");
									if(cart==null){
										let products=[];
										let product={productId: pId, productName: pName, productQuantity: 1, productPrice: pPrice}
										products.push(product);
										localStorage.setItem("cart", JSON.stringify(products));
										console.log("Product is added for the first time!");
									}else{
										
										let pCart=JSON.parse(cart);
										let oldProduct=pCart.find((item)=> item.productId==pId);
										if(oldProduct){
											
											oldProduct.productQuantity=oldProduct.productQuantity+1;
											pCart.map((item)=>{
												if(item.productId==oldProduct.productId){
													item.productQuantity=oldProduct.productQuantity;
												}
											})
											localStorage.setItem("cart", JSON.stringify(pCart));
											console.log("Product quantity is increased!");
											
										}else{
											let product={productId: pId, productName: pName, productQuantity: 1, productPrice: pPrice}
											pCart.push(product);
											localStorage.setItem("cart", JSON.stringify(pCart));
											console.log("Product is added!");
											
										}
										
									}
									updateCart();
								}
								
								
								
								function updateCart(){
									console.log("This is updateCart function...");
									let cartString=localStorage.getItem("cart");
									let cart=JSON.parse(cartString);
									if(cart==null || cart.length==0){
										console.log("Cart is empty!!");
										$(".cart-item").html("(0)");
										$(".cart-body").html("<h3>Cart does not have any item</h3>");
										$(".checkout-btn").attr('disabled',true);
										
									}
									else{
										console.log("This is else part");
										console.log(cart);
										$(".cart-item").html('('+cart.length+')');
										
										let table=`
											<table class="table">
												<thead class="thread-light">
													<tr>
														<th>Item Name</th>
														<th>Price</th>
														<th>Quantity</th>
														<th>Total Price</th>
														<th>Action</th>
													</tr>
												</thead>
										`;
										
										cart.map((item)=>{
											
											table+=
													`<tr>
														<td>\${item.productName}</td>
														<td>\${item.productPrice}</td>
														<td>\${item.productQuantity}</td>
														<td>\${item.productPrice*item.productQuantity}</td>
														<td><button onclick="removeItemFromCart(\${item.productId})" class='btn btn-danger btn-sm'>Remove</button></td>
													</tr>`
													
													
										})
										
										table=table+`</table>`
										$(".cart-body").html(table);
										$(".checkout-btn").attr('disabled',false);
									}
									
								}
								
								
								function removeItemFromCart(pId){
									let cart=JSON.parse(localStorage.getItem("cart"));
									let newCart=cart.filter((item)=>item.productId!=pId);
									localStorage.setItem("cart", JSON.stringify(newCart));
									updateCart();
								}
								
								function goToCheckOut(){
									window.location="checkout.jsp";
								}
								
								
								$(document).ready(function(){
									updateCart();
								})
								
							</script>
							
							
						<%
							}
							if(products.size()==0){
								out.println("<h3>No item in this category</h3>");
							}
						%>
					</div>
				</div>
			
			</div>
			
			
			
		</div>
	
	</div>

	
	<%
// 		out.println(FactoryProvider.getFactory()+"<br>");
// 		out.println(FactoryProvider.getFactory()+"<br>");
// 		out.println(FactoryProvider.getFactory());
// 		User user1=new User();
// 		Session session1=FactoryProvider.getFactory().openSession();
// 		Transaction tx=session1.beginTransaction();
// 		session1.save(user1);
// 		tx.commit();
		
		

	%>
	
</body>
</html>
