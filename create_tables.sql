/******************************
File: create_tables.sql
Last Update: 1/16/2025
Description: This script defines the tables and constraints
             for the PICKEM_DB database.
******************************/

DELIMITER //

CREATE PROCEDURE CreateTables ()
BEGIN

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SCORING')
        CREATE TABLE SCORING (
            PICK_WEIGHT     CHAR(1)         NOT NULL,
            REWARD          TINYINT         NOT NULL,
            PENALTY         TINYINT         NOT NULL

            CONSTRAINT PK_SCORING PRIMARY KEY (PICK_WEIGHT)
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'USERS')
        CREATE TABLE USERS (
            USER_ID         INT             NOT NULL    AUTO_INCREMENT,
            USERNAME        VARCHAR(25)     NOT NULL,
            PWDHASH         VARCHAR(25)     NOT NULL,
            NOTIFICATION_PREF   CHAR(1)     NULL,
            EMAIL_ADDRESS   VARCHAR(75)     NULL,
            PHONE           VARCHAR(10)     NULL,
            
            CONSTRAINT PK_USERS PRIMARY KEY (USER_ID)
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PICKS')
        CREATE TABLE PICKS (
            PICK_ID         VARCHAR(50)     NOT NULL,
            USER_ID         INT             NOT NULL,
            GAME_ID         VARCHAR(25)     NOT NULL,
            TEAM_PICKED     VARCHAR(25)     NULL,
            PICK_WEIGHT     CHAR(1)         NULL,

            CONSTRAINT PK_PICKS PRIMARY KEY (PICK_ID),
            CONSTRAINT FK_USERPICK 
                FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
            CONSTRAINT FK_PICKSCORE 
                FOREIGN KEY (PICK_WEIGHT) REFERENCES SCORING(PICK_WEIGHT)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'BOX_SCORES')
        CREATE TABLE BOX_SCORES (
            GAME_ID         VARCHAR(25)     NOT NULL,
            TEAM_ID         VARCHAR(25)     NOT NULL,
            Q1_SCORE        SMALLINT        NULL,
            Q2_SCORE        SMALLINT        NULL,
            Q3_SCORE        SMALLINT        NULL,
            Q4_SCORE        SMALLINT        NULL,
            OVERTIME        SMALLINT        NULL,
            TOTAL           SMALLINT        NULL

            CONSTRAINT PK_GAME_BOX_SCORES PRIMARY KEY (GAME_ID, TEAM_ID)
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'LOCATIONS')
        CREATE TABLE LOCATIONS (
            STADIUM         VARCHAR(50)     NOT NULL,
            CITY            VARCHAR(50)     NOT NULL,
            STATE           VARCHAR(20)     NULL,
            LATITUDE        DECIMAL(19,16)  NULL,
            LONGITUDE       DECIMAL(19,16)  NULL,

            CONSTRAINT PK_LOCATIONS PRIMARY KEY (STADIUM, CITY)
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RECORDS')
        CREATE TABLE RECORDS (
            TEAM_ID         VARCHAR(25)     NOT NULL,
            RECORD_TYPE     VARCHAR(10)     NOT NULL,
            WINS            TINYINT         NULL,
            LOSSES          TINYINT         NULL,
            TIES            TINYINT         NULL,

            CONSTRAINT PK_TEAM_RECORD PRIMARY KEY (TEAM_ID, RECORD_TYPE)
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'STATS')
        CREATE TABLE STATS (
            TEAM_ID         VARCHAR(25)     NOT NULL,
            TYPE            VARCHAR(100)    NOT NULL,
            VALUE           VARCHAR(25)     NULL,

            CONSTRAINT PK_TEAM_STATS PRIMARY KEY (TEAM_ID, TYPE)
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ODDS')
        CREATE TABLE ODDS (
            GAME_ID         VARCHAR(25)     NOT NULL,
            GAME_CODE       VARCHAR(50)     NOT NULL,
            SOURCE          VARCHAR(10)     NULL,
            AWAY_MONEYLINE  VARCHAR(5)      NULL,
            HOME_MONEYLINE  VARCHAR(5)      NULL,
            AWAY_SPREAD     VARCHAR(5)      NULL,
            HOME_SPREAD     VARCHAR(5)      NULL,
            OVER_UNDER      VARCHAR(5)      NULL,
            AWAY_WIN_PERCENTAGE VARCHAR(5)  NULL,
            HOME_WIN_PERCENTAGE VARCHAR(5)  NULL,

            CONSTRAINT PK_GAME_ODDS PRIMARY KEY (GAME_ID, GAME_CODE)
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TEAMS')
        CREATE TABLE TEAMS (
            TEAM_ID         VARCHAR(25)     NOT NULL,
            CBS_CODE        VARCHAR(50)     NOT NULL,
            ESPN_CODE       VARCHAR(50)     NOT NULL,
            FOX_CODE        VARCHAR(50)     NOT NULL,
            VEGAS_CODE      VARCHAR(50)     NOT NULL,
            CONFERENCE_CODE VARCHAR(25)     NULL,
            CONFERENCE_NAME VARCHAR(50)     NULL,
            DIVISION_NAME   VARCHAR(50)     NULL,
            TEAM_NAME       VARCHAR(50)     NULL,
            TEAM_MASCOT     VARCHAR(50)     NULL,
            G5_CONFERENCE   TINYINT(1)      NULL,
            TEAM_LOGO_URL   VARCHAR(50)     NULL,

            CONSTRAINT PK_TEAMS PRIMARY KEY (TEAM_ID),
            CONSTRAINT FK_TEAM_RECORD 
                FOREIGN KEY (TEAM_ID) REFERENCES RECORD(TEAM_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
            CONSTRAINT FK_TEAM_STATS
                FOREIGN KEY (TEAM_ID) REFERENCES STATS(TEAM_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE/*
            CONSTRAINT FK_TEAM_BOX_SCORES
                FOREIGN KEY (TEAM_ID) REFERENCES TEAMS(TEAM_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE*/
        );

    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GAMES')
        CREATE TABLE GAMES (
            GAME_ID         VARCHAR(25)     NOT NULL,
            LEAGUE          VARCHAR(5)      NOT NULL,
            WEEK            TINYINT         NOT NULL,
            CBS_CODE        VARCHAR(50)     NOT NULL,
            ESPN_CODE       VARCHAR(50)     NOT NULL,
            FOX_CODE        VARCHAR(50)     NOT NULL,
            VEGAS_CODE      VARCHAR(50)     NOT NULL,
            AWAY_TEAM_ID    VARCHAR(25)     NOT NULL,
            HOME_TEAM_ID    VARCHAR(25)     NOT NULL,
            DATE            DATE            NULL,
            TIME            TIME            NULL,
            TV_COVERAGE     VARCHAR(25)     NULL,
            STADIUM         VARCHAR(50)     NULL,
            CITY            VARCHAR(50)     NULL,
            STATE           VARCHAR(50)     NULL,
            GAME_FINISHED   TINYINT(1)      NOT NULL

            CONSTRAINT PK_GAMES PRIMARY KEY (GAME_ID),
            CONSTRAINT FK_GAME_PICKS
                FOREIGN KEY (PICK_ID) REFERENCES PICKS(PICK_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
            CONSTRAINT FK_AWAY_BOX_SCORES
                FOREIGN KEY (GAME_ID, AWAY_TEAM_ID) REFERENCES BOX_SCORES(GAME_ID, TEAM_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
            CONSTRAINT FK_HOME_BOX_SCORES
                FOREIGN KEY (GAME_ID, HOME_TEAM_ID) REFERENCES BOX_SCORES(GAME_ID, TEAM_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
            CONSTRAINT FK_GAME_ODDS
                FOREIGN KEY (GAME_ID) REFERENCES ODDS(GAME_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
            CONSTRAINT FK_GAME_LOCATIONS
                FOREIGN KEY (STADIUM, CITY) REFERENCES LOCATIONS(STADIUM, CITY)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
            CONSTRAINT FK_AWAY_TEAM
                FOREIGN KEY (AWAY_TEAM_ID) REFERENCES TEAMS(TEAM_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
            CONSTRAINT FK_HOME_TEAM
                FOREIGN KEY (HOME_TEAM_ID) REFERENCES TEAMS(TEAM_ID)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
        );

END //

DELIMITER ;