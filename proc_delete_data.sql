/******************************
File: proc_delete_data.sql
Last Update: 2/1/2025
Description: This script deletes all data from the PICKEM_DB in the 
                proper sequence to avoid violating FK constraints
******************************/


DELIMITER //

DROP PROCEDURE IF EXISTS PROC_DELETE_DATA //

CREATE PROCEDURE PROC_DELETE_DATA ()
BEGIN

    DELETE FROM GAMES;
    DELETE FROM TEAMS;
    DELETE FROM PICKS;

    DELETE FROM SCORING;
    DELETE FROM USERS;

    DELETE FROM ODDS;
    DELETE FROM LOCATIONS;
    DELETE FROM BOX_SCORES;

    DELETE FROM TEAM_STATS;
    DELETE FROM RECORDS;

END //

DELIMITER ;