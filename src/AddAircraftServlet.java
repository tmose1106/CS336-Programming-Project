

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
 * Servlet implementation class AddAircraftServlet
 */
@WebServlet("/AddAircraftServlet")
public class AddAircraftServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddAircraftServlet() {
        super();
    }

    // Determine whether aircraft is already in database
    private static boolean validate(String table, String column, String value) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	PreparedStatement ps;
		
    	try {
    		// Create a prepared statement for substituting in values
			ps = connection.prepareStatement(
				"SELECT * FROM " + table + " WHERE "+ column +" = ?;");
			
	    	ps.setString(1, value);
	    	
	    	ResultSet rs = ps.executeQuery();
	    	
	    	// next() returns a boolean saying if there are more rows in the set
	    	return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return false;
    }
    
    // Add Aircraft to aircrafts
    private static void add_aircraft(String aircraftID, String airlineID) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		
    		PreparedStatement ps = connection.prepareStatement(
				"INSERT INTO aircrafts (aircraft_id, airline_id) VALUES"
				+ "(?, ?);");

	    	ps.setString(1, aircraftID);
	    	ps.setString(2, airlineID);
	    	
	    	ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    
    // Add seats to seats
    private static void add_seats(String aircraftID, int econSeats, int firstSeats, int busiSeats) {
    	Connection connection = DatabaseUtil.getConnection();
    	int numSeats = econSeats + busiSeats + firstSeats;
    	try {
    		PreparedStatement ps = connection.prepareStatement(
				"INSERT INTO seats (aircraft_id, seat_num, class) VALUES"
				+ "(?, ?, ?);");
    		ps.setString(1, aircraftID);
    		for(int i = 1; i <= numSeats; i++) {
    			String seat_num = Integer.toString(i);
		    	ps.setString(2, seat_num);
    			if(i <= firstSeats) {
    		    	ps.setString(3, "First");
    			} else if(i <= firstSeats + busiSeats) {
    				ps.setString(3, "Buis");
    			} else {
    				ps.setString(3, "Econ");
    			}
    			ps.executeUpdate();
    		}	    	
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/addAircraft.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aircraftID = request.getParameter("aircraftID");
		String airlineID = request.getParameter("airlineID");
		String econSeats = request.getParameter("econSeats");
		String firstSeats = request.getParameter("firstSeats");
		String busiSeats = request.getParameter("busiSeats");
		
		if(validate("aircrafts", "aircraft_id", aircraftID)) {
			//If aircraft already exists, set error message and forward back to form
			request.setAttribute("errorMessage", "Aircraft already exists.");
			
			request.getRequestDispatcher("/addAircraft.jsp").forward(request, response);
		} else {
			if(validate("airlines", "airline_id", airlineID)) {
				int econ;
				if(econSeats.contentEquals("")) {
					econ = 0;
				} else {
					econ = Integer.parseInt(econSeats);
				}
				int first;
				if(firstSeats.equals("")) {
					first = 0;
				} else {
					first = Integer.parseInt(firstSeats);
				}
				int busi;
				if(busiSeats.equals("")) {
					busi = 0;
				} else {
					busi = Integer.parseInt(busiSeats);
				}
				if(econ + first + busi < 1) {
					request.setAttribute("errorMessage", "Aircraft must have at least one seat (it does not matter what class)");

					request.getRequestDispatcher("/addAircraft.jsp").forward(request, response);
				} else {
					response.sendRedirect("/servlet-demo/aircraftAdded.html");

					add_aircraft(aircraftID, airlineID);
					add_seats(aircraftID, econ, first, busi);
				}
			} else {
				request.setAttribute("errorMessage", "Airline doesn't exists. Please choose another.");

				request.getRequestDispatcher("/addAircraft.jsp").forward(request, response);
			}
		}
	}

}
