<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demo | Edit Airport</title>
</head>
<body>
	<header>
		<a href="/servlet-demo/customerRepProfile.jsp">Account</a>
	</header>
	<h1>Edit Airport</h1>
	<p><b>Fields left empty will not be changed</b></p>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="EditAirportServlet" method="post"> 
    	<p>Please enter the three letter code for the airport you want to modify</p>
    	<label for="originalID"><b>Current Airport Code</b> (<font color="red">Required 3 char</font>):</label>
	    <input type="text" name="originalID" required minlength="3" maxlength="3">
	    <br> 
	    <p>Please enter a three letter code for the airport</p>
	    <label for="airportID"><b>New Airport Code</b> (<font color="red">Required 3 char</font>):</label>
	    <input type="text" name="airportID" minlength="3" maxlength="3">
	    <br>
	    <p>Please enter the city of the airport</p>
	    <label for="city"><b>New City</b> (<font color="blue">Max 20</font>):</label>
	    <input type="text" name="city" maxlength="20">
	    <br>
	    <p>Please enter the state or province of the airport</p>
	    <label for="state"><b>New State or Province</b> (<font color="blue">Max 20</font>):</label>
	    <input type="text" name="state" maxlength="20">
	    <br>
	    <p>Please enter the three letter code for the country of the airport</p>
	    <label for="country"><b>New Country</b> (<font color="blue">Exactly 3</font>):</label>
	    <input type="text" name="country" minlength="3" maxlength="3">
	    <br>
	    <input type="submit" value="Edit Airport">
    </form>
</body>
</html>