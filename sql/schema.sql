# Create Database
create database tripBooker;
use tripBooker;

# Create table of users
create table users
	(user_name varchar(20),
    user_pass varchar(20) not null,
    person_name varchar(20),
    primary key (user_name));

# Create admin entity
create table admins
	(user_name varchar(20),
    foreign key(user_name) references users,
    primary key(user_name));

# Create Customer rep entity
create table customer_reps
	(user_name varchar(20),
    foreign key(user_name) references users,
    primary key(user_name));
    
# Create Customer entity
create table customers
	(user_name varchar(20),
    account_number integer,
    foreign key(user_name) references users,
    primary key(user_name));

# Creat ticket entity
create table tickets
	(ticket_num int(20),
    round_trip int(1),
    booking_fee double,
    issue_date datetime,
    total_fare double, 
    user_name varchar(20) not null,
    foreign key(user_name) references users,
    primary key(ticket_num));

# Create Airline entity
create table airlines
	(airline_id char(2) primary key);

# Create Aircraft entity
create table aircrafts
	(airline_id char(2) not null,
    aircraft_id integer not null,
    foreign key(airline_id) references airlines,
    primary key(aircraft_id));

# Create entity seats
create table seats
	(seat_num integer,
    aircraft_id integer,
    airline_id integer,
    class varchar(8),
    primary key(seat_num, aircraft_id),
    foreign key(aircraft_id) references aircrafts);

# Create entity flight
create table flights
	(airline_id char(2),
    flight_num integer,
    flight_type varchar(8),
    depart datetime,
    arrival datetime,
    fare_first double,
    fare_economy double,
    primary key(flight_num),
    foreign key(airline_id) references airlines);

# Create relationship uses
create table uses
	(airline_id char(2),
    aircraft_id integer,
    flight_num integer,
	foreign key(airline_id) references airlines,
    foreign key(aircraft) references aircrafts,
    foreign key(flight_num) references flights,
    primary key(airline_id, flight_num, aircraft_id));