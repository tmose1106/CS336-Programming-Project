

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
 * Servlet implementation class AddFlightServlet
 */
@WebServlet("/AddFlightServlet")
public class AddFlightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddFlightServlet() {
        super();
    }
    
    // Determine whether a value is in a specific column of a table
    private static boolean validateFlight(String airlineID, String flightID) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	PreparedStatement ps;
		
    	try {
    		// Create a prepared statement for substituting in values
			ps = connection.prepareStatement(
				"SELECT * FROM flights WHERE airline_id = ? AND flight_num = ?;");
			
	    	ps.setString(1, airlineID);
	    	ps.setString(2,  flightID);
	    	
	    	ResultSet rs = ps.executeQuery();
	    	
	    	// next() returns a boolean saying if there are more rows in the set
	    	return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return false;
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

    // Add Flight to flights
    private static void add_flight(String airlineID, String flightID, String flightType, String flightDays,
    		String departDate, String arrivalDate, String fareFirst, String fareEcon) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		
    		PreparedStatement ps = connection.prepareStatement(
				"INSERT INTO flights (airline_id, flight_num, flight_type, flight_days, depart, arrival,"
				+ "fare_first, fare_economy) VALUES (?, ?, ?, ?, ?, ?, ?, ?);");

	    	ps.setString(1, airlineID);
	    	ps.setString(2, flightID);
	    	ps.setString(3, flightType);
	    	ps.setString(4, flightDays);
	    	ps.setString(5, departDate);
	    	ps.setString(6, arrivalDate);
	    	ps.setString(7, fareFirst);
	    	ps.setString(8, fareEcon);
	    	
	    	ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    
 // Add Flight to flights
    private static void add_airport(String airlineID, String flightID, String airportID, String airportType) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		
    		PreparedStatement ps = connection.prepareStatement(
				"INSERT INTO ? (airline_id, flight_num, airport_id) VALUES (?, ?, ?);");
    		ps.setString(1, airportType);
	    	ps.setString(2, airlineID);
	    	ps.setString(3, flightID);
	    	ps.setString(4, airportID);
	    	
	    	ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/addFlight.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String flightID = request.getParameter("flightID");
		String airlineID = request.getParameter("airlineID");
		String flightType = request.getParameter("flightType");
		String flightDays = "";
		String departDate = request.getParameter("departDate");
		String arrivalDate = request.getParameter("arrivalDate");
		String fareFirst = request.getParameter("fareFirst");
		String fareEcon = request.getParameter("fareEcon");
		
		String departAirport = request.getParameter("departAirport");
		String arrivalAirport = request.getParameter("arrivalAirport");
		
		flightDays += request.getParameter("mon") + request.getParameter("tue") + request.getParameter("wed") +
				request.getParameter("thur") + request.getParameter("fri") + request.getParameter("sat") +
				request.getParameter("sun");
		if(flightDays.equals("")) {
			request.setAttribute("errorMessage", "Flight must operate on at least one day of the week.");
			
			request.getRequestDispatcher("/addFlight.jsp").forward(request, response);
		}
		if(validateFlight(airlineID, flightID)) {
			//If flight already exists, set error message and forward back to form
			request.setAttribute("errorMessage", "Flight already exists.");
			
			request.getRequestDispatcher("/addFlight.jsp").forward(request, response);
		} else {
			add_flight(airlineID, flightID, flightType, flightDays, departDate, arrivalDate, fareFirst, fareEcon);
			
			if(!validate(departAirport)) {
				//If airport doesn't exist, set error message and forward back to form
				request.setAttribute("errorMessage", "Departing airport doesn't exist.");
				
				request.getRequestDispatcher("/addFlight.jsp").forward(request, response);
			}
			add_airport(airlineID, flightID, departAirport, "departures");
			
			if(!validate(arrivalAirport)) {
				//If airport doesn't exist, set error message and forward back to form
				request.setAttribute("errorMessage", "Arrival airport doesn't exist.");
				
				request.getRequestDispatcher("/addFlight.jsp").forward(request, response);
			}
			add_airport(airlineID, flightID, arrivalAirport, "destinations");
		}
	}

}
