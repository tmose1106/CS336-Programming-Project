<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demo | Edit Aircraft</title>
</head>
<body>
	<header>
		<a href="/servlet-demo/customerRepProfile.jsp">Account</a>
	</header>
	<h1>Edit Aircraft</h1>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="EditAircraftServlet" method="post"> 
    	<p>Please enter the ID of the Aircraft you want to modify</p> 
	    <label for="originalID"><b>Aircraft ID</b> (<font color="red">Required Integer</font>):</label>
	    <input type="number" step=1 name="originalID" pattern="\d+" required min=1>
	    <br>
	    <p><b><font color="green">Fields left empty will not be changed</font></b></p>
	    <p>Please enter the new ID of the Aircraft</p> 
	    <label for="aircraftID"><b>New Aircraft ID</b> (<font color="blue">Integer</font>):</label>
	    <input type="number" step=1 name="aircraftID" pattern="\d+" min=1>
	    <br>
    	<p>Please enter the new ID of the airline operating the aircraft</p> 
	    <label for="airlineID"><b>New Airline ID</b> (<font color="blue">char 2</font>):</label>
	    <input type="text" name="airlineID" minlength="2" maxlength="2">
	    <br>
	    <p>Please enter the number of seats to add or remove from the aircraft from each class: economy, business and first.
	    <br><font color="red">Note:</font> If there are no unassigned seats, customers will be moved to the wait list
	    so the seats can be removed.</p>
	    <label for="econSeats">Change # Economy Seats by:</label>
	    <input type="number" step=1 name="econSeats">
	    <br>
	    <label for="firstSeats">Change # First Class Seats by:</label>
	    <input type="number" step=1 name="firstSeats">
	    <br>
	    <label for="busiSeats">Change # Business Class Seats by:</label>
	    <input type="number" step=1 name="busiSeats">
	    <br>
	    <br>
	    <input type="submit" value="Edit Aircraft">
    </form>
</body>
</html>