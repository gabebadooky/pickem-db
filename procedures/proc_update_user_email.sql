/******************************
File: proc_update_user_email.sql
Last Update: 2/10/2025
Description: Procedure that updates the value of 'email address'
                for the given user account
Accepts:
    - 'userid' 
    - 'new email address'
Returns:
    - 'status message'
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_UPDATE_USER_EMAIL //

CREATE PROCEDURE PROC_UPDATE_USER_EMAIL (
    IN IN_USER_ID INT, 
    IN IN_EMAIL_ADDRESS VARCHAR(75),
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
    SET EMAIL_ADDRESS = IN_EMAIL_ADDRESS
    WHERE USER_ID = IN_USER_ID;
    
    COMMIT;

    SELECT 'Success';

END //

DELIMITER ;