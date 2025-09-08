/******************************
File: proc_create_db.sql
Last Update: 2/1/2025
Description: This script creates all objects from the PICKEM_DB
******************************/


CREATE DATABASE IF NOT EXISTS PICKEM_DB;
-- USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_CREATE_DB //

CREATE PROCEDURE PROC_CREATE_DB ()
BEGIN

    -- CREATE DATABASE IF NOT EXISTS PICKEM_DB;

    CALL PROC_CREATE_TABLES;
    CALL PROC_CREATE_VIEWS;
    
    INSERT INTO UNDER_MAINTENANCE VALUES (1);

END //

DELIMITER ;