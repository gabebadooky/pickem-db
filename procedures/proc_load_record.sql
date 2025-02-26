/******************************
File: proc_load_record.sql
Last Update: 2/26/2025
Description: This script inserts a new record row if one does not
				already exist or updates the existing one
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_LOAD_RECORD //

CREATE PROCEDURE PROC_LOAD_RECORD (
	IN IN_TEAM_ID		VARCHAR(25),
	IN IN_RECORD_TYPE	VARCHAR(10),
	IN IN_WINS			TINYINT,
    IN IN_LOSSES		TINYINT,
    IN IN_TIES			TINYINT
)
BEGIN
	
    IF (SELECT COUNT(*) FROM RECORDS WHERE TEAM_ID = IN_TEAM_STATS AND RECORD_TYPE = IN_RECORD_TYPE) = 0 THEN
		
        # Insert new row 
        INSERT INTO RECORDS (TEAM_ID, RECORD_TYPE, WINS, LOSSES, TIES)
			VALUES (IN_TEAM_ID, IN_RECORD_TYPE, IN_WINS, IN_LOSSES, IN_TIES);
	
    ELSE
        
        # Update existing row
        UPDATE RECORDS 
			SET 
				WINS = IN_WINS,
				LOSSES = IN_LOSSES,
                TIES = IN_TIES
			WHERE TEAM_ID = IN_TEAM_ID
				AND RECORD_TYPE = IN_RECORD_TYPE;
        
	END IF;

END //

DELIMITER ;
