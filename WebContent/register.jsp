<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Register</title>
</head>
<body>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="RegisterServlet" method="post">  
	    <label for="name">Name:</label>
	    <input type="text" name="name">
	    <br>
	    <label for="password">Password:</label>
	    <input type="password" name="password">
	    <br>  
	    <input type="submit" value="Register">  
    </form>

</body>
</html>