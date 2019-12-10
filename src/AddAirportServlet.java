

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
 * Servlet implementation class AddAirportServlet
 */
@WebServlet(description="Demo for Adding Airports", urlPatterns = { "/AddAirportServlet" })
public class AddAirportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddAirportServlet() {
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
    private static void add_airport(String airportID, String city, String state, String country) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		PreparedStatement ps = connection.prepareStatement(
				"INSERT INTO airports (airport_id, airport_city, airport_state, airport_country) VALUES"
				+ "(?, ?, ?, ?);");
    		if(city.equals("")) {city = null;}
    		if(state.equals("")) {state = null;}
    		if(country.equals("")) {country = null;}
	    	ps.setString(1, airportID);
	    	ps.setString(2, city);
	    	ps.setString(3, state);
	    	ps.setString(4, country);
	    	
	    	ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    //Get form results (the column values)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/addAirport.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String airportID = request.getParameter("airportID");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String country = request.getParameter("country");
		
		if(validate(airportID)) {
			//If airport already exists, set error message and forward back to form
			request.setAttribute("errorMessage", "Airport already exists.");
			
			request.getRequestDispatcher("/addAirport.jsp").forward(request, response);
		} else {
			response.sendRedirect("/servlet-demo/airportAdded.html");
			
			add_airport(airportID, city, state, country);
		}
	}

}
