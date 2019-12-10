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

ps = connection.prepareStatement("SELECT * FROM trips NATURAL JOIN tickets NATURAL JOIN users WHERE user_name = ? ORDER BY ticket_num, airline_id, flight_num;");
ps.setString(1, request.getParameter("customer"));
ResultSet rs = ps.executeQuery();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Reservations by Customer Name</title>
</head>
<body>
	<h4>Reservations for <%=request.getParameter("customer")%></h4>
	<table>
		<thead>
			<tr>
				<th>Ticket Number</th>
				<th>Airline</th>
				<th>Flight Number</th>
				<th>Seat</th>
				<th>Round Trip</th>
				<th>Issue Date</th>
			</tr>
		</thead>
	
		<tbody>
			<%while (rs.next()) {%>
			<tr>
				<td><%=rs.getString("ticket_num")%></td>
				<td><%=rs.getString("airline_id")%></td>
				<td><%=rs.getString("flight_num")%></td>
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