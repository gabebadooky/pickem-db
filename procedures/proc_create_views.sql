/******************************
File: proc_create_views.sql
Last Update: 2/10/2025
Description: This script defines the views for the PICKEM_DB database.

GET_PICKS_VW: View that returns pick-related data, intended to be
                filtered on 'user id' or 'game id'
GET_GAMES_VW: View that returns games-related data, consolidated from
                various web sources, and is intended to be the foundational
                'games' data object for the application
GET_TEAMS_VW: View that returns teams-related data, intended to be 
                the foundational 'teams' data object for the application

******************************/

USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_CREATE_VIEWS //

CREATE PROCEDURE PROC_CREATE_VIEWS ()
BEGIN

    /***** GET_PICKS_VW *****/
    CREATE OR REPLACE VIEW GET_PICKS_VW AS
        SELECT
            USER.USERNAME,
            PICK.GAME_ID,
            PICK.TEAM_PICKED,
            PICK.PICK_WEIGHT
        FROM
            PICKS PICK
                INNER JOIN USERS USER
                    ON PICK.USER_ID = USER.USER_ID;
    /************************************************************/


    /***** GET_GAMES_VW *****/
    CREATE OR REPLACE VIEW GET_GAMES_VW AS
        SELECT
            GAME.GAME_ID,
            GAME.LEAGUE,
            GAME.WEEK,
            GAME.AWAY_TEAM_ID,
            GAME.HOME_TEAM_ID,
            GAME.DATE,
            GAME.TIME,
            GAME.TV_COVERAGE,
            GAME.STADIUM,
            GAME.CITY,
            GAME.STATE,

            CBS_ODDS.AWAY_MONEYLINE CBS_AWAY_MONEYLINE,
            CBS_ODDS.HOME_MONEYLINE CBS_HOME_MONEYLINE,
            CBS_ODDS.AWAY_SPREAD CBS_AWAY_SPREAD,
            CBS_ODDS.HOME_SPREAD CBS_HOME_SPREAD,
            CBS_ODDS.OVER_UNDER CBS_OVER_UNDER,
            CBS_ODDS.AWAY_WIN_PERCENTAGE CBS_AWAY_WIN_PERCENTAGE,
            CBS_ODDS.HOME_WIN_PERCENTAGE CBS_HOME_WIN_PERCENTAGE,

            ESPN_ODDS.AWAY_MONEYLINE ESPN_AWAY_MONEYLINE,
            ESPN_ODDS.HOME_MONEYLINE ESPN_HOME_MONEYLINE,
            ESPN_ODDS.AWAY_SPREAD ESPN_AWAY_SPREAD,
            ESPN_ODDS.HOME_SPREAD ESPN_HOME_SPREAD,
            ESPN_ODDS.OVER_UNDER ESPN_OVER_UNDER,
            ESPN_ODDS.AWAY_WIN_PERCENTAGE ESPN_AWAY_WIN_PERCENTAGE,
            ESPN_ODDS.HOME_WIN_PERCENTAGE ESPN_HOME_WIN_PERCENTAGE,

            FOX_ODDS.AWAY_MONEYLINE FOX_AWAY_MONEYLINE,
            FOX_ODDS.HOME_MONEYLINE FOX_HOME_MONEYLINE,
            FOX_ODDS.AWAY_SPREAD FOX_AWAY_SPREAD,
            FOX_ODDS.HOME_SPREAD FOX_HOME_SPREAD,
            FOX_ODDS.OVER_UNDER FOX_OVER_UNDER,
            FOX_ODDS.AWAY_WIN_PERCENTAGE FOX_AWAY_WIN_PERCENTAGE,
            FOX_ODDS.HOME_WIN_PERCENTAGE FOX_HOME_WIN_PERCENTAGE,

            VEGAS_ODDS.AWAY_MONEYLINE VEGAS_AWAY_MONEYLINE,
            VEGAS_ODDS.HOME_MONEYLINE VEGAS_HOME_MONEYLINE,
            VEGAS_ODDS.AWAY_SPREAD VEGAS_AWAY_SPREAD,
            VEGAS_ODDS.HOME_SPREAD VEGAS_HOME_SPREAD,
            VEGAS_ODDS.OVER_UNDER VEGAS_OVER_UNDER,
            VEGAS_ODDS.AWAY_WIN_PERCENTAGE VEGAS_AWAY_WIN_PERCENTAGE,
            VEGAS_ODDS.HOME_WIN_PERCENTAGE VEGAS_HOME_WIN_PERCENTAGE,

            AWAY_BS.Q1_SCORE HOME_Q1_BOX_SCORE,
            AWAY_BS.Q2_SCORE HOME_Q2_BOX_SCORE,
            AWAY_BS.Q3_SCORE HOME_Q3_BOX_SCORE,
            AWAY_BS.Q4_SCORE HOME_Q4_BOX_SCORE,
            AWAY_BS.OVERTIME HOME_OVERTIME_BOX_SCORE,
            AWAY_BS.TOTAL HOME_TOTAL_BOX_SCORE,

            HOME_BS.Q1_SCORE AWAY_Q1_BOX_SCORE,
            HOME_BS.Q2_SCORE AWAY_Q2_BOX_SCORE,
            HOME_BS.Q3_SCORE AWAY_Q3_BOX_SCORE,
            HOME_BS.Q4_SCORE AWAY_Q4_BOX_SCORE,
            HOME_BS.OVERTIME AWAY_OVERTIME_BOX_SCORE,
            HOME_BS.TOTAL  AWAY_TOTAL_BOX_SCORE

        FROM
            PICKS PICK
                INNER JOIN USERS USER
                    ON PICK.USER_ID = USER.USER_ID

                INNER JOIN GAMES GAME
                    ON PICK.GAME_ID = GAME.GAME_ID
                
                LEFT JOIN ODDS CBS_ODDS
                    ON GAME.GAME_ID = CBS_ODDS.GAME_ID
                    AND GAME.CBS_CODE = CBS_ODDS.GAME_CODE
                    AND CBS_ODDS.SOURCE = 'CBS'
                
                LEFT JOIN ODDS ESPN_ODDS
                    ON GAME.GAME_ID = ESPN_ODDS.GAME_ID
                    AND GAME.ESPN_CODE = ESPN_ODDS.GAME_CODE
                    AND ESPN_ODDS.SOURCE = 'ESPN'
                
                LEFT JOIN ODDS FOX_ODDS
                    ON GAME.GAME_ID = FOX_ODDS.GAME_ID
                    AND GAME.FOX_CODE = FOX_ODDS.GAME_CODE
                    AND FOX_ODDS.SOURCE = 'FOX'
                
                LEFT JOIN ODDS VEGAS_ODDS
                    ON GAME.GAME_ID = VEGAS_ODDS.GAME_ID
                    AND GAME.VEGAS_CODE = VEGAS_ODDS.GAME_CODE
                    AND VEGAS_ODDS.SOURCE = 'VEGAS'

                LEFT JOIN BOX_SCORES AWAY_BS
                    ON GAME.GAME_ID = AWAY_BS.GAME_ID
                    AND GAME.AWAY_TEAM_ID = AWAY_BS.TEAM_ID
                
                LEFT JOIN BOX_SCORES HOME_BS
                    ON GAME.GAME_ID = HOME_BS.GAME_ID
                    AND GAME.HOME_TEAM_ID = HOME_BS.TEAM_ID;
    /************************************************************/


    /***** GET_TEAMS_VW *****/
    CREATE OR REPLACE VIEW GET_TEAMS_VW AS
        SELECT
            TEAM.TEAM_ID,
            TEAM.CBS_CODE,
            TEAM.ESPN_CODE,
            TEAM.FOX_CODE,
            TEAM.VEGAS_CODE,
            TEAM.CONFERENCE_CODE,
            TEAM.CONFERENCE_NAME,
            TEAM.DIVISION_NAME,
            TEAM.TEAM_NAME,
            TEAM.TEAM_MASCOT,
            TEAM.G5_CONFERENCE,
            TEAM.TEAM_LOGO_URL,
            OVERALL_RECORD.WINS OVERALL_WINS,
            OVERALL_RECORD.LOSSES OVERALL_LOSSES,
            OVERALL_RECORD.TIES OVERALL_TIES,
            CONFERENCE_RECORD.WINS CONFERENCE_WINS,
            CONFERENCE_RECORD.LOSSES CONFERENCE_LOSSES,
            CONFERENCE_RECORD.TIES CONFERENCE_TIES
        FROM
            TEAMS TEAM
                LEFT JOIN RECORDS OVERALL_RECORD 
                    ON TEAM.TEAM_ID = OVERALL_RECORD.TEAM_ID
                    AND OVERALL_RECORD.RECORD_TYPE = 'Overall'
                LEFT JOIN RECORDS CONFERENCE_RECORD
                    ON TEAM.TEAM_ID = CONFERENCE_RECORD.TEAM_ID
                    AND CONFERENCE_RECORD.RECORD_TYPE = 'Conference';
    /************************************************************/


END //

DELIMITER ;