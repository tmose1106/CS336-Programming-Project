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

ps = connection.prepareStatement("SELECT * FROM users;");

ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Users</title>
</head>
<body>
	<h1>Users</h1>
	<table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Username</th>
			</tr>
		</thead>
		<tbody>
			<% while (rs.next()) { %>
			<tr>
				<td><a href="user.jsp?user_name=<%= rs.getString("user_name") %>"><%= rs.getString("person_name") %></a></td>
				<td><%= rs.getString("user_name") %></td>
			</tr>
			<% } %>
		</tbody>
	</table>
</body>
</html>