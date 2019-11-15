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
	    <label for="username">Username:</label>
	    <input type="text" name="username" maxlength="20">
	    <br>
	    <label for="password">Password:</label>
	    <input type="password" name="password" maxlength="20">
	    <br>
	    <label for="passsword2">Renter Password:</label>
	    <input type="password" name="password2" maxlength="20">
	    <br>  
	    <label for="name">Name:</label>
	    <input type="text" name="name" maxlength="20">
	    <br>  
	    <input type="submit" value="Register"> 
	    <p>Click "Home" to go to Home Page</p>
		<button><a href="/servlet-demo">Home</a></button> 
    </form>

</body>
</html>