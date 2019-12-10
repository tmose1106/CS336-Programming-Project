<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demo | Delete Aircraft</title>
</head>
<body>
	<header>
		<a href="/servlet-demo/customerRepProfile.jsp">Account</a>
	</header>
	<h1>Delete Aircraft</h1>
	<p>Please enter the integer id of the aircraft you want to delete</p>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="DeleteAircraftServlet" method="post">  
	    <label for="aircraftID"><b>Aircraft ID</b> (<font color="red">integer > 0</font>):</label>
		<input type="number" step=1 name="aircraftID" pattern="\d+" required min=1>
	    <p>Enter the code again to confirm</p>
	    <label for="confirm"><b>Confirm Code</b> (<font color="red">integer > 0</font>):</label>
	    <input type="number" step=1 name="confirm" pattern="\d+" required min=1>
	    <br>
	    <br>
	    <input type="submit" value="Delete">
	    </form>
</body>
</html>