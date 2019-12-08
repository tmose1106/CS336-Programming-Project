

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
 * Servlet implementation class EditAircraftServlet
 */
@WebServlet("/EditAircraftServlet")
public class EditAircraftServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditAircraftServlet() {
        super();
    }

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
    
 // Add aircraft to aircrafts
    private static void edit_aircraft(String originalID, String aircraftID, String airlineID) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	try {
    		String query = "UPDATE aircrafts SET";
    		int[] value = new int[2];
    		value[0] = 0;
    		boolean inserted = false;
    		if(!aircraftID.equals("")){
    			query += " aircraft_id = ?";
    			value[0] = 1;
    			inserted = true;
    		}
    		value[1] = 0;
    		if(!airlineID.equals("")) {
    			if(inserted) {
    				query += ",";
    			}
    			query += " airline_id = ?";
    			value[1] = 1;
    		}
	    	query += " WHERE aircraft_id = ?;";
	    	PreparedStatement ps = connection.prepareStatement(query);
	    	int count = 0;
	    	for(int i = 0; i < 2; i++) {
	    		String field = null;
	    		if(value[i] == 1) {
	    			switch (i) {
	    				case 0: field = aircraftID; break;
	    				case 1: field = airlineID; break;
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
    
    private static void edit_seats(String aircraftID, int change, String seatClass) {
    	Connection connection = DatabaseUtil.getConnection();
    	try {
    		// Handles case where all deletions have already been made
    		if(change == 0) {
    			return;
    		}
    		// Add the requested number of seats with seat_nums at the end of the current seats.
    		if(change > 0) {
    			// Find the current number of seats
    			PreparedStatement ps = connection.prepareStatement(
    					"SELECT MAX(seat_num) AS Max FROM seats WHERE aircraft_id = ?;");
    			ps.setString(1, aircraftID);
    			ResultSet rs;
    			rs = ps.executeQuery();
    			rs.next();
    			int seats = rs.getInt("Max");
    			
    			// Add the requested number of seats to the end
    			for(int i = 1; i <= change; i++) {
    				int id = seats + i;
    				ps = connection.prepareStatement(
    						"INSERT INTO seats (aircraft_id, seat_num, class) VALUES (?, ?, ?);");
    				ps.setString(1, aircraftID);
    				ps.setString(2, Integer.toString(id));
    				ps.setString(3, seatClass);
    				
    				ps.executeUpdate();
    			}
    		// Remove the highest seat number of the required seat class
        	} else {
        		// Find the highest unoccupied seat in the desired class;
        		PreparedStatement ps = connection.prepareStatement(
        				"SELECT MAX(seat_num) as Max FROM seats WHERE aircraft_id = ? AND class = ? "
        				+ "AND seat_num NOT IN ("
        				+ "SELECT seat_num FROM trips WHERE seat_num IS NOT NULL AND aircraft_id = ?);");
        		ps.setString(1, aircraftID);
        		ps.setString(2, seatClass);
        		ps.setString(3, aircraftID);
        		ResultSet rs = ps.executeQuery();
        		rs.next();
        		int seat = rs.getInt("Max");
        		if(seat == 0) {
        			// Must move a passenger to wait list (the plane no longer has enough space);
        			ps = connection.prepareStatement(
        					"SELECT MAX(seat_num) as Max FROM seats WHERE aircraft_id = ? AND class = ?;");
        			ps.setString(1, aircraftID);
            		ps.setString(2, seatClass);
        			rs = ps.executeQuery();
            		rs.next();
            		seat = rs.getInt("Max");
            		if(seat == 0) {
            			// No seats of the desired class exist to remove
            			return;
            		}
        		}
        		// Delete the identified seat
        		ps = connection.prepareStatement("DELETE FROM seats WHERE "
        				+ "aircraft_id = ? AND seat_num = ?;");
        		ps.setString(1, aircraftID);
				ps.setString(2, Integer.toString(seat));
				
				ps.executeUpdate();
				change++;
				
				//Determine if must delete another seat
				if(change < 0) {
					edit_seats(aircraftID, change, seatClass);
				}
        	}
    	} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    
    private static boolean validDelete(String aircraftID, String seatClass, int value) {
    	Connection connection = DatabaseUtil.getConnection();
    	
    	PreparedStatement ps;
		
    	try {
    		// Create a prepared statement for substituting in values
    		if(seatClass.equals("*")) {
				seatClass = "Econ' OR class = 'First' OR class = 'Buis";
			};
			ps = connection.prepareStatement(
				"SELECT COUNT(*) as classSeatCount FROM seats WHERE aircraft_id = " + aircraftID 
				+ " AND (class = '" + seatClass + "');");
	    	ResultSet rs = ps.executeQuery();
	    	
	    	rs.next();
	    	int numSeats = rs.getInt("classSeatCount");
	    	if(value <= numSeats) {
	    		return true;
	    	}
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return false;
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/editAircraft.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String originalID = request.getParameter("originalID");
		String aircraftID = request.getParameter("aircraftID");
		String airlineID = request.getParameter("airlineID");
		String econSeats = request.getParameter("econSeats");
		String firstSeats = request.getParameter("firstSeats");
		String busiSeats = request.getParameter("busiSeats");
		
		if(validate("aircrafts", "aircraft_id", aircraftID)) {
			//If aircraft already exists, set error message and forward back to form
			request.setAttribute("errorMessage", "New aircraft ID already exists, so current the current aircraft ID"
					+ " cannot be updated");
			
			request.getRequestDispatcher("/editAircraft.jsp").forward(request, response);
		} else {
			if(validate("aircrafts", "aircraft_id", originalID)) {
				edit_aircraft(originalID, aircraftID, airlineID);
				
				if(aircraftID.equals("")) {
					aircraftID = originalID;
				}
				
				int econ = 0;
				if(!econSeats.equals("")) {
				econ = Integer.parseInt(econSeats);
				}
				int first = 0;
				if(!firstSeats.equals("")) {
				first = Integer.parseInt(firstSeats);
				}
				int busi = 0;
				if(!busiSeats.equals("")) {
				busi = Integer.parseInt(busiSeats);
				}
				
				if(!validDelete(aircraftID, "*", (econ + first + busi -1) *-1)) {
					request.setAttribute("errorMessage", "Aircraft " + aircraftID + " does not have "
							+ Integer.toString((econ + first + busi)*-1) + " seats to delete. "
									+ "Please pick a smaller number and remember aircrafts are required to "
									+ "have at least one seat.");

					request.getRequestDispatcher("/editAircraft.jsp").forward(request, response);
					return;
				}
				
				if(econ != 0) {
					if(validDelete(aircraftID, "Econ", econ*-1) | econ > 0) {
						edit_seats(aircraftID, econ, "Econ");
					} else {
						request.setAttribute("errorMessage", "Aircraft " + aircraftID + " does not have "
								+ Integer.toString(econ*-1) + " Economy seats to delete. "
										+ "Please pick a smaller number");

						request.getRequestDispatcher("/editAircraft.jsp").forward(request, response);
					}
				}
				
				if(first != 0) {
					if(validDelete(aircraftID, "First", first*-1) | first > 0) {
						edit_seats(aircraftID, first, "First");
					} else {
						request.setAttribute("errorMessage", "Aircraft " + aircraftID + " does not have "
								+ Integer.toString(first*-1) + " First Class seats to delete. "
										+ "Please pick a smaller number");

						request.getRequestDispatcher("/editAircraft.jsp").forward(request, response);
					}
				}
				
				if(busi != 0) {
					if(validDelete(aircraftID, "Buis", busi*-1) | busi > 0) {
						edit_seats(aircraftID, busi, "Buis");
					} else {
						request.setAttribute("errorMessage", "Aircraft " + aircraftID + " does not have "
								+ Integer.toString(busi*-1) + " Business Class seats to delete. "
										+ "Please pick a smaller number");

						request.getRequestDispatcher("/editAircraft.jsp").forward(request, response);
					}
				}
				
				response.sendRedirect("/servlet-demo/aircraftEdited.html");
			} else {
				request.setAttribute("errorMessage", "Aircraft doesn't exists. Please choose another.");

				request.getRequestDispatcher("/editAircraft.jsp").forward(request, response);
			}
		}
	}

}
