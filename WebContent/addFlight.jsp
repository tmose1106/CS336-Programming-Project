<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demo | Add Flight</title>
</head>
<body>
	<header>
		<a href="/servlet-demo/customerRepProfile.jsp">Account</a>
	</header>
	<h1>Add Flight</h1>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="AddFlightServlet" method="post"> 
    	<p>Please enter the ID of the airline operating the flight</p> 
	    <label for="airlineID"><b>Airline ID</b> (<font color="red">Required char 2</font>):</label>
	    <input type="text" name="airlineID" required minlength="2" maxlength="2">
	    <br>
	    <p>Please enter the ID of the Flight</p> 
	    <label for="flightID"><b>Flight ID</b> (<font color="red">Required Integer</font>):</label>
	    <input type="number" step=1 name="flightID" pattern="\d+" required min=1>
	    <br>
	    <p>Please enter the number of economy, business and first class seats.
	    Note the flight must have at least one seat</p>
	    <label for="econSeats"># Economy Seats (<font color="blue"> > 0</font>):</label>
	    <input type="number" step=1 name="econSeats" pattern="\d+" min=1>
	    <br>
	    <label for="firstSeats"># First Class Seats (<font color="blue"> > 0</font>)</label>
	    <input type="number" step=1 name="firstSeats" pattern="\d+ " min=1>
	    <br>
	    <label for="busiSeats"># Business Class Seats (<font color="blue"> > 0</font>)</label>
	    <input type="number" step=1 name="busiSeats" pattern="\d+" min=1>
	    <br>
	    <br>
	    <input type="submit" value="Add Flight">
    </form>
</body>
</html>