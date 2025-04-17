DROP DATABASE IF EXISTS olympics;
CREATE DATABASE olympics;
USE olympics;

CREATE TABLE `Athletes` (
    `Athlete_ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` VARCHAR(255) NOT NULL, 
    `Sex` CHAR(1) NOT NULL
);

CREATE TABLE `Events` (
    `Event_ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Sport` VARCHAR(255) NOT NULL,
    `Event` VARCHAR(255) NOT NULL
);

CREATE TABLE `Countries` (
    `NOC` CHAR(3) NOT NULL,
    `Country` VARCHAR(255),
    PRIMARY KEY (`NOC`)
);

CREATE TABLE `Athlete_Event` (
    `Athlete_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    `Year` INT NOT NULL,
    `Medal` ENUM('Gold', 'Silver', 'Bronze', ''),
    `Age` INT,
	`Height` INT,
    `Weight` INT,
    `NOC` VARCHAR(3) NOT NULL,
    PRIMARY KEY (`Event_ID`, `Athlete_ID`, `Year`)
);

ALTER TABLE
  `Athlete_Event` ADD CONSTRAINT `athlete_event_athlete_id_foreign` FOREIGN KEY (`Athlete_ID`) REFERENCES `Athletes`(`Athlete_ID`);
    
ALTER TABLE
  `Athlete_Event` ADD CONSTRAINT `athlete_event_event_id_foreign` FOREIGN KEY (`Event_ID`) REFERENCES `Events`(`Event_ID`);
    
ALTER TABLE
    `Athlete_Event` ADD CONSTRAINT `athlete_event_noc_foreign` FOREIGN KEY (`NOC`) REFERENCES `Countries`(`NOC`);


# ------------------------------------------------------------ #
# DUMPING DATA
# ------------------------------------------------------------ #


# Using Secure File Prive
# Error Code: 1290. The MySQL server is running with the --secure-file-priv option so it cannot execute this statement

# Die Variable auf der Konsole anzeigen
SHOW VARIABLES LIKE "secure_file_priv";


# ------------------------------------------------------------ #
# DUMP ATHLETES
# ------------------------------------------------------------ #

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/athletes.csv" 
INTO TABLE athletes
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;

SELECT * FROM athletes;

# ------------------------------------------------------------ #
# DUMP COUNTRIES
# ------------------------------------------------------------ #

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/countries.csv" 
INTO TABLE countries
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;

SELECT * FROM countries;

# ------------------------------------------------------------ #
# DUMP EVENTS
# ------------------------------------------------------------ #

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv" 
INTO TABLE events
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;

SELECT * FROM events;

# ------------------------------------------------------------ #
# DUMP ATHLETE_EVENT
# ------------------------------------------------------------ #

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/athlete_event.csv" 
INTO TABLE athlete_event
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Athlete_ID, Event_ID, Year, Medal, @Age, @Height, @Weight, NOC)
SET Age    = NULLIF(@Age, ''),
	Height = NULLIF(@Height, ''),
	Weight = NULLIF(@Weight, '')
;

SELECT * FROM athlete_event;

# ------------------------------------------------------------ #
# ZUSAMMENFASSUNG
# ------------------------------------------------------------ #

SELECT TABLE_NAME, TABLE_ROWS 
FROM `information_schema`.`tables` 
WHERE `table_schema` = 'olympics'
;

