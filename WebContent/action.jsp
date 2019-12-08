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
		String command = request.getParameter("command");
		response.sendRedirect("/servlet-demo/" + command + choice);
	%>
</body>
</html>