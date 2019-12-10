<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Profile</title>
</head>
<body>
	<p>
	<%
	    if (session != null) {
	        if (session.getAttribute("name") != null) {
	        	String name = (String) session.getAttribute("name");
	        	out.print("Hello, " + name + ".  Welcome to your Profile!");
	        } else {
	        	response.sendRedirect("/LoginServlet");
	        }
	    }
	    else {
	    	response.sendRedirect("/LoginServlet");
	    }
	%>
	</p>
	<input type="button" value="Log Out" onclick="window.location='/servlet-demo/logout.jsp'" >
</body>
</html>