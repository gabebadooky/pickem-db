/******************************
File: proc_update_team_notes.sql
Last Update: 6/6/2025
Description: Procedure that updates the value of 'team notes'
                for the given user account
Accepts:
    - 'userid' 
    - 'teamid'
    - 'notes'
Returns:
    - 'status message'
******************************/

-- USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_UPDATE_TEAM_NOTES //

CREATE PROCEDURE PROC_UPDATE_TEAM_NOTES (
    IN IN_USER_ID INT, 
    IN IN_TEAM_ID VARCHAR(100),
    IN IN_NOTES	BLOB,
    OUT OUT_STATUS VARCHAR(100)
)

BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
        
        SELECT @msg;
    END;

    UPDATE USER_TEAM_NOTES
    SET NOTES = IN_NOTES
    WHERE USER_ID = IN_USER_ID
	AND TEAM_ID = IN_TEAM_ID;
    
    COMMIT;

    SELECT 'Success';

END //

DELIMITER ;