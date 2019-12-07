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
		<a href="/servlet-demo/">Home</a>
	</header>
	<% session.invalidate(); %>
	<p>You have been logged out.</p>
	<input type="button" value="Home" onclick="window.location='/servlet-demo/'" >
</body>
</html>