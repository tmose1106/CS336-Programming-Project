package cs336.entity;

import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
	public String userName;
	public String userPass;
	public String personName;
	
	public User(ResultSet rs) throws SQLException {
		userName = rs.getString("user_name");
		userPass = rs.getString("user_pass");
		personName = rs.getString("person_name");
	}
	
	public String getUserName() {
		return userName;
	}
	
	public String getUserPass() {
		return userPass;
	}
	
	public String getPersonName() {
		return personName;
	}
}
