import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet(description = "Demo for login page", urlPatterns = { "/RegisterServlet" })
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    private static boolean validate(String username) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	PreparedStatement ps;
		
    	try {
    		// Create a prepared statement, for substituting in values
			ps = connection.prepareStatement(
				"SELECT * FROM users WHERE user_name = ?;");
			
	    	ps.setString(1, username);
	    	
	    	ResultSet rs = ps.executeQuery();
	    	
	    	// next() returns a boolean saying if there are more rows in the set
	    	return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return false;
    }
    
    private static void add_user(String username, String password, String name) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		PreparedStatement ps = connection.prepareStatement(
				"INSERT INTO users (user_name, user_pass, person_name) values(?, ?, ?);");

	    	ps.setString(1, username);
	    	ps.setString(2, password);
	    	ps.setString(3, name);
	    	
	    	ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {          
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("password-confirm");
        String name = request.getParameter("name");

        if (validate(username)) {
        	// If invalid, set error message and forward back to register page
        	request.setAttribute("errorMessage", "Username already taken!");
        	
        	request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
        
        else if (password.equals(passwordConfirm))
        {
        	request.setAttribute("errorMessage", "Passwords do not match");
        	
        	request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
        
        else {        	
        	response.sendRedirect("/success.html");
        	
        	add_user(username, password, name);

        	// HttpSession session = request.getSession(true);  
        }  
	}
}
