/******************************
File: proc_create_user.sql
Last Update: 2/2/2025
Description: This script inserts a record for a new user in the `USERS` table
                and create a pick record for each game in the season for the new user
******************************/


DELIMITER //

USE PICKEM_DB //

DROP PROCEDURE IF EXISTS PROC_CREATE_USER //

CREATE PROCEDURE  PROC_CREATE_USER (IN IN_USERNAME VARCHAR(25), IN IN_PWDHASH VARCHAR(25), 
                                    IN IN_NOTIFICATION_PREF CHAR(1), IN IN_EMAIL_ADDRESS VARCHAR(75),
                                    IN IN_PHONE VARCHAR(10), OUT OUT_STATUS VARCHAR(100))

BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
        
        SELECT @msg;
    END;

    INSERT INTO USERS (USERNAME, PWDHASH, NOTIFICATION_PREF, EMAIL_ADDRESS, PHONE) 
        VALUES (IN_USERNAME, IN_PWDHASH, IN_NOTIFICATION_PREF, IN_EMAIL_ADDRESS, IN_PHONE);

    INSERT INTO PICKS (USER_ID, GAME_ID)
        SELECT MAX(U.USER_ID), G.GAME_ID
        FROM USERS U, GAMES G
        WHERE U.USERNAME = IN_USERNAME;

    SELECT 'Success';

END //

DELIMITER ;