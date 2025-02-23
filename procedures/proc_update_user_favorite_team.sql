/******************************
File: proc_update_user_phone.sql
Last Update: 2/22/2025
Description: Procedure that updates the value of 'favorite team' for 
                the given user account
Accepts:
    - 'userid' 
    - 'new team id'
Returns:
    - 'status message'
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_UPDATE_USER_FAVORITE_TEAM //

CREATE PROCEDURE PROC_UPDATE_USER_FAVORITE_TEAM (
    IN IN_USER_ID INT, 
    IN IN_FAVORITE_TEAM VARCHAR(10),
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
    SET FAVORITE_TEAM = IN_FAVORITE_TEAM
    WHERE USER_ID = IN_USER_ID;

    SELECT 'Success';

END //

DELIMITER ;