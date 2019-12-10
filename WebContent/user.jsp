<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
				<td>${user.personName}</td>
				<td>${user.userName}</td>
				<td>${user.userPass}</td>
			</tr>
		</tbody>
	</table>
</body>
</html>