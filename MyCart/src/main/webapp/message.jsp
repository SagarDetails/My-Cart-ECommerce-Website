<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<%@include file="common_css_js.jsp" %>
</head>
<body>

	<%
		String message=(String)session.getAttribute("message");
		if(message!=null){
			out.println(message);
			HttpSession httpSession=request.getSession();
			httpSession.removeAttribute("message");
		}
	%>


</body>
</html>