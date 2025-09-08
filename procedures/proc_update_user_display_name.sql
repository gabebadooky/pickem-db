/******************************
File: proc_update_user_display_name.sql
Last Update: 9/2/2025
Description: Procedure that updates the value of 'display name'
                for the given user account
Accepts:
    - 'userid' 
    - 'new display name'
Returns:
    - 'status message'
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_UPDATE_USER_DISPLAY_NAME //

CREATE PROCEDURE PROC_UPDATE_USER_DISPLAY_NAME (
    IN IN_USER_ID INT, 
    IN IN_DISPLAY_NAME VARCHAR(50), 
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
    SET DISPLAY_NAME = IN_DISPLAY_NAME
    WHERE USER_ID = IN_USER_ID;
    
    COMMIT;

    SELECT 'Success';

END //

DELIMITER ;