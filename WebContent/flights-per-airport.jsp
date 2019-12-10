<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="cs336.DatabaseUtil" %>
<%!
Connection connection = null;
PreparedStatement depart_ps = null;
PreparedStatement arrival_ps = null;
%>
<%
connection = DatabaseUtil.getConnection();

depart_ps = connection.prepareStatement("SELECT * FROM departures NATURAL JOIN flights WHERE airport_id = ? ORDER BY depart;");
depart_ps.setString(1, request.getParameter("airport_id"));
ResultSet depart_rs = depart_ps.executeQuery();

arrival_ps = connection.prepareStatement("SELECT * FROM destinations NATURAL JOIN flights WHERE airport_id = ? ORDER BY arrival;");
arrival_ps.setString(1, request.getParameter("airport_id"));
ResultSet arrival_rs = arrival_ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Flights for an Airport</title>
</head>
<body>

	<h3>Flights at <%=request.getParameter("airport_id")%></h3>


	<h4>Departures</h4>
	<table>
		<thead>
			<tr>
				<th>Airline</th>
				<th>Flight Number</th>
				<th>Type</th>
				<th>Departure</th>
			</tr>
		</thead>
	
		<tbody>
			<%while (depart_rs.next()) {%>
			<tr>
				<td><%=depart_rs.getString("airline_id")%></td>
				<td><%=depart_rs.getString("flight_num")%></td>
				<td><%=depart_rs.getString("flight_type")%></td>
				<td><%=depart_rs.getString("depart")%></td>
			</tr>
			<%}%>
		</tbody>
	</table>

	<h4>Arrivals</h4>	
	<table>
		<thead>
			<tr>
				<th>Airline</th>
				<th>Flight Number</th>
				<th>Type</th>
				<th>Arrival</th>
			</tr>
		</thead>
	
		<tbody>
			<%while (arrival_rs.next()) {%>
			<tr>
				<td><%=arrival_rs.getString("airline_id")%></td>
				<td><%=arrival_rs.getString("flight_num")%></td>
				<td><%=arrival_rs.getString("flight_type")%></td>
				<td><%=arrival_rs.getString("arrival")%></td>
			</tr>
			<%}%>
		</tbody>
	</table>
	
	<p>
	<input type="button" value="Return to Profile" onclick="window.location='/servlet-demo/admin-profile.jsp'">
	</p>

</body>
</html>