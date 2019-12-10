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
    	<p>Please enter the Departure Airport for the flight</p>
    	<label for="departAirport"><b>Departure Airport</b> (<font color="red">Required char 3</font>):</label>
	    <input type="text" name="departAirport" required minlength="3" maxlength="3">
	    <br>
	    <p>Please enter the departure date and time. The time is 24 hour standard</p>
  		<label for="departDate">Date Time (<font color="red">YYYY/MM/DD HH:MI</font>): </label>
	    <input type="text" step=1 name="departDate" pattern="\d+" required minlength="16" maxlength="16">
	    <br>
	    <p>Please enter the Arrival Airport for the flight</p>
    	<label for="arrivalAirport"><b>Arrival Airport</b> (<font color="red">Required char 3</font>):</label>
	    <input type="text" name="arrivalAirport" required minlength="3" maxlength="3">
	    <br>
	    <p>Please enter the Arrival date and time. The time is 24 hour standard.</p>
  		<label for="arrivalDate">Date Time (<font color="red">YYYY/MM/DD HH:MI</font>): </label>
	    <input type="text" step=1 name="arrivalDate" pattern="\d+" required minlength="16" maxlength="16">
	    <br>
    	<p>Please enter the ID of the airline operating the flight</p> 
	    <label for="airlineID"><b>Airline ID</b> (<font color="red">Required char 2</font>):</label>
	    <input type="text" name="airlineID" required minlength="2" maxlength="2">
	    <br>
	    <p>Please enter the ID of the Flight</p> 
	    <label for="flightID"><b>Flight ID</b> (<font color="red">Required Integer</font>):</label>
	    <input type="number" step=1 name="flightID" pattern="\d+" required min=1>
	    <br>
	    <p><b>Please select the flight type</b></p>
	    <input type="radio" name="flightType" value="Domestic" checked/> Domestic
		<input type="radio" name="flightType" value="Internat"/> International
		<br>
		<p><b>Please check the operation days.</b></p>
		<input type="checkbox" name="mon" value="M">Monday
  		<input type="checkbox" name="tue" value="T">Tuesday 
  		<input type="checkbox" name="wed" value="W">Wednesday
  		<input type="checkbox" name="thur" value="Th">Thursday
  		<input type="checkbox" name="fri" value="F">Friday
  		<input type="checkbox" name="sat" value="S">Saturday
  		<input type="checkbox" name="sun" value="Su">Sunday
  		<br>
	    <p><b>Please enter the fare for the flight flight.</b></p>
	    <label for="fareEcon">Economy Fare(<font color="red">Required</font>):</label>
	    <input type="number" name="fareFirst" pattern="\d+" required min=0>
	    <br>
	    <label for="fareFirst">First Class Fare:</label>
	    <input type="number" name="fareFirst" pattern="\d+" min=0>
	    <br>
	    <input type="submit" value="Add Flight">
    </form>
</body>
</html>