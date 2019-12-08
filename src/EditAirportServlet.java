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
 * Servlet implementation class EditAirportServlet
 */
@WebServlet("/EditAirportServlet")
public class EditAirportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditAirportServlet() {
        super();
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
    
    // Add airport to airports
    private static void edit_airport(String originalID, String airportID, String city, String state, String country) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		String query = "UPDATE airports SET";
    		int[] value = new int[4];
    		value[0] = 0;
    		boolean inserted = false;
    		if(!airportID.equals("")){
    			query += " airport_id = ?";
    			value[0] = 1;
    			inserted = true;
    		}
    		value[1] = 0;
    		if(!city.equals("")) {
    			if(inserted) {
    				query += ",";
    			}
    			query += " airport_city = ?";
    			value[1] = 1;
    		}
    		value[2] = 0;
    		if(!state.equals("")) {
    			if(inserted) {
    				query += ",";
    			}
    			query += " airport_state = ?";
    			value[2] = 1;
    		}
    		value[3] = 0;
    		if(!country.equals("")) {
    			if(inserted) {
    				query += ",";
    			}
    			query += " airport_country = ?";
    			value[3] = 1;
    		}
	    	query += " WHERE airport_id = ?;";
	    	PreparedStatement ps = connection.prepareStatement(query);
	    	int count = 0;
	    	for(int i = 0; i < 4; i++) {
	    		String field = null;
	    		if(value[i] == 1) {
	    			switch (i) {
	    				case 0: field = airportID; break;
	    				case 1: field = city; break;
	    				case 2: field = state; break;
	    				case 3: field = country; break;
	    			}
	    			count++;
	    			ps.setString(count, field);
	    		}
	    	}
	    	if(count < 1) {
	    		return;
	    	}
	    	ps.setString(count+1, originalID);
	    	ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/editAirport.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String originalID = request.getParameter("originalID");
		String airportID = request.getParameter("airportID");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String country = request.getParameter("country");
		
		if(!validate(originalID)) {
			//If airport doesn't already exists, set error message and forward back to form
			request.setAttribute("errorMessage", "Airport does not exist. Please add it instead.");
			
			request.getRequestDispatcher("/editAirport.jsp").forward(request, response);
		} else {
			if(!validate(airportID)) {
				response.sendRedirect("/servlet-demo/airportEdited.html");
				edit_airport(originalID, airportID, city, state, country);
			} else {
				//If airport already exists, set error message and forward back to form
				request.setAttribute("errorMessage", "The Airport you are trying to set this to already exists, so"
						+ " the edit could not be performed.");
				request.getRequestDispatcher("/editAirport.jsp").forward(request, response);
			}
		}
	}

}
