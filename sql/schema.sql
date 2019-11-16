/*
CS 336 Project Schema
Group 17
Sadhana Chidambaran (src166, Section 2)
Hannah Lords (hjl40, Section 2)
Ted Moseley (trm124, Section 1)
Michael Truong (mt842, Section 6)
*/

-- Create database
CREATE DATABASE IF NOT EXISTS tripBooker;
USE tripBooker;

-- Drop preexisting tables
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS customer_reps;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS airlines;
DROP TABLE IF EXISTS aircrafts;
DROP TABLE IF EXISTS seats;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS uses;
DROP TABLE IF EXISTS days;
DROP TABLE IF EXISTS flights_on;
DROP TABLE IF EXISTS airports;
DROP TABLE IF EXISTS departure;
DROP TABLE IF EXISTS destination;
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS assigned;

-- Create user entity
CREATE TABLE users (
	user_name VARCHAR(20) NOT NULL,
    user_pass VARCHAR(20) NOT NULL,
    person_name VARCHAR(20),
    PRIMARY KEY (user_name));

-- Create admin entity
CREATE TABLE admins (
	user_name VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_name) REFERENCES users(user_name),
    PRIMARY KEY (user_name));

-- Create customer representative entity
CREATE TABLE customer_reps (
	user_name VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_name) REFERENCES users(user_name),
    PRIMARY KEY (user_name));
    
-- Create customer entity
CREATE TABLE customers (
	user_name VARCHAR(20) NOT NULL,
    account_number INT NOT NULL,
    FOREIGN KEY (user_name) REFERENCES users(user_name),
    PRIMARY KEY (user_name));

-- Create ticket entity
CREATE TABLE tickets (
	ticket_num INT(20) NOT NULL,
    round_trip INT(1),
    booking_fee DOUBLE,
    issue_date DATETIME,
    total_fare DOUBLE, 
    user_name VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_name) REFERENCES users(user_name),
    PRIMARY KEY (ticket_num),
    CHECK (round_trip = 0 OR round_trip = 1));

-- Create airline entity
CREATE TABLE airlines (
	airline_id CHAR(2) NOT NULL,
	PRIMARY KEY (airline_id));

-- Create aircraft entity
CREATE TABLE aircrafts (
	aircraft_id INT NOT NULL,
	airline_id CHAR(2) NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    PRIMARY KEY (aircraft_id));

-- Create seats entity
CREATE TABLE seats (
	aircraft_id INT NOT NULL,
	seat_num INT NOT NULL,
    class VARCHAR(8),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id),
    PRIMARY KEY (aircraft_id, seat_num));

-- Create flights entity
CREATE TABLE flights (
	airline_id CHAR(2) NOT NULL,
    flight_num INT NOT NULL,
    flight_type VARCHAR(8),
    flight_date DATETIME,
    depart DATETIME,
    arrival DATETIME,
    fare_first DOUBLE,
    fare_economy DOUBLE,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    PRIMARY KEY (airline_id, flight_num));

-- Create uses relationship
CREATE TABLE uses (
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
    aircraft_id INT NOT NULL,
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id),
    PRIMARY KEY (airline_id, flight_num, aircraft_id));

-- Create days entity
CREATE TABLE days (
	day_number DATETIME NOT NULL,
	day VARCHAR(9),
	PRIMARY KEY (day_number));

-- Create flights_on relationship
CREATE TABLE flights_on (
	day_number DATETIME NOT NULL,
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
	FOREIGN KEY (day_number) REFERENCES days(day_number),
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
	PRIMARY KEY (day_number, airline_id, flight_num));

-- Create airports entity
CREATE TABLE airports (
	airport_id CHAR(3) NOT NULL,
	PRIMARY KEY (airport_id));

-- Create departure relationship
CREATE TABLE departure (
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
	airport_id CHAR(3) NOT NULL,
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
	FOREIGN KEY (airport_id) REFERENCES airports(airport_id),
	PRIMARY KEY (airline_id, flight_num, airport_id));

-- Create destination relationship
CREATE TABLE destination (
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
	airport_id CHAR(3) NOT NULL,
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
	FOREIGN KEY (airport_id) REFERENCES airports(airport_id),
	PRIMARY KEY (airline_id, flight_num, airport_id));

-- Create trip entity
CREATE TABLE trip (
	airline_id CHAR(2) NOT NULL,
	flight_num INT NOT NULL,
	ticket_num INT NOT NULL,
	trip_date DATETIME,
	meal VARCHAR(20),
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
	FOREIGN KEY (ticket_num) REFERENCES tickets(ticket_num),
	PRIMARY KEY (airline_id, flight_num, ticket_num));

-- Create assigned relationship
CREATE TABLE assigned (
	airline_id CHAR(2) NOT NULL, 
	flight_num INT NOT NULL, 
	ticket_num INT(20) NOT NULL, 
	aircraft_id INT NOT NULL, 
	seat_number INT NOT NULL, 
	FOREIGN KEY (airline_id, flight_num) REFERENCES flights(airline_id, flight_num),
	FOREIGN KEY (ticket_num) REFERENCES tickets(ticket_num), 
	FOREIGN KEY (aircraft_id, seat_number) REFERENCES seats(aircraft_id, seat_num), 
	PRIMARY KEY (airline_id, flight_num, ticket_num, aircraft_id, seat_number));
