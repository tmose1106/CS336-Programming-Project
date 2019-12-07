<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demo | Add Airport</title>
</head>
<body>
	<header>
		<a href="/servlet-demo/customerRepProfile.jsp">Account</a>
	</header>
	<h1>Add Airport</h1>
	<p>Please enter a three letter code for the airport</p>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="AddAirportServlet" method="post">  
	    <label for="airportID"><b>Airport Code</b> (<font color="red">Required 3 char</font>):</label>
	    <input type="text" name="airportID" required minlength="3" maxlength="3">
	    <br>
	    <p>Please enter the city of the airport</p>
	    <label for="city"><b>City</b> (<font color="blue">Max 20</font>):</label>
	    <input type="text" name="city" maxlength="20">
	    <br>
	    <p>Please enter the state or province of the airport</p>
	    <label for="state"><b>State or Province</b> (<font color="blue">Max 20</font>):</label>
	    <input type="text" name="state" maxlength="20">
	    <br>
	    <p>Please enter the three letter code for the country of the airport</p>
	    <label for="country"><b>Country</b> (<font color="blue">Exactly 3</font>):</label>
	    <input type="text" name="country" minlength="3" maxlength="3">
	    <br>
	    <input type="submit" value="Add Airport">
    </form>
</body>
</html>