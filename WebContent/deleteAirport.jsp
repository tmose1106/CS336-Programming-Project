<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demo | Delete Airport</title>
</head>
<body>
	<header>
		<a href="/servlet-demo/customerRepProfile.jsp">Account</a>
	</header>
	<h1>Delete Airport</h1>
	<p>Please enter the three letter code for the airport you want to delete</p>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="DeleteAirportServlet" method="post">  
	    <label for="airportID"><b>Airport Code</b> (<font color="red">3 char</font>):</label>
	    <input type="text" name="airportID" required minlength="3" maxlength="3">
	    <p>Enter the code again to confirm</p>
	    <label for="confirm"><b>Confirm Code</b> (<font color="red">3 char</font>):</label>
	    <input type="text" name="confirm" required minlength="3" maxlength="3">
	    <br>
	    <br>
	    <input type="submit" value="Delete">
	    </form>
</body>
</html>