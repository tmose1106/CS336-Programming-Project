<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="cs336.DatabaseUtil"%>

<%!
Connection connection = null;
PreparedStatement flights_ps = null;
PreparedStatement customer_ps = null;
PreparedStatement best_customer_ps = null;
PreparedStatement active_flights_ps = null;
PreparedStatement airport_ps = null;
%>

<%
connection = DatabaseUtil.getConnection();

flights_ps = connection.prepareStatement("SELECT * FROM flights;");
ResultSet flights_rs = flights_ps.executeQuery();

customer_ps = connection.prepareStatement("SELECT * FROM users WHERE user_type = 'C';");
ResultSet customer_rs = customer_ps.executeQuery();

best_customer_ps = connection.prepareStatement("SELECT user_name, SUM(booking_fee) FROM tickets GROUP BY user_name ORDER BY SUM(booking_fee) DESC LIMIT 1;");
ResultSet best_customer_rs = best_customer_ps.executeQuery();

active_flights_ps = connection.prepareStatement("SELECT airline_id, flight_num, COUNT(*) FROM trips GROUP BY airline_id, flight_num ORDER BY COUNT(*) LIMIT 5;");
ResultSet active_flights_rs = active_flights_ps.executeQuery();

airport_ps = connection.prepareStatement("SELECT * FROM airports;");
ResultSet airport_rs = airport_ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Admin Profile</title>
</head>
<body>

	<p>
	<%
	if (session != null) {
		if (session.getAttribute("name") != null) {
			String name = (String) session.getAttribute("name");
			out.print("Hello, " + name + ".  This is your admin profile.");
		}
		else {
			response.sendRedirect("/LoginServlet");
		}
	}
	else {
		response.sendRedirect("/LoginServlet");
	}
	%>
	</p>
	
	<p>
	<input type="button" value="Refresh" onclick="window.location='/servlet-demo/admin-profile.jsp'">
	<input type="button" value="Log Out" onclick="window.location='/servlet-demo/logout.jsp'">
	</p>
	
	<h4>Customer Representatives</h4>
	<h3>TBD</h3>
	<!-- Add New Representative -->
	<!-- Delete Representative -->
	<!-- Edit Representative -->
	
	<h4>Customers</h4>
	<h3>TBD</h3>
	<!-- Add New Customer -->
	<!-- Delete Customer -->
	<!-- Edit Customer -->
	
	<h4>View Sales Report</h4>
	<h3>TBD</h3>
	<!-- View sales by customer representative -->
	<!-- View sales by customer -->
	
	<h4>List Reservations</h4>
	
	<h5>For a Flight</h5>
	<form action="reservations-flights.jsp">
	<select name="flight_info">
		<%while (flights_rs.next()){%>
			<option value="<%=flights_rs.getString("airline_id")%> <%=flights_rs.getString("flight_num")%>"><%=flights_rs.getString("airline_id")%> <%=flights_rs.getString("flight_num")%></option>
    	<%}%>
    </select>
    <input type="submit" value="Submit">
	</form>
    
    <h5>For a Customer</h5>
	<form action="reservations-customer.jsp">
	<select name="customer">
		<%while (customer_rs.next()){%>
			<option value="<%=customer_rs.getString("user_name")%>"><%=customer_rs.getString("person_name")%> (<%=customer_rs.getString("user_name")%>)</option>
    	<%}%>
    </select>
    <input type="submit" value="Submit">
	</form>
	
	<h4>View Revenue</h4>
	<h3>TBD</h3>
	<!-- Select Flight -->
	<!-- Select Airline -->
	<!-- Select Customer -->
	
	<h4>Identify Customer that Generated Most Total Revenue</h4>
	<p>
		<%best_customer_rs.next();%>
		<%=best_customer_rs.getString("user_name")%>
		<%=best_customer_rs.getString("SUM(booking_fee)")%>
	</p>
	
	<h4>Most Active Flights</h4>
	<table>
		<thead>
			<tr>
				<th>Airline</th>
				<th>Flight Number</th>
				<th>Number of Tickets</th>
			</tr>
		</thead>
		<tbody>
			<%while (active_flights_rs.next()) {%>
			<tr>
				<td><%=active_flights_rs.getString("airline_id")%></td>
				<td><%=active_flights_rs.getString("flight_num")%></td>
				<td><%=active_flights_rs.getString("COUNT(*)")%></td>
			</tr>
			<%}%>
		</tbody>
	</table>
	
	<h4>View Flights for an Airport</h4>
	<form action="flights-per-airport.jsp">
	<select name="airport_id">
		<%while (airport_rs.next()){%>
			<option value="<%=airport_rs.getString("airport_id")%>"><%=airport_rs.getString("airport_id")%></option>
    	<%}%>
    </select>
	<input type="submit" value="Submit">
	</form>

</body>
</html>