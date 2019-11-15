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
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        if(validate(name)) {
        	// If invalid, set error message and forward back to register page
        	request.setAttribute("errorMessage", "Username already taken!");
        	
        	request.getRequestDispatcher("/register.jsp").forward(request, response);
        }  
        
        if (password.length()<6)
        {
        	// If invalid, set error message and forward back to register page
        	request.setAttribute("errorMessage", "Password must be atleast 6 characters");
        	
        	request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
        else {
        	// If valid credentials, redirect to profile page and
        	// add name to session 
        	
        	response.sendRedirect("success.jsp");
        	try {
                Connection connection = DatabaseUtil.getConnection();
            	PreparedStatement ps;
				ps = connection.prepareStatement(
						"INSERT INTO users (user_name, user_pass) values(?, ?);");

		    	ps.setString(1, name);
		    	ps.setString(2, password);
		    	ps.executeUpdate();
		    	
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	
        	HttpSession session = request.getSession(true);  
        	
        }  
	}


}
