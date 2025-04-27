/******************************
File: proc_load_stats.sql
Last Update: 2/26/2025
Description: This script inserts a new stats record if one does not
				already exist or updates the existing one
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_LOAD_STATS //

CREATE PROCEDURE PROC_LOAD_STATS (
	IN IN_TEAM_ID	VARCHAR(25),
	IN IN_TYPE      VARCHAR(50),
	IN IN_VALUE     VARCHAR(25)
)
BEGIN
	
    IF (SELECT COUNT(*) FROM TEAM_STATS WHERE TEAM_ID = IN_TEAM_ID AND TYPE = IN_TYPE) = 0 THEN
		
        # Insert new row 
        INSERT INTO TEAM_STATS (TEAM_ID, TYPE, VALUE)
			VALUES (IN_TEAM_ID, IN_TYPE, IN_VALUE);
	
    ELSE
        
        # Update existing row
        UPDATE TEAM_STATS 
			SET VALUE = IN_VALUE
			WHERE TEAM_ID = IN_TEAM_ID
				AND TYPE = IN_TYPE;
        
	END IF;
    
    COMMIT;

END //

DELIMITER ;
