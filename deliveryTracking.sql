CREATE DATABASE deliveryTracking;

USE deliveryTracking;
CREATE TABLE driver(
    driver_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(35) NOT NULL,
    last_name VARCHAR(35) NOT NULL,
    DOB DATE
    );

CREATE TABLE driverPhone(
    driver_id INT(6) UNSIGNED,
    type ENUM('home','mobile'),
    phone VARCHAR(30),
    PRIMARY KEY(driver_id,phone),
    FOREIGN KEY(driver_id) REFERENCES driver(driver_id)
);

CREATE TABLE vehicle(
    vehicle_id INT(6) UNSIGNED AUTO_INCREMENT,
    license VARCHAR(7) UNIQUE,
    type ENUM('van','car','other'),
    purchase_year INT(4) NOT NULL,
    PRIMARY KEY(vehicle_id)
    );

CREATE TABLE shift(
    shift_id INT(6) UNSIGNED AUTO_INCREMENT,
    shift_start DATETIME,
    shift_end DATETIME,
    PRIMARY KEY(shift_id)
    );

CREATE TABLE driverVehicleShift(
    shift_id INT(6) UNSIGNED,
    driver_id INT(6) UNSIGNED,
    vehicle_id INT(6) UNSIGNED,
    PRIMARY KEY(shift_id),
    FOREIGN KEY(driver_id) REFERENCES driver(driver_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id),
    FOREIGN KEY (shift_id) REFERENCES shift(shift_id)
    );

CREATE TABLE location(
    location_id INT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    building_no INT,
    building_name VARCHAR(35),
    street VARCHAR(35) NOT NULL,
    city VARCHAR(35) NOT NULL,
    postcode VARCHAR(8) NOT NULL
    );

CREATE TABLE vehicleLocation(
    timestamp_id INT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT(6) UNSIGNED,
    location_id INT(8) UNSIGNED,
    gps_time DATETIME,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id),
    FOREIGN KEY (location_id) REFERENCES location(location_id)
    );

CREATE TABLE recipient(
    recipient_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(35) NOT NULL,
    last_name VARCHAR(35) NOT NULL,
    email VARCHAR(320)
    );
    
CREATE TABLE address(
    address_id INT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    building_no INT,
    building_name VARCHAR(35),
    street VARCHAR(35) NOT NULL,
    city VARCHAR(35) NOT NULL,
    postcode VARCHAR(8) NOT NULL
    );

CREATE TABLE delivery(
    delivery_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address_id INT(8) UNSIGNED,
    recipient_id INT(6) UNSIGNED,
    vehicle_id INT(6) UNSIGNED,   
    estimated_delivery DATE,
    delivery_time DATETIME, 
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (recipient_id) REFERENCES recipient(recipient_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id)
    );

CREATE TABLE item(
    item_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    delivery_id INT(6) UNSIGNED,
    fragile BOOLEAN NOT NULL,
    weight_kg DECIMAL(4,2),
    FOREIGN KEY (delivery_id) REFERENCES delivery(delivery_id)
    );

#DML Commands

INSERT INTO driver (first_name, last_name, DOB)
VALUES
('Ginni','Lemon', '1989-02-07'),
('Veronica','Green', '1985-04-24'),
('Bianca', 'Del Rio', '1975-06-27'),
('Rupaul','Charles', '1960-11-17'),
('Dave','Sylvando', '1990-06-02'),
('John','Smith', '1971-04-18'),
('Kathy','Burke', '1946-06-13'),
('Sarah','Paulson', '1974-12-17'),
('John','Smith', '1982-10-28'),
('Patricia','Tannis', '1985-05-24');

INSERT INTO vehicle (license,type,purchase_year)
VALUES
('HE11O55','van','2018'),
('QU33N12','van','2009'),
('DEL1V3R','van','2015'),
('FA5TT1M','car','2017'),
('0NT1ME1','other','2020');

INSERT INTO driverphone(driver_id,type,phone)
VALUES
(1,'mobile','07501654600'),
(2,'mobile','01230156900'),
(3,'home','01164960690'),
(4,'mobile','07700900909'),
(5,'mobile','07700900126'),
(6,'home','01184960904'),
(7,'home','01614960904'),
(8,'mobile','07700900989'),
(9,'home','01154960444'),
(10,'mobile','07700900318'),
((SELECT driver_id FROM driver WHERE last_name = 'Green' AND DOB = '1985-04-24'),
 'home','01134960810');

INSERT INTO shift(shift_start,shift_end)
VALUES
('2020-02-01 08:00:00', '2020-02-01 11:55:00'),
('2020-02-01 08:00:00', '2020-02-01 11:55:00'),
('2020-02-01 12:00:00', '2020-02-01 16:00:00'),
('2020-02-02 08:00:00', '2020-02-02 11:55:00'),
('2020-02-02 08:00:00', '2020-02-02 11:55:00'),
('2020-02-02 08:00:00', '2020-02-02 11:55:00'),
('2020-02-02 12:00:00', '2020-02-02 16:00:00'),
('2020-02-03 08:00:00', '2020-02-03 11:55:00'),
('2020-02-03 12:00:00', '2020-02-03 16:00:00'),
('2020-02-04 08:00:00', '2020-02-04 11:55:00'),
('2020-02-04 12:00:00', '2020-02-04 16:00:00'),
('2020-02-05 08:00:00', '2020-02-05 11:55:00'),
('2020-02-05 12:00:00', '2020-02-05 16:00:00'),
('2020-02-06 08:00:00', '2020-02-06 11:55:00'),
('2020-02-06 12:00:00', '2020-02-06 16:00:00'),
('2020-02-07 08:00:00', '2020-02-07 11:55:00'),
('2020-02-07 12:00:00', '2020-02-07 16:00:00'),
('2020-02-08 08:00:00', '2020-02-08 11:55:00'),
('2020-02-08 12:00:00', '2020-02-08 16:00:00');

INSERT INTO drivervehicleshift(shift_id, driver_id, vehicle_id)
VALUES
(1,1,2),
(2,2,1),
(3,4,4),
(4,3,3),
(5,1,1),
(6,9,2),
(7,10,5),
(8,8,4),
(9,1,5),
(10,3,1),
(11,2,3),
(12,10,2),
(13,1,4),
(14,4,4),
(15,5,1),
(16,3,5),
(17,6,3),
(18,8,1),
(19,7,2);

INSERT INTO location (building_no, building_name, street, city, postcode)
VALUES
('2','Lincoln Lake Depot','Lake st','Lincoln','LN5 78P'),
('3','Wells Court','Darling rd','Lincoln','LN3 65O'),
('5','Oak apts','Tree ln','Lincoln','LN7 89U'),
(NULL,NULL,'Camel rd','Nottingham','NG1 7YU'),
('99',NULL,'Specs st','Nottingham','NG1 7YU'),
('32',NULL,'Hello rd','Lincoln','LN5 9P6'),
(NULL,NULL,'Somewhere st','Lincoln','LN4 TU6'),
('34',NULL,'Magpie rd','Boston','PE21 3ZX'),
(NULL,'Billy\'s cafe','Billy st','Boston','PE21 6YK'),
('4',NULL,'Covid rd','Lincoln', 'LN4 6YJ'),
(NULL,NULL,'Here ln','Lincoln', 'LN4 OP2'),
('44',NULL,'Uni rd','Lincoln','LN5 HG2'),
('5','Chatty flats','Zoo ln','Nottingham','NG2 4RR'),
(NULL,NULL,'Pencil st','Nottingham','NG5 CR3'),
(NULL,'Applewood', 'Cute ln', 'Lincoln', 'LN5 TR4');

INSERT INTO vehiclelocation(vehicle_id, location_id, gps_time)
VALUES
(2,1,'2020-02-01 08:00:00'),
(2,2, '2020-02-01 09:00:00'),
(2,3, '2020-02-01 10:00:00'),
(1,1, '2020-02-01 08:00:00'),
(1,4, '2020-02-01 09:00:00'),
(1,5, '2020-02-01 10:00:00'),
(4,1, '2020-02-01 12:00:00'),
(4,6, '2020-02-01 13:00:00'),
(4,7, '2020-02-01 14:00:00'),
(4,8, '2020-02-01 15:00:00'),
(3,1, '2020-02-02 08:00:00'),
(3,9, '2020-02-02 09:00:00'),
(3,10, '2020-02-02 10:00:00'),
(1,1, '2020-02-02 08:00:00'),
(1,11, '2020-02-02 09:00:00');

USE deliveryTracking;

INSERT INTO recipient (first_name, last_name, email)
VALUES
('Karen','Smith','karensmith@outlook.com'),
('Prince','Charles','someprince@yahoo.com'),
('Jill','Jenkins',NULL),
('Harry','Hill','funnyman@gmail.com'),
('Billie','Piper',NULL),
('David','Tennant','thedoctor@universalmail.com'),
('Katy','Perry',NULL),
('Drew','Barrymore',NULL),
('Kevin','Perry',NULL),
('John','Smith','commonname@hotmail.com'),
('Henry','Caville',NULL),
('Julie','Andrews',NULL),
('Joanna','Lumley',NULL),
('Jennifer','Saunders',NULL),
('Dawn','French',NULL);

USE deliverytracking;

INSERT INTO address (building_no, building_name, street, city, postcode)
VALUES
('2', 'Acorn flats', 'Wood st', 'Lincoln', 'LN6 789'),
('3',NULL, 'Early rd', 'Nottingham', 'NG7 85K'),
('6',NULL,'Scent ln','Lincoln','LN5 R2D'),
('122','Game Creations','Tech st','Boston','PE21 3EF'),
('134',NULL,'Notts ln','Nottingham','NG1 FF4'),
('56', NULL, 'Family rd', 'Lincoln', 'LN5 5HK'),
('97',NULL, 'Crisis st', 'Lincoln', 'LN4 SSD'),
('12',NULL, 'Help rd', 'Lincoln', 'LN3 EWJ'),
('4',NULL, 'Something st','Boston', 'PE23 YUM'),
('2','Terry\'s Chocolates','Luxury rd','Boston','PE21 3FR'),
('45',NULL,'Cranberry st', 'Nottingham', 'NG2 TTY'),
('1',NULL,'Some rd', 'Lincoln', 'LN5 8JG'),
('47',NULL,'Machine ln', 'Boston','PE20 XDR'),
('33',NULL,'David rd','Lincoln','LN4 HHJ'),
('1',NULL,'Henry ln','Nottingham','NG1 K8Y');

USE deliveryTracking;

INSERT INTO delivery (address_id, recipient_id, vehicle_id, estimated_delivery, delivery_time)
VALUES
(1,1,1,'2020-02-01','2020-02-01 08:15:00'),
(3,2,1,'2020-02-01','2020-02-01 08:30:00'),
(2,3,1,'2020-02-01','2020-02-01 08:30:00'),
(4,4,4,'2020-02-01','2020-02-01 13:05:10'),
(5,4,4,'2020-02-02','2020-02-01 13:10:18'),
(6,5,2,'2020-02-03','2020-02-01 09:04:25'),
(7,6,3,'2020-02-03','2020-02-02 10:05:00'),
(8,7,2,'2020-02-03','2020-02-02 09:00:00'),
(10,8,3,'2020-02-04','2020-02-02 11:00:00'),
(9,9,5,'2020-02-04','2020-02-03 14:00:00'),
(11,10,5,'2020-02-04','2020-02-03 15:00:00'),
(13,10,5,'2020-02-04','2020-02-03 15:25:00'),
(12,11,1,'2020-02-04','2020-02-04 09:15:00'),
(15,12,2,'2020-02-05','2020-02-05 09:10:00'),
(14,13,2,'2020-02-05',NULL);

USE deliveryTracking;

INSERT INTO item (delivery_id, fragile, weight_kg)
VALUES
(1,TRUE,'2.1'),
(1,FALSE,'3.4'),
(1,TRUE,'5.6'),
(2,TRUE,'13.5'),
(2,TRUE,'14.2'),
(3,TRUE,'10.23'),
(4,FALSE,'2'),
(5,FALSE,'1'),
(5,FALSE,'1.4'),
(6,FALSE,'6.34'),
(7,TRUE,'1'),
(8,FALSE,'2.5'),
(9,FALSE,'3.5'),
(10,FALSE,'2.1'),
(11,FALSE,'4.5');

#location of any vehicle at any time Query

SELECT * FROM location WHERE location_id = (SELECT location_id FROM 
vehiclelocation where vehicle_id = 2 AND gps_time = '2020-02-01 10:00:00');

#Number of parcels delivered by any specific driver during a day's work Query

SET @shiftStart = (SELECT shift_start FROM shift WHERE shift_id = 2);
SET @shiftEnd = (SELECT shift_end FROM shift WHERE shift_id = 2);
SET @driverVehicle = (SELECT vehicle_id FROM drivervehicleshift WHERE shift_id = 2);

SELECT COUNT(*) 'Items Delivered'
FROM item i 
INNER JOIN delivery d
USING(delivery_id)
WHERE d.vehicle_id = @driverVehicle AND (d.delivery_time BETWEEN @shiftStart AND @shiftEnd);

#listing of all drivers Query

SELECT * FROM driver
ORDER BY last_name;

#Drivers who have only worked morning shifts Query

#Drivers Who have worked Morning Shifts
CREATE TEMPORARY TABLE morningworkers (driver_id int);
INSERT INTO morningWorkers (
	SELECT DISTINCT driver_id FROM driverVehicleShift
	INNER JOIN shift USING (shift_id)
	WHERE (cast(shift_start as time) BETWEEN '06:00:00' AND '09:00:00')
	AND (cast(shift_end as time) BETWEEN '07:00:00' AND '12:00:00')
	);
#Drivers Who have worked Afternoon shifts
CREATE TEMPORARY TABLE afternoonWorkers(driver_id int);
INSERT INTO afternoonWorkers(
    SELECT DISTINCT driver_id FROM drivervehicleshift
    INNER JOIN shift USING (shift_id)
    WHERE (cast(shift_start as time) BETWEEN '12:00:00' AND '14:00:00')
    AND (cast(shift_end as time) BETWEEN '15:00:00' AND '17:00:00')
    );

#Drivers Who have worked only Morning shifts
CREATE TEMPORARY TABLE onlyMorningWorkers(driver_id int);
INSERT INTO onlyMorningWorkers(
    SELECT * FROM morningWorkers
	WHERE driver_id NOT IN
	(SELECT * FROM afternoonWorkers)
    );
    
#Show Names
SELECT * FROM driver
INNER JOIN onlyMorningWorkers USING (driver_id);

#Location of any Vehicle Procedure


DELIMITER //
CREATE PROCEDURE locate_vehicle
(IN my_vehicle int(6), my_time DATETIME)
BEGIN
 	SELECT * FROM location WHERE location_id = (SELECT location_id FROM 
 	vehiclelocation where vehicle_id = my_vehicle AND gps_time = my_time);
END //
DELIMITER ;

CALL locate_vehicle(2,'2020-02-01 10:00:00');

#Items Delivered Procedure

DELIMITER //
CREATE PROCEDURE items_delivered
(IN shiftAllocation INT(6))
BEGIN
	SET @shiftStart = (SELECT shift_start FROM shift WHERE shift_id =    	 shiftAllocation);
	SET @shiftEnd = (SELECT shift_end FROM shift WHERE shift_id =   		shiftAllocation);
	SET @driverVehicle = (SELECT vehicle_id FROM drivervehicleshift WHERE 	  shift_id = shiftAllocation);

	SELECT COUNT(*) 'Items Delivered'
	FROM item i 
	INNER JOIN delivery d
	USING(delivery_id)
	WHERE d.vehicle_id = @driverVehicle AND (d.delivery_time BETWEEN 		@shiftStart AND @shiftEnd);
END //
DELIMITER ;

CALL items_delivered(2);