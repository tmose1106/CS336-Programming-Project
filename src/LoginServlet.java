

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
 * Servlet implementation class Login
 */
@WebServlet(description = "Demo for login page", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    private static boolean validate(String username, String password) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	PreparedStatement ps;
		
    	try {
    		// Create a prepared statement, for substituting in values
			ps = connection.prepareStatement(
				"SELECT * FROM users WHERE user_name = ? AND user_pass = ?;");
			
	    	ps.setString(1, username);
	    	ps.setString(2, password);
	    	
	    	ResultSet rs = ps.executeQuery();
	    	
	    	// next() returns a boolean saying if there are more rows in the set
	    	return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return false;
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {          
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        if (validate(name, password)) {
        	//  If valid credentials, redirect to profile page and
        	// add name to session 
        	response.sendRedirect("profile.jsp");
        	
        	HttpSession session = request.getSession(true);  
        	
        	session.setAttribute("name", name);
        }  
        else {
        	//  If invalid, set error message and forward back to login
        	// page
        	request.setAttribute("errorMessage", "Invalid credentials!");
        	
        	request.getRequestDispatcher("/login.jsp").forward(request, response);
        }  
	}

}
