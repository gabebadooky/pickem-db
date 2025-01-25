/******************************
File: create_views.sql
Last Update: 1/25/2025
Description: This script defines the views
             for the PICKEM_DB database.
******************************/


DELIMITER //

CREATE PROCEDURE CreateViews ()
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

            CBS_ODDS.AWAY_MONEYLINE,
            CBS_ODDS.HOME_MONEYLINE,
            CBS_ODDS.AWAY_SPREAD,
            CBS_ODDS.HOME_SPREAD,
            CBS_ODDS.OVER_UNDER,
            CBS_ODDS.AWAY_WIN_PERCENTAGE,
            CBS_ODDS.HOME_WIN_PERCENTAGE,

            ESPN_ODDS.AWAY_MONEYLINE,
            ESPN_ODDS.HOME_MONEYLINE,
            ESPN_ODDS.AWAY_SPREAD,
            ESPN_ODDS.HOME_SPREAD,
            ESPN_ODDS.OVER_UNDER,
            ESPN_ODDS.AWAY_WIN_PERCENTAGE,
            ESPN_ODDS.HOME_WIN_PERCENTAGE,

            FOX_ODDS.AWAY_MONEYLINE,
            FOX_ODDS.HOME_MONEYLINE,
            FOX_ODDS.AWAY_SPREAD,
            FOX_ODDS.HOME_SPREAD,
            FOX_ODDS.OVER_UNDER,
            FOX_ODDS.AWAY_WIN_PERCENTAGE,
            FOX_ODDS.HOME_WIN_PERCENTAGE,

            VEGAS_ODDS.AWAY_MONEYLINE,
            VEGAS_ODDS.HOME_MONEYLINE,
            VEGAS_ODDS.AWAY_SPREAD,
            VEGAS_ODDS.HOME_SPREAD,
            VEGAS_ODDS.OVER_UNDER,
            VEGAS_ODDS.AWAY_WIN_PERCENTAGE,
            VEGAS_ODDS.HOME_WIN_PERCENTAGE,

            AWAY_BS.Q1_SCORE,
            AWAY_BS.Q2_SCORE,
            AWAY_BS.Q3_SCORE,
            AWAY_BS.Q4_SCORE,
            AWAY_BS.OVERTIME,
            AWAY_BS.TOTAL,

            HOME_BS.Q1_SCORE,
            HOME_BS.Q2_SCORE,
            HOME_BS.Q3_SCORE,
            HOME_BS.Q4_SCORE,
            HOME_BS.OVERTIME,
            HOME_BS.TOTAL

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

END;        
