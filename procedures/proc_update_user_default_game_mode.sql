/******************************
File: proc_update_user_default_game_mode.sql
Last Update: 9/27/2025
Description: Procedure that updates the value of 'default game mode'
                for the given user account
Accepts:
    - 'userid' 
    - 'new default game mode'
Returns:
    - 'status message'
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_UPDATE_USER_DEFAULT_GAME_MODE //

CREATE PROCEDURE PROC_UPDATE_USER_DEFAULT_GAME_MODE (
    IN IN_USER_ID INT, 
    IN IN_DEFAULT_GAME_MODE VARCHAR(50), 
    OUT OUT_STATUS VARCHAR(100)
)

BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
        
        SELECT @msg;
    END;

    UPDATE USERS
    SET DEFAULT_GAME_MODE = IN_DEFAULT_GAME_MODE
    WHERE USER_ID = IN_USER_ID;
    
    COMMIT;

    SELECT 'Success';

END //

DELIMITER ;