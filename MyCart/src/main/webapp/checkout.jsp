<%
	User user=(User)session.getAttribute("current-user");
	
	if(user==null){
		session.setAttribute("message","You are not logged in!! Login first");
		response.sendRedirect("login.jsp");
		return;
	}

%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Checkout</title>
	<%@include file="common_css_js.jsp" %>
	<%@include file="common_modals.jsp" %>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	
	<div class="container">
		<div class="row mt-5">
			<div class="col-md-6">
			
				<!-- card -->
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-5">Your selected items</h3>
						<div class="cart-body">
						
						</div>
						
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<!-- user details -->
				<!-- card -->
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-5">Your details for order</h3>
						
						<form action="#!">
							<div class="form-group">
							    <label for="exampleInputEmail1">Email address</label>
							    <input value="<%=user.getUserEmail() %>" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
							    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
						  	</div>
						  	
						  	<div class="form-group">
							    <label for="exampleInputEmail1">Your Name</label>
							    <input value="<%=user.getUserName() %>" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">
						  	</div>
						  	
						  	<div class="form-group">
							    <label for="exampleInputEmail1">Your Contect</label>
							    <input value="<%=user.getUserPhone() %>" type="number" class="form-control" id="contect" aria-describedby="emailHelp" placeholder="Enter contect number">
						  	</div>
						  	
						  	<div class="form-group">
							    <label for="exampleFormControlTextarea1">Your shipping address</label>
							    <textarea value="<%=user.getUserAddress() %>" class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="Enter your address"></textarea>
						  	</div>
						  	
						  	<div class="contaier text-center">
						  		<button class="btn btn-outline-success">Order Now</button>
						  		<button class="btn btn-outline-primary">Continue Shopping</button>
						  	</div>
						</form>
						
					</div>
				</div>
				
			</div>
		</div>
	
	</div>
	
	
</body>
</html>