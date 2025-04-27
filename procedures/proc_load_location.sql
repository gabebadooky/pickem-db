/******************************
File: proc_load_location.sql
Last Update: 2/26/2025
Description: This script inserts a new locations record if one does not
				already exist or updates the existing one
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_LOAD_LOCATION //

CREATE PROCEDURE PROC_LOAD_LOCATION (
	IN  IN_STADIUM      VARCHAR(50),
	IN  IN_CITY         VARCHAR(50),
	IN  IN_STATE        VARCHAR(20),
	IN  IN_LATITUDE     DECIMAL(19,16),
	IN  IN_LONGITUDE	DECIMAL(19,16) 
)
BEGIN
	
    IF (SELECT COUNT(*) FROM LOCATIONS WHERE STADIUM = IN_STADIUM AND CITY = IN_CITY) = 0 THEN
		
        # Insert new row 
        INSERT INTO LOCATIONS (STADIUM, CITY, STATE, LATITUDE, LONGITUDE)
			VALUES (IN_STADIUM, IN_CITY, IN_STATE, IN_LATITUDE, IN_LONGITUDE);
	
    ELSE
        
        # Update existing row
        UPDATE LOCATIONS 
			SET 
				STATE = IN_STATE,
				LATITUDE = IN_LATITUDE,
                LONGITUDE = IN_LONGITUDE
			WHERE STADIUM = IN_STADIUM
				AND CITY = IN_CITY;
        
	END IF;
    
    COMMIT;

END //

DELIMITER ;
