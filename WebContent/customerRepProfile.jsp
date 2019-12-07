<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demo | Customer Representative</title>
</head>
<body>
	<h1>Account</h1>
	<p>
	<%
	    if (session != null) {
	        if (session.getAttribute("name") != null) {
	        	String name = (String) session.getAttribute("name");
	        	out.print("Hello, " + name + ".  Welcome to your Profile!");
	        } else {
	        	response.sendRedirect("/servlet-demo/LoginServlet");
	        }
	    }
	    else {
	    	response.sendRedirect("/servlet-demo/LoginServlet");
	    }
	%>
	</p>
	<br>
	<form method="post" action="action.jsp">
		<select name="choice" size=1>
			<option value="addAirport.jsp">Airport</option>
			<option value="addAircraft.jsp">Aircraft</option>
			<option value="addFlight.jsp">Flight</option>
		</select>&nbsp;<br> <input type="submit" value="Add">
	</form>
	<br>
	<form method="post" action="action.jsp">
		<select name="choice" size=1>
			<option value="editAirport.jsp">Airport</option>
			<option value="editAircraft.jsp">Aircraft</option>
			<option value="editFlight.jsp">Flight</option>
		</select>&nbsp;<br> <input type="submit" value="Edit">
	</form>
	<br>
	<form method="post" action="action.jsp">
		<select name="choice" size=1>
			<option value="deleteAirport.jsp">Airport</option>
			<option value="deleteAircraft.jsp">Aircraft</option>
			<option value="deleteFlight.jsp">Flight</option>
		</select>&nbsp;<br> <input type="submit" value="Delete">
	</form>
	<br>
	<br>
	<input type="button" value="Log Out" onclick="window.location='/servlet-demo/logout.jsp'" >
</body>
</html>