/******************************
File: proc_update_user_notification_preference.sql
Last Update: 2/10/2025
Description: Procedure that updates the value of 'notification preference'
                for the given user account
Accepts:
    - 'userid' 
    - 'new notification preference'
Returns:
    - 'status message'
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_UPDATE_USER_NOTIFICATION_PREFERENCE //

CREATE PROCEDURE PROC_UPDATE_USER_NOTIFICATION_PREFERENCE (
    IN IN_USER_ID INT, 
    IN IN_NOTIFICATION_PREF CHAR(1), 
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
    SET NOTIFICATION_PREF = IN_NOTIFICATION_PREF
    WHERE USER_ID = IN_USER_ID;

    SELECT 'Success';

END //

DELIMITER ;