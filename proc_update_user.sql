/******************************
File: proc_update_user.sql
Last Update: 2/2/2025
Description: This script updates the notification preference, email address 
                or phone number of the given user record
******************************/


DELIMITER //

DROP PROCEDURE IF EXISTS PROC_UPDATE_USER //

CREATE PROCEDURE PROC_UPDATE_USER (IN IN_USER_ID INT, IN IN_NOTIFICATION_PREF CHAR(1), 
                                    IN IN_EMAIL_ADDRESS VARCHAR(75), IN IN_PHONE VARCHAR(10),
                                    OUT OUT_STATUS VARCHAR(100))

BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
        
        SELECT @msg;
    END;

    UPDATE USERS
    SET NOTIFICATION_PREF = IN_NOTIFICATION_PREF,
        EMAIL_ADDRESS = IN_EMAIL_ADDRESS,
        PHONE = IN_PHONE
    WHERE USER_ID = IN_USER_ID;

    SELECT 'Success';

END //

DELIMITER ;