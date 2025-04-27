/******************************
File: proc_load_record.sql
Last Update: 3/5/2025
Description: This script inserts a new scoring row if one does 
				not already exist or updates the existing one
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_LOAD_SCORING //

CREATE PROCEDURE PROC_LOAD_SCORING (
	IN IN_PICK_WEIGHT CHAR(1),
	IN IN_REWARD TINYINT,
	IN IN_PENALTY TINYINT
)
BEGIN
	
    IF (SELECT COUNT(*) FROM SCORING WHERE PICK_WEIGHT = IN_PICK_WEIGHT) = 0 THEN
		
        # Insert new row 
        INSERT INTO SCORING (PICK_WEIGHT, REWARD, PENALTY)
			VALUES (IN_PICK_WEIGHT, IN_REWARD, IN_PENALTY);
	
    ELSE
        
        # Update existing row
        UPDATE SCORING 
			SET 
				REWARD = IN_REWARD,
                PENALTY = IN_PENALTY
			WHERE PICK_WEIGHT = IN_PICK_WEIGHT;
        
	END IF;
    
    COMMIT;

END //

DELIMITER ;
