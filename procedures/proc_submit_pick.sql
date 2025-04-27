/******************************
File: proc_submit_pick.sql
Last Update: 2/10/2025
Description: Procedure that updates the values of 'team picked' and
                'pick weight' for the given user pick
Accepts:
    - 'userid'
    - 'gameid'
    - 'team picked'
    - 'pick weight'
Returns:
    - 'status message'
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_SUBMIT_PICK //

CREATE PROCEDURE PROC_SUBMIT_PICK (
    IN IN_USERNAME VARCHAR(25), 
    IN IN_GAME_ID VARCHAR(100),
    IN IN_TEAM_PICKED VARCHAR(25),
    IN IN_PICK_WEIGHT CHAR(1),  
    OUT OUT_STATUS VARCHAR(100))

BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
        
        SELECT @msg;
    END;
    
    DECLARE
	  UID INT;
	BEGIN
	  SELECT USER_ID
	  FROM USERS
	  WHERE USERNAME = IN_USERNAME AND 
      ROWNUM = 1;
	END;


    UPDATE PICKS
    SET TEAM_PICKED = IN_TEAM_PICKED,
        PICK_WEIGHT = IN_PICK_WEIGHT
    WHERE USER_ID = UID
        AND GAME_ID = IN_GAME_ID;
	
    COMMIT;

    SELECT 'Success';

END //

DELIMITER ;