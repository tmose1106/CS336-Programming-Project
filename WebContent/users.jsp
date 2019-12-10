<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
			<c:forEach var="row" items="${users}">
				<tr>
					<td><a href="User?user_name=${row.userName}">${row.userName}</a>
					<td>${row.personName}</td>
			    </tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>