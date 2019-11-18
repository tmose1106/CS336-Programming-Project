<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo | Login</title>
</head>
<body>
	<header>
		<a href="/servlet-demo">Home</a>
	</header>
	<h1>Login</h1>
	<p>Please enter username and password to log in</p>
	<div style="color: #FF0000;">${errorMessage}</div>
    <form action="LoginServlet" method="post">  
	    <label for="name">Username:</label>
	    <input type="text" name="name" maxlength="20">
	    <br>
	    <label for="password">Password:</label>
	    <input type="password" name="password" maxlength="20">
	    <br>  
	    <input type="submit" value="Login">
    </form>
</body>
</html>