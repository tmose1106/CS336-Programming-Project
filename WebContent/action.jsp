<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demo | Add</title>
</head>
<body>
	<%
		String choice = request.getParameter("choice");
		response.sendRedirect("/servlet-demo/" + choice);
	%>
</body>
</html>