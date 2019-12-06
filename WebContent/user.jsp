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

ps = connection.prepareStatement("SELECT * FROM users WHERE user_name = ?;");

ps.setString(1, request.getParameter("user_name"));

ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | User</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Username</th>
				<th>Password</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<% rs.next(); %>
				<td><%= rs.getString("person_name") %></td>
				<td><%= rs.getString("user_name") %></td>
				<td><%= rs.getString("user_pass") %></td>
			</tr>
		</tbody>
	</table>
</body>
</html>