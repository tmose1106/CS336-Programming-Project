package cs336;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DatabaseUtil {
	static Connection connection = null;
	
	static {
		try {
			Context context = new InitialContext();
			
			DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/LoginDB");
			
			connection = dataSource.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
		return connection;
	}
}
