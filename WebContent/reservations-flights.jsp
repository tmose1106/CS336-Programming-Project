<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="cs336.DatabaseUtil" %>
<%!
Connection connection = null;
PreparedStatement ps = null;
%>
<%
connection = DatabaseUtil.getConnection();

ps = connection.prepareStatement("SELECT * FROM trips NATURAL JOIN tickets NATURAL JOIN users WHERE airline_id = ? AND flight_num = ? ORDER BY person_name, ticket_num;");

String flight_info = request.getParameter("flight_info");
String[] flight_info_split = flight_info.split(" ");

ps.setString(1, flight_info_split[0]);
ps.setString(2, flight_info_split[1]);

ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Reservations for a Flight</title>
</head>
<body>

	<h4>Reservations for a Flight</h4>
	<table>
		<thead>
			<tr>
				<th>Customer</th>
				<th>Ticket Number</th>
				<th>Seat</th>
				<th>Round Trip</th>
				<th>Issue Date</th>
			</tr>
		</thead>
	
		<tbody>
			<%while (rs.next()) {%>
			<tr>
				<td><%=rs.getString("person_name")%></td>
				<td><%=rs.getString("ticket_num")%></td>
				<td><%=rs.getString("seat_num")%></td>
				<td><%=rs.getString("round_trip")%></td>
				<td><%=rs.getString("issue_date")%></td>
			</tr>
			<%}%>
		</tbody>
	</table>

	<p>
	<input type="button" value="Return to Profile" onclick="window.location='/servlet-demo/admin-profile.jsp'">
	</p>
	
</body>
</html>