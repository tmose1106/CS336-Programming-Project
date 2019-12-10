

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
 * Servlet implementation class DeleteAircraftServlet
 */
@WebServlet("/DeleteAircraftServlet")
public class DeleteAircraftServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAircraftServlet() {
        super();
    }
    
    // Determines whether aircraft is in table
    private static boolean validate(String aircraftID) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	PreparedStatement ps;
		
    	try {
    		// Create a prepared statement for substituting in values
			ps = connection.prepareStatement(
				"SELECT * FROM aircrafts WHERE aircraft_id = ?;");
			
	    	ps.setString(1, aircraftID);
	    	
	    	ResultSet rs = ps.executeQuery();
	    	
	    	// next() returns a boolean saying if there are more rows in the set
	    	return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return false;
    }
    
    // Delete aircraft from aircrafts
    private static void delete_aircraft(String aircraftID) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		PreparedStatement ps = connection.prepareStatement(
    				"DELETE FROM aircrafts WHERE aircraft_id = ?");

	    	ps.setString(1, aircraftID);
	    	
	    	ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/deleteAircraft.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aircraftID = request.getParameter("aircraftID");
		String confirm = request.getParameter("confirm");
		if(aircraftID.equals(confirm)) {
			if(!validate(aircraftID)) {
				//If aircraft doesn't exists, set error message and forward back to form
				request.setAttribute("errorMessage", "Aircraft doesn't exists.");

				request.getRequestDispatcher("/deleteAircraft.jsp").forward(request, response);
			} else {
				response.sendRedirect("/servlet-demo/aircraftDeleted.html");

				delete_aircraft(aircraftID);
			}
		} else {
			//If Aircraft Code and Confirm Code are not the same, set error message and forward back to form
			request.setAttribute("errorMessage", "Aircraft Code and Confirmation Code don't match");

			request.getRequestDispatcher("/deleteAircraft.jsp").forward(request, response);
		}
	}

}
