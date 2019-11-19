<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Register</title>
</head>
<body>
	<header>
		<a href="/servlet-demo/">Home</a>
	</header>
	<h1>Register</h1>
	<p>Please enter a username, full name and password to register</p>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="RegisterServlet" method="post">  
	    <label for="username">Username:</label>
	    <input type="text" name="username" required minlength="4" maxlength="20">
	    <label for="name">Full Name:</label>
	    <input type="text" name="name" required minlength="1" maxlength="20">
	    <br>
	    <label for="password">Password:</label>
	    <input type="password" name="password" required minlength="4" maxlength="20">
	    <label for="passsword-confirm">Confirm Password:</label>
	    <input type="password" name="password-confirm" required minlength="4" maxlength="20">
	    <br>
	    <input type="submit" value="Register">
    </form>
</body>
</html>