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
	        	out.print("Hello, " + name + ",  welcome to your Profile!");
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
	<p><b>Make or Edit a Reservation for a Customer</b></p>
	<form method="post" action="ReservationServlet">
		<p> Please Select whether you want to make or edit as reservation and indicate the user the reservation is for.</p>
		<input type="radio" name="command" value="make"/> Make
		<input type="radio" name="command" value="edit"/> Edit
		<br>
		<label for="userID">User ID:</label>
	    <input type="text" name="userID" required maxlength="20">
	    <br>
		<input type="submit" value="Go">
	</form>
	<br>
	<p><b>Retrieve Wait-list for a Flight</b></p>
	<form method="post" action="WaitListServlet">
		<label for="flightID">Flight ID:</label>
	    <input type="number" step=1 name="flightID" pattern="\d+" required min=1>
	    <input type="submit" value="Go">
	</form>
	<br>
	<p><b>Manipulate the Database</b></p>
	<form method="post" action="action.jsp">
		<p>Please select what part of the database you want to change and how you want to change it<p>
		<select name="choice" size=1>
			<option value="Aircraft.jsp">Aircraft</option>
			<option value="Airport.jsp">Airport</option>
			<option value="Flight.jsp">Flight</option>
		</select>&nbsp;<br> <input type="radio" name="command" value="add" checked/> Add
		<input type="radio" name="command" value="edit"/> Edit
		<input type="radio" name="command" value="delete"/> Delete
		<br>
		<input type="submit" value="Go">
	</form>
	<br>
	<br>
	<input type="button" value="Log Out" onclick="window.location='/servlet-demo/logout.jsp'" >
</body>
</html>