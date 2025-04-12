/******************************
File: proc_create_user.sql
Last Update: 2/10/2025
Description: Procedure that creates a new user account with the initial 
                values provided at the login page by inserting the 
                required rows into the `USERS` and `PICKS` tables
Accepts:
    - 'username' 
    - 'password hash'
    - 'notification preference'
    - 'email address'
    - 'phone' 
Returns:
    - 'status message'
******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_CREATE_USER //

CREATE PROCEDURE PROC_CREATE_USER (
    IN IN_USERNAME VARCHAR(25),
    IN IN_PWDHASH VARCHAR(250),
    IN IN_FAVORITE_TEAM VARCHAR(25),
    IN IN_NOTIFICATION_PREF CHAR(1),
    IN IN_EMAIL_ADDRESS VARCHAR(75),
    IN IN_PHONE VARCHAR(10),
    OUT OUT_STATUS VARCHAR(1000)
)

BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
        
        SELECT @msg;
    END;
    
    
    IF (SELECT COUNT(*) FROM USERS WHERE USERNAME = IN_USERNAME) > 0 
		THEN SET OUT_STATUS = 'Username taken';
	ELSE
		INSERT INTO USERS (USERNAME, PWDHASH, FAVORITE_TEAM, NOTIFICATION_PREF, EMAIL_ADDRESS, PHONE) 
		VALUES (IN_USERNAME, IN_PWDHASH, IN_FAVORITE_TEAM, IN_NOTIFICATION_PREF, IN_EMAIL_ADDRESS, IN_PHONE);
        
        COMMIT;
        
		INSERT INTO PICKS (USER_ID, GAME_ID, TEAM_PICKED, PICK_WEIGHT)
			SELECT U.USER_ID, G.GAME_ID, '', ''
			FROM USERS U, GAMES G
			WHERE U.USERNAME = IN_USERNAME;
            
		COMMIT;
		
		SET OUT_STATUS = 'Success';
	END IF;
    
    SELECT OUT_STATUS;

END //

DELIMITER ;