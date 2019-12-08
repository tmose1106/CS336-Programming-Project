

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

/**
 * Servlet implementation class DeleteAirportServlet
 */
@WebServlet("/DeleteAirportServlet")
public class DeleteAirportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAirportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
 // Determine whether Airport is already in database
    private static boolean validate(String airportID) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	PreparedStatement ps;
		
    	try {
    		// Create a prepared statement for substituting in values
			ps = connection.prepareStatement(
				"SELECT * FROM airports WHERE airport_id = ?;");
			
	    	ps.setString(1, airportID);
	    	
	    	ResultSet rs = ps.executeQuery();
	    	
	    	// next() returns a boolean saying if there are more rows in the set
	    	return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return false;
    }
    
    // Delete airport from airports
    private static void delete_airport(String airportID) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		PreparedStatement ps = connection.prepareStatement(
    				"DELETE FROM airports WHERE airport_id = ?");

	    	ps.setString(1, airportID);
	    	
	    	ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/deleteAirport.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String airportID = request.getParameter("airportID");
		String confirm = request.getParameter("confirm");
		if(airportID.equals(confirm)) {
			if(!validate(airportID)) {
				//If airport doesn't exists, set error message and forward back to form
				request.setAttribute("errorMessage", "Airport doesn't exists.");

				request.getRequestDispatcher("/deleteAirport.jsp").forward(request, response);
			} else {
				response.sendRedirect("/servlet-demo/airportDeleted.html");

				delete_airport(airportID);
			}
		} else {
			//If Airport Code and Confirm Code are not the same, set error message and forward back to form
			request.setAttribute("errorMessage", "Airport Code and Confirmation Code don't match");

			request.getRequestDispatcher("/deleteAirport.jsp").forward(request, response);
		}
	}

}
