/******************************
File: proc_create_views.sql
Last Update: 3/23/2025
Description: This script defines the views for the PICKEM_DB database.

GET_PICKS_VW: View that returns pick-related data, intended to be
                filtered on 'user id' or 'game id'
GET_GAMES_VW: View that returns games-related data, consolidated from
                various web sources, and is intended to be the foundational
                'games' data object for the application
GET_TEAMS_VW: View that returns teams-related data, intended to be 
                the foundational 'teams' data object for the application

******************************/

-- USE PICKEM_DB;

DELIMITER //

DROP PROCEDURE IF EXISTS PROC_CREATE_VIEWS //


CREATE PROCEDURE PROC_CREATE_VIEWS ()
BEGIN

	/***** GET_USER_IDS_VW *****/
    CREATE OR REPLACE VIEW GET_USER_IDS_VW AS
		SELECT USER_ID, DISPLAY_NAME FROM USERS;
    /*****************************************/

    /***** GET_USER_PICKS_VW *****/
    /*****************************************/
    CREATE OR REPLACE VIEW GET_USER_PICKS_VW AS
        SELECT
            -- PICKS
            USER.USER_ID,
            PICK.GAME_ID,
            PICK.TEAM_PICKED,
            PICK.PICK_WEIGHT,

            -- GAME DETAILS
            GAME.LEAGUE,
            GAME.WEEK,
            GAME.DATE,
            GAME.TIME,
            GAME.TV_COVERAGE,
            GAME.STADIUM,
            GAME.CITY,
            GAME.STATE,

            -- CBS GAME ODDS
            CBS_ODDS.AWAY_MONEYLINE CBS_AWAY_MONEYLINE,
            CBS_ODDS.HOME_MONEYLINE CBS_HOME_MONEYLINE,
            CBS_ODDS.AWAY_SPREAD CBS_AWAY_SPREAD,
            CBS_ODDS.HOME_SPREAD CBS_HOME_SPREAD,
            CBS_ODDS.OVER_UNDER CBS_OVER_UNDER,
            CBS_ODDS.AWAY_WIN_PERCENTAGE CBS_AWAY_WIN_PERCENTAGE,
            CBS_ODDS.HOME_WIN_PERCENTAGE CBS_HOME_WIN_PERCENTAGE,

            -- ESPN GAME ODDS
            ESPN_ODDS.AWAY_MONEYLINE ESPN_AWAY_MONEYLINE,
            ESPN_ODDS.HOME_MONEYLINE ESPN_HOME_MONEYLINE,
            ESPN_ODDS.AWAY_SPREAD ESPN_AWAY_SPREAD,
            ESPN_ODDS.HOME_SPREAD ESPN_HOME_SPREAD,
            ESPN_ODDS.OVER_UNDER ESPN_OVER_UNDER,
            ESPN_ODDS.AWAY_WIN_PERCENTAGE ESPN_AWAY_WIN_PERCENTAGE,
            ESPN_ODDS.HOME_WIN_PERCENTAGE ESPN_HOME_WIN_PERCENTAGE,

            -- FOX GAME ODDS
            FOX_ODDS.AWAY_MONEYLINE FOX_AWAY_MONEYLINE,
            FOX_ODDS.HOME_MONEYLINE FOX_HOME_MONEYLINE,
            FOX_ODDS.AWAY_SPREAD FOX_AWAY_SPREAD,
            FOX_ODDS.HOME_SPREAD FOX_HOME_SPREAD,
            FOX_ODDS.OVER_UNDER FOX_OVER_UNDER,
            FOX_ODDS.AWAY_WIN_PERCENTAGE FOX_AWAY_WIN_PERCENTAGE,
            FOX_ODDS.HOME_WIN_PERCENTAGE FOX_HOME_WIN_PERCENTAGE,

            -- VEGAS GAME ODDS
            VEGAS_ODDS.AWAY_MONEYLINE VEGAS_AWAY_MONEYLINE,
            VEGAS_ODDS.HOME_MONEYLINE VEGAS_HOME_MONEYLINE,
            VEGAS_ODDS.AWAY_SPREAD VEGAS_AWAY_SPREAD,
            VEGAS_ODDS.HOME_SPREAD VEGAS_HOME_SPREAD,
            VEGAS_ODDS.OVER_UNDER VEGAS_OVER_UNDER,
            VEGAS_ODDS.AWAY_WIN_PERCENTAGE VEGAS_AWAY_WIN_PERCENTAGE,
            VEGAS_ODDS.HOME_WIN_PERCENTAGE VEGAS_HOME_WIN_PERCENTAGE,

            -- AWAY BOX SCORES
            AWAY_BS.Q1_SCORE HOME_Q1_BOX_SCORE,
            AWAY_BS.Q2_SCORE HOME_Q2_BOX_SCORE,
            AWAY_BS.Q3_SCORE HOME_Q3_BOX_SCORE,
            AWAY_BS.Q4_SCORE HOME_Q4_BOX_SCORE,
            AWAY_BS.OVERTIME HOME_OVERTIME_BOX_SCORE,
            AWAY_BS.TOTAL HOME_TOTAL_BOX_SCORE,

            -- HOME BOX SCORES
            HOME_BS.Q1_SCORE AWAY_Q1_BOX_SCORE,
            HOME_BS.Q2_SCORE AWAY_Q2_BOX_SCORE,
            HOME_BS.Q3_SCORE AWAY_Q3_BOX_SCORE,
            HOME_BS.Q4_SCORE AWAY_Q4_BOX_SCORE,
            HOME_BS.OVERTIME AWAY_OVERTIME_BOX_SCORE,
            HOME_BS.TOTAL AWAY_TOTAL_BOX_SCORE,

            -- AWAY TEAM DETAILS
            AWAY.TEAM_ID AWAY_TEAM_ID,
            AWAY.CBS_CODE AWAY_CBS_CODE,
            AWAY.ESPN_CODE AWAY_ESPN_CODE,
            AWAY.FOX_CODE AWAY_FOX_CODE,
            AWAY.VEGAS_CODE AWAY_VEGAS_CODE,
            AWAY.CONFERENCE_CODE AWAY_CONFERENCE_CODE,
            AWAY.CONFERENCE_NAME AWAY_CONFERENCE_NAME,
            AWAY.DIVISION_NAME AWAY_DIVISION_NAME,
            AWAY.TEAM_NAME AWAY_TEAM_NAME,
            AWAY.TEAM_MASCOT AWAY_TEAM_MASCOT,
            AWAY.POWER_CONFERENCE AWAY_POWER_CONFERENCE,
            AWAY.TEAM_LOGO_URL AWAY_TEAM_LOGO_URL,
            AWAY_OVERALL_RECORD.WINS AWAY_OVERALL_WINS,
            AWAY_OVERALL_RECORD.LOSSES AWAY_OVERALL_LOSSES ,
            AWAY_OVERALL_RECORD.TIES AWAY_OVERALL_TIES,
            AWAY_CONFERENCE_RECORD.WINS AWAY_CONFERENCE_WINS,
            AWAY_CONFERENCE_RECORD.LOSSES AWAY_CONFERENCE_LOSSES,
            AWAY_CONFERENCE_RECORD.TIES AWAY_CONFERENCE_TIES,

            -- HOME TEAM DETAILS
            HOME.TEAM_ID HOME_TEAM_ID,
            HOME.CBS_CODE HOME_CBS_CODE,
            HOME.ESPN_CODE HOME_ESPN_CODE,
            HOME.FOX_CODE HOME_FOX_CODE,
            HOME.VEGAS_CODE HOME_VEGAS_CODE,
            HOME.CONFERENCE_CODE HOME_CONFERENCE_CODE,
            HOME.CONFERENCE_NAME HOME_CONFERENCE_NAME,
            HOME.DIVISION_NAME HOME_DIVISION_NAME,
            HOME.TEAM_NAME HOME_TEAM_NAME,
            HOME.TEAM_MASCOT HOME_TEAM_MASCOT,
            HOME.POWER_CONFERENCE HOME_POWER_CONFERENCE,
            HOME.TEAM_LOGO_URL HOME_TEAM_LOGO_URL,
            HOME_OVERALL_RECORD.WINS HOME_OVERALL_WINS,
            HOME_OVERALL_RECORD.LOSSES HOME_OVERALL_LOSSES,
            HOME_OVERALL_RECORD.TIES HOME_OVERALL_TIES,
            HOME_CONFERENCE_RECORD.WINS HOME_CONFERENCE_WINS,
            HOME_CONFERENCE_RECORD.LOSSES HOME_CONFERENCE_LOSSES,
            HOME_CONFERENCE_RECORD.TIES HOME_CONFERENCE_TIES

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
                    AND GAME.HOME_TEAM_ID = HOME_BS.TEAM_ID

                LEFT JOIN TEAMS AWAY
                    ON GAME.AWAY_TEAM_ID = AWAY.TEAM_ID
                LEFT JOIN RECORDS AWAY_OVERALL_RECORD 
                    ON AWAY.TEAM_ID = AWAY_OVERALL_RECORD.TEAM_ID
                    AND AWAY_OVERALL_RECORD.RECORD_TYPE = 'Overall'
                LEFT JOIN RECORDS AWAY_CONFERENCE_RECORD
                    ON AWAY.TEAM_ID = AWAY_CONFERENCE_RECORD.TEAM_ID
                    AND AWAY_CONFERENCE_RECORD.RECORD_TYPE = 'Conference'

                LEFT JOIN TEAMS HOME
                    ON GAME.HOME_TEAM_ID = HOME.TEAM_ID
                LEFT JOIN RECORDS HOME_OVERALL_RECORD 
                    ON HOME.TEAM_ID = HOME_OVERALL_RECORD.TEAM_ID
                    AND HOME_OVERALL_RECORD.RECORD_TYPE = 'Overall'
                LEFT JOIN RECORDS HOME_CONFERENCE_RECORD
                    ON HOME.TEAM_ID = HOME_CONFERENCE_RECORD.TEAM_ID
                    AND HOME_CONFERENCE_RECORD.RECORD_TYPE = 'Conference'
		ORDER BY
			LEAGUE,
			DATE,
            TIME;
    /************************************************************/
    /************************************************************/


    /***** GET_PICKS_VW *****/
    CREATE OR REPLACE VIEW GET_PICKS_VW AS
        SELECT
            USER.USER_ID,
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
            GAME.YEAR,
            GAME.AWAY_TEAM_ID,
            GAME.HOME_TEAM_ID,
            GAME.DATE,
            GAME.TIME,
            GAME.TV_COVERAGE,
            GAME.STADIUM,
            GAME.CITY,
            GAME.STATE,
            GAME.GAME_FINISHED,

			GAME.CBS_CODE,
            CBS_ODDS.AWAY_MONEYLINE CBS_AWAY_MONEYLINE,
            CBS_ODDS.HOME_MONEYLINE CBS_HOME_MONEYLINE,
            CBS_ODDS.AWAY_SPREAD CBS_AWAY_SPREAD,
            CBS_ODDS.HOME_SPREAD CBS_HOME_SPREAD,
            CBS_ODDS.OVER_UNDER CBS_OVER_UNDER,
            CBS_ODDS.AWAY_WIN_PERCENTAGE CBS_AWAY_WIN_PERCENTAGE,
            CBS_ODDS.HOME_WIN_PERCENTAGE CBS_HOME_WIN_PERCENTAGE,

			GAME.ESPN_CODE,
            ESPN_ODDS.AWAY_MONEYLINE ESPN_AWAY_MONEYLINE,
            ESPN_ODDS.HOME_MONEYLINE ESPN_HOME_MONEYLINE,
            ESPN_ODDS.AWAY_SPREAD ESPN_AWAY_SPREAD,
            ESPN_ODDS.HOME_SPREAD ESPN_HOME_SPREAD,
            ESPN_ODDS.OVER_UNDER ESPN_OVER_UNDER,
            ESPN_ODDS.AWAY_WIN_PERCENTAGE ESPN_AWAY_WIN_PERCENTAGE,
            ESPN_ODDS.HOME_WIN_PERCENTAGE ESPN_HOME_WIN_PERCENTAGE,

			GAME.FOX_CODE,
            FOX_ODDS.AWAY_MONEYLINE FOX_AWAY_MONEYLINE,
            FOX_ODDS.HOME_MONEYLINE FOX_HOME_MONEYLINE,
            FOX_ODDS.AWAY_SPREAD FOX_AWAY_SPREAD,
            FOX_ODDS.HOME_SPREAD FOX_HOME_SPREAD,
            FOX_ODDS.OVER_UNDER FOX_OVER_UNDER,
            FOX_ODDS.AWAY_WIN_PERCENTAGE FOX_AWAY_WIN_PERCENTAGE,
            FOX_ODDS.HOME_WIN_PERCENTAGE FOX_HOME_WIN_PERCENTAGE,

			GAME.VEGAS_CODE,
            VEGAS_ODDS.AWAY_MONEYLINE VEGAS_AWAY_MONEYLINE,
            VEGAS_ODDS.HOME_MONEYLINE VEGAS_HOME_MONEYLINE,
            VEGAS_ODDS.AWAY_SPREAD VEGAS_AWAY_SPREAD,
            VEGAS_ODDS.HOME_SPREAD VEGAS_HOME_SPREAD,
            VEGAS_ODDS.OVER_UNDER VEGAS_OVER_UNDER,
            VEGAS_ODDS.AWAY_WIN_PERCENTAGE VEGAS_AWAY_WIN_PERCENTAGE,
            VEGAS_ODDS.HOME_WIN_PERCENTAGE VEGAS_HOME_WIN_PERCENTAGE,

            AWAY_BS.Q1_SCORE AWAY_Q1_BOX_SCORE,
            AWAY_BS.Q2_SCORE AWAY_Q2_BOX_SCORE,
            AWAY_BS.Q3_SCORE AWAY_Q3_BOX_SCORE,
            AWAY_BS.Q4_SCORE AWAY_Q4_BOX_SCORE,
            AWAY_BS.OVERTIME AWAY_OVERTIME_BOX_SCORE,
            AWAY_BS.TOTAL AWAY_TOTAL_BOX_SCORE,

            HOME_BS.Q1_SCORE HOME_Q1_BOX_SCORE,
            HOME_BS.Q2_SCORE HOME_Q2_BOX_SCORE,
            HOME_BS.Q3_SCORE HOME_Q3_BOX_SCORE,
            HOME_BS.Q4_SCORE HOME_Q4_BOX_SCORE,
            HOME_BS.OVERTIME HOME_OVERTIME_BOX_SCORE,
            HOME_BS.TOTAL HOME_TOTAL_BOX_SCORE

        FROM
			GAMES GAME
                
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
            TEAM.LEAGUE,
            TEAM.CBS_CODE,
            TEAM.ESPN_CODE,
            TEAM.FOX_CODE,
            TEAM.VEGAS_CODE,
            TEAM.CONFERENCE_CODE,
            TEAM.CONFERENCE_NAME,
            TEAM.DIVISION_NAME,
            TEAM.TEAM_NAME,
            TEAM.TEAM_MASCOT,
            TEAM.POWER_CONFERENCE,
            TEAM.TEAM_LOGO_URL,
            TEAM.PRIMARY_COLOR,
            TEAM.ALTERNATE_COLOR,
            TEAM.RANKING,
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
    
    
    /************************************************************/
    CREATE OR REPLACE VIEW IS_SYSTEM_UNDER_MAINTENANCE_VW AS
		SELECT * FROM UNDER_MAINTENANCE;
    /************************************************************/


    /************************************************************/
    CREATE OR REPLACE VIEW GET_LEADERBOAD_VW AS
        SELECT
            P.USER_ID,
            U.DISPLAY_NAME,
            G.WEEK,
            G.LEAGUE,
            G.YEAR,
            AWAY.POWER_CONFERENCE AWAY_POWER_CONFERENCE,
            HOME.POWER_CONFERENCE HOME_POWER_CONFERENCE,
            AWAY.RANKING AWAY_RANKING,
            HOME.RANKING HOME_RANKING,
            
            CASE
                WHEN (
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.AWAY_TEAM_ID)
                        >
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.HOME_TEAM_ID)
                ) AND G.AWAY_TEAM_ID = P.TEAM_PICKED
                THEN S.REWARD
                
                WHEN (
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.AWAY_TEAM_ID)
                        <
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.HOME_TEAM_ID)
                ) AND G.HOME_TEAM_ID = P.TEAM_PICKED
                THEN S.REWARD

                ELSE S.PENALTY
            END POINTS,
            
            CASE
                WHEN (
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.AWAY_TEAM_ID)
                        >
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.HOME_TEAM_ID)
                ) AND G.AWAY_TEAM_ID = P.TEAM_PICKED
                THEN 1
                
                WHEN (
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.AWAY_TEAM_ID)
                        <
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.HOME_TEAM_ID)
                ) AND G.HOME_TEAM_ID = P.TEAM_PICKED
                THEN 1

                ELSE 0
            END CORRECT_PICK,
            
            CASE
                WHEN (
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.AWAY_TEAM_ID)
                        >
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.HOME_TEAM_ID)
                ) AND G.AWAY_TEAM_ID = P.TEAM_PICKED
                THEN 0
                
                WHEN (
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.AWAY_TEAM_ID)
                        <
                    (SELECT B.TOTAL FROM BOX_SCORES B WHERE B.GAME_ID = G.GAME_ID AND B.TEAM_ID = G.HOME_TEAM_ID)
                ) AND G.HOME_TEAM_ID = P.TEAM_PICKED
                THEN 0

                ELSE 1
            END INCORRECT_PICK

        FROM
            PICKS P
				INNER JOIN USERS U
					ON P.USER_ID = U.USER_ID
                INNER JOIN GAMES G
                    ON P.GAME_ID = G.GAME_ID
                LEFT JOIN SCORING S
                    ON P.PICK_WEIGHT = S.PICK_WEIGHT
				INNER JOIN TEAMS AWAY
					ON G.AWAY_TEAM_ID = AWAY.TEAM_ID
				INNER JOIN TEAMS HOME
					ON G.HOME_TEAM_ID = HOME.TEAM_ID
        WHERE
            G.GAME_FINISHED = 1;
    /************************************************************/

END //

DELIMITER ;