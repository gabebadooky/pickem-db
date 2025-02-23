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
    IN IN_USER_ID INT, 
    IN IN_GAME_ID VARCHAR(25),
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

    UPDATE PICKS
    SET TEAM_PICKED = IN_TEAM_PICKED,
        PICK_WEIGHT = IN_PICK_WEIGHT
    WHERE USER_ID = IN_USER_ID
        AND GAME_ID = IN_GAME_ID;

    SELECT 'Success';

END //

DELIMITER ;