/******************************
File: proc_update_user_phone.sql
Last Update: 2/9/2025
Description: This script updates the phone number 
                of the given user record
******************************/


DELIMITER //

USE PICKEM_DB //

DROP PROCEDURE IF EXISTS PROC_UPDATE_USER_PHONE //

CREATE PROCEDURE PROC_UPDATE_USER_PHONE (IN IN_USER_ID INT, IN IN_PHONE VARCHAR(10),
                                    OUT OUT_STATUS VARCHAR(100))

BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
        
        SELECT @msg;
    END;

    UPDATE USERS
    SET PHONE = IN_PHONE
    WHERE USER_ID = IN_USER_ID;

    SELECT 'Success';

END //

DELIMITER ;