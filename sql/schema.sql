/*
CS 336 Project Schema
Group 17
Sadhana Chidambaran (src166, Section 2)
Hannah Lords (hjl40, Section 2)
Ted Moseley (trm124, Section 1)
Michael Truong (mt842, Section 6)
*/

-- Create database
CREATE SCHEMA IF NOT EXISTS `cs336`;
USE `cs336`;

-- Drop preexisting tables
DROP TABLE IF EXISTS uses;
DROP TABLE IF EXISTS departures;
DROP TABLE IF EXISTS destinations;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS seats;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS aircrafts;
DROP TABLE IF EXISTS airports;
DROP TABLE IF EXISTS airlines;


-- Create user entity
CREATE TABLE users (
    user_name VARCHAR(20) NOT NULL,
    user_pass VARCHAR(20) NOT NULL,
    person_name VARCHAR(20),
    user_type char(1) DEFAULT 'C',
    account_number INT NOT NULL AUTO_INCREMENT UNIQUE,
    CHECK (user_type = 'A' OR user_type = 'R' OR user_type = 'C'),
    PRIMARY KEY (user_name));
-- add data to users
LOCK TABLES users WRITE;
INSERT INTO users (user_name, user_pass, person_name, user_type) VALUES 
	('tm123', 'adminadmin', 'Ted Moseley', 'A'), 
	('hjl40', 'soap123', 'Hannah Lords', 'A'), 
	('sc123', 'adminadmin', 'Sadhana Chidambaran', 'R'), 
	('tm321', 'cs336', 'Michael Truong', 'A'), 
	('admin', 'adminadmin', NULL, 'A'), 
	('customer1', 'cust1', 'Sally Smith', 'C'), 
	('customer2', 'cust2', 'Alex Shu', 'C'), 
	('customer3', 'cust3', NULL, 'C'), 
	('cust_rep1', 'cust_rep1', 'Jonathan VanWick', 'R'), 
	('cust_rep2', 'cust_rep2', NULL, 'R'), 
	('cust_rep3', 'cust_rep3', 'Vanessa Hues', 'R'), 
	('otheradmin', 'otheradmin', 'Person McPerson', 'A');
UNLOCK TABLES;

-- Create ticket entity
CREATE TABLE tickets (
	ticket_num INT AUTO_INCREMENT,
    round_trip INT(1),
    booking_fee DOUBLE,
    issue_date DATETIME,
    total_fare DOUBLE, 
    user_name VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_name) REFERENCES users(user_name),
    PRIMARY KEY (ticket_num),
    CHECK (round_trip = 0 OR round_trip = 1));
-- add data to tickets
LOCK TABLES tickets WRITE;
INSERT INTO tickets (round_trip, booking_fee, issue_date, total_fare, user_name) VALUES 
	(1, 23.55, '2016/06/18 10:32:17', 1563.12, 'customer1'),
    (0, 23.55, '2016/11/07 9:12:48', 739.36, 'customer2'),
    (0, 23.55, '2016/11/18 1:17:24', 739.36, 'customer2');
UNLOCK TABLES;

-- Create airline entity
CREATE TABLE airlines (
	airline_id CHAR(2),
	airline_name VARCHAR(20),
	PRIMARY KEY (airline_id));
-- add data to airlines
LOCK TABLES airlines WRITE;
INSERT INTO airlines VALUES ('DL', 'Delta Airlines'), ('AA', 'American Airlines'), ('NW', 'Northwestern');
UNLOCK TABLES;

-- Create aircraft entity
CREATE TABLE aircrafts (
	aircraft_id INT NOT NULL,
	airline_id CHAR(2) NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    PRIMARY KEY (aircraft_id));
-- add data to aircrafts
LOCK TABLES aircrafts WRITE;
INSERT INTO aircrafts VALUES (27, 'DL'), (13, 'AA'), (24, 'NW'), (9, 'DL');
UNLOCK TABLES;
	
-- Create seats entity
-- Zero means you're on the waitlist
CREATE TABLE seats (
	aircraft_id INT NOT NULL,
	seat_num INT NOT NULL,
    class VARCHAR(8),
	CHECK (class = 'First' OR class = 'Buis' OR class = 'Econ'),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id),
    PRIMARY KEY (aircraft_id, seat_num));
-- add data to seats
LOCK TABLES seats WRITE;
INSERT INTO seats VALUES (27, 1, 'First'), (27, 2, 'Buis'), (27, 3, 'Econ'), (27, 4, 'Econ'), (27, 0, NULL),
	(13, 1, 'Econ'), (13, 2, 'Econ'), (13, 3, 'Econ'), (13, 4, 'Buis'), (13, 5, 'Buis'), (13, 6, 'First'), (13, 0, NULL),
	(24, 1, 'Econ'), (24, 2, 'Econ'), (24, 3, 'Econ'), (24, 4, 'Buis'), (24, 5, 'Buis'), (24, 6, 'First'), (24, 0, NULL),
	(9, 1, 'Econ'), (9, 2, 'Econ'), (9, 3, 'Econ'), (9, 4, 'Buis'), (9, 5, 'Buis'), (9, 6, 'First'), (9, 0, NULL);
UNLOCK TABLES;

-- Create flights entity
CREATE TABLE flights (
	airline_id CHAR(2) NOT NULL,
    flight_num INT NOT NULL,
    flight_type VARCHAR(8),
    flight_days VARCHAR(9),
    depart DATETIME,
    arrival DATETIME,
    fare_first DOUBLE,
    fare_economy DOUBLE,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    PRIMARY KEY (airline_id, flight_num));
-- add data to flights
LOCK TABLES flights WRITE;
INSERT INTO flights VALUES 
	('DL', 1, 'Domestic', 'MWSu', '2016/06/18 10:32', '2016/06/18 1:32', 700.25, 500.12),
	('DL', 2, 'Internat', 'MSSu', '2016/06/18 7:32', '2016/06/18 12:32', 700.25, 500.12),
	('AA', 1, 'Domestic', 'TThF', '2016/06/18 10:32', '2016/06/18 1:32', 1000.25, 600.12),
	('AA', 2, 'Domestic', 'MTWThSSu', '2016/07/16 10:32', '2016/07/16 1:32', 850.25, 550.12),
	('AA', 3, 'Internat', 'MTW', '2016/07/16 09:32', '2016/07/16 4:28', 900.25, 600.12),
	('AA', 4, 'Domestic', 'WSSu', '2016/07/16 10:32', '2016/07/16 1:32', 850.25, 550.12),
	('NW', 1, 'Internat', 'MTWThF', '2016/07/16 10:32', '2016/07/16 1:32', 850.25, 550.12);
UNLOCK TABLES;

-- Create uses relationship
CREATE TABLE uses (
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
    aircraft_id INT NOT NULL,
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id),
    PRIMARY KEY (airline_id, flight_num, aircraft_id));
-- add data to uses
LOCK TABLES uses WRITE;
INSERT INTO uses VALUES ('DL', 1, 27), ('DL', 2, 9), ('AA', 1, 13), ('AA', 2, 13), ('AA', 3, 13), ('AA', 4, 24);
UNLOCK TABLES;

-- Create airports entity
CREATE TABLE airports (
	airport_id CHAR(3),
	airport_city VARCHAR(20),
	airport_state VARCHAR(20),
	airport_country CHAR(3),
	PRIMARY KEY (airport_id));
-- add data to airports
LOCK TABLES airports WRITE;
INSERT INTO airports VALUES ('EWR', 'Newark', 'NJ', 'USA'), ('IDA', 'Idaho Falls', 'ID', 'USA'), ('SLC', 'Salt Lake City', 'UT', 'USA'),
	('JFK', 'Queens', 'NY', 'USA'), ('WKK', ' Aleknagik', 'AK', 'USA'), ('AUS', 'Austin', 'TX', 'USA'), 
	('JAX', 'Jacksonville', 'FL', 'USA'), ('KBC', 'Birch Creek', 'AK', 'USA'), ('BMI', 'Bloomington', 'IL', 'USA'), 
	('CDG', 'Paris', 'Ile-de-France', 'FRA'), ('NRT', 'Tokyo', 'Kanto', 'JPN'), ('DEL', 'New Delhi', 'Agra', 'IND');
UNLOCK TABLES;

-- Create departure relationship
CREATE TABLE departures (
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
	airport_id CHAR(3) NOT NULL,
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
	FOREIGN KEY (airport_id) REFERENCES airports(airport_id),
	PRIMARY KEY (airline_id, flight_num, airport_id));
-- add data to departures
LOCK TABLES departures WRITE;
INSERT INTO departures VALUES ('DL', 1, 'EWR'), ('DL', 2, 'CDG'), ('AA', 1, 'IDA'), ('AA', 2, 'AUS'), ('AA', 3, 'NRT'),
	('AA', 4, 'WKK'), ('NW', 1, 'CDG');
UNLOCK TABLES;

-- Create destination relationship
CREATE TABLE destinations (
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
	airport_id CHAR(3) NOT NULL,
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
	FOREIGN KEY (airport_id) REFERENCES airports(airport_id),
	PRIMARY KEY (airline_id, flight_num, airport_id));
-- add data to destinations
LOCK TABLES destinations WRITE;
INSERT INTO destinations VALUES ('DL', 1, 'SLC'), ('DL', 2, 'DEL'), ('AA', 1, 'EWR'), ('AA', 2, 'JAX'), ('AA', 3, 'AUS'),
	('AA', 4, 'KBC'), ('NW', 1, 'JFK');
UNLOCK TABLES;
	
-- Create trip entity
CREATE TABLE trips (
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
	ticket_num INT NOT NULL,
	aircraft_id INT NOT NULL,
	seat_num INT NOT NULL,
	meal INT(1),
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
	FOREIGN KEY (ticket_num) REFERENCES tickets(ticket_num),
	FOREIGN KEY (aircraft_id, seat_num) REFERENCES seats(aircraft_id, seat_num),
	PRIMARY KEY (airline_id, flight_num, ticket_num));
-- add data to trips
LOCK TABLE trips WRITE;
INSERT INTO trips VALUES ('DL', 1, 1, 27, 1, 0), ('DL', 1, 2, 27, 2, 1), ('DL', 1, 3, 27, 0, 0);
UNLOCK TABLES;