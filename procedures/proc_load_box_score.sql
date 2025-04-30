/******************************
File: proc_load_box_score.sql
Last Update: 2/26/2025
Description: This script inserts a new box score record if one does not
				already exist or updates the existing one
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_LOAD_BOX_SCORE //

CREATE PROCEDURE PROC_LOAD_BOX_SCORE (
	IN  IN_GAME_ID         VARCHAR(100),
	IN  IN_TEAM_ID         VARCHAR(100),
	IN  IN_Q1_SCORE        SMALLINT,
	IN  IN_Q2_SCORE        SMALLINT,
	IN  IN_Q3_SCORE        SMALLINT,
	IN  IN_Q4_SCORE        SMALLINT,
	IN  IN_OVERTIME        SMALLINT,
	IN  IN_TOTAL           SMALLINT
)
BEGIN
	
    IF (SELECT COUNT(*) FROM BOX_SCORES WHERE GAME_ID = IN_GAME_ID AND TEAM_ID = IN_TEAM_ID) = 0 THEN
		
        # Insert new row 
        INSERT INTO BOX_SCORES (GAME_ID, TEAM_ID, Q1_SCORE, Q2_SCORE, 
								Q3_SCORE, Q4_SCORE, OVERTIME, TOTAL)
			VALUES (IN_GAME_ID, IN_TEAM_ID, IN_Q1_SCORE, IN_Q2_SCORE, 
					IN_Q3_SCORE, IN_Q4_SCORE, IN_OVERTIME, IN_TOTAL);
	
    ELSE
        
        # Update existing row
        UPDATE BOX_SCORES 
			SET 
				Q1_SCORE = IN_Q1_SCORE,
				Q2_SCORE = IN_Q2_SCORE,
                Q3_SCORE = IN_Q3_SCORE,
                Q4_SCORE = IN_Q4_SCORE,
                OVERTIME = IN_OVERTIME,
                TOTAL = IN_TOTAL
			WHERE GAME_ID = IN_GAME_ID
				AND TEAM_ID = IN_TEAM_ID;
        
	END IF;
    
    COMMIT;

END //

DELIMITER ;
