<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>New User</title>
	<%@include file="common_css_js.jsp" %>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<div class="container-fluid">
		<div class="row mt-5">
			<div class="col-md-4 offset-md-4">
				<div class="card">
<%-- 				<%@ include file="message.jsp" %> --%>
					<div class="card-body px-5">
						<div class="container text-center">
							<img src="https://www.pngkey.com/png/detail/673-6734073_sign-up-icon-png.png" alt="Sign Up Icon Png@pngkey.com" style="max-weidth: 100px; max-height: 100px;">
						</div>
						<h3 class="text-center my-3">Sign up here !!</h3>
						<form action="registerServlet" method="post">
							<div class="form-group">
							    <label for="name"> User Name</label>
							    <input name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter here">
						  	</div>
						  	
						  	<div class="form-group">
							    <label for="email"> User Email</label>
							    <input name="user_email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter here">
						  	</div>
						  	
						  	<div class="form-group">
							    <label for="password"> User Password</label>
							    <input name="user_password" type="password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter here">
						  	</div>
						  	
						  	<div class="form-group">
							    <label for="phone"> User Phone</label>
							    <input name="user_phone" type="number" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter here">
						  	</div>
						  	
						  	<div class="form-group">
							    <label for="address"> User Address</label>
								<textarea name="user_address" style="height: 200px;" class="form-control" placeholder="Enter you address"></textarea>    
							</div>
							
							<div class="cotainer text-center">
								<button class="btn btn-outline-success">Register</button>
								<button class="btn btn-outline-warning">Reset</button>
							</div>
						</form>
					
					</div>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>