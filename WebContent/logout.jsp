<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo| Logout</title>
</head>
<body>
	<header>
		<a href="/">Home</a>
	</header>
	<% session.invalidate(); %>
	<p>You have been logged out.</p>
</body>
</html>