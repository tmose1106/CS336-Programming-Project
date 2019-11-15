<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo| Logout</title>
</head>
<body>
	<% session.invalidate(); %>
	<p>You have been logged out.</p>
	<p>Click "Home" to go to Home Page</p>
	<button><a href="/servlet-demo">Home</a></button> 
</body>
</html>