
SELECT * FROM USERS; -- 18
SELECT * FROM PICKS WHERE USER_ID = 18;

select * from GET_GAMES_VW WHERE WEEK = 7;

SELECT * FROM GAMES WHERE LEAGUE = 'CFB' AND WEEK = 7 AND (
	GAME_ID LIKE '%navy%'					-- air-force-falcons-at-navy-midshipmen
	OR GAME_ID LIKE '%georgia-bulldogs%'	-- kentucky-wildcats-at-georgia-bulldogs
	OR GAME_ID LIKE '%ohio-bobcats%'		-- ohio-bobcats-at-ball-state-cardinals
	OR GAME_ID LIKE '%notre%'				-- boise-state-broncos-at-notre-dame-fighting-irish
	OR GAME_ID LIKE '%international%'		-- florida-international-panthers-at-uconn-huskies
	OR GAME_ID LIKE '%texas-tech%'			-- texas-tech-red-raiders-at-houston-cougars
	OR GAME_ID LIKE '%penn%'				-- penn-state-nittany-lions-at-ucla-bruins
	OR GAME_ID LIKE '%oregon-state%'		-- oregon-state-beavers-at-app-state-mountaineers
);


SELECT * FROM PICKS WHERE USER_ID = 18 AND GAME_ID = 'air-force-falcons-at-navy-midshipmen';
UPDATE PICKS 
SET TEAM_PICKED = 'navy-midshipmen', PICK_WEIGHT = 'l'
WHERE USER_ID = 18 AND GAME_ID = 'air-force-falcons-at-navy-midshipmen';


SELECT * FROM PICKS WHERE USER_ID = 18 AND GAME_ID = 'kentucky-wildcats-at-georgia-bulldogs';
UPDATE PICKS 
SET TEAM_PICKED = 'georgia-bulldogs', PICK_WEIGHT = 'h'
WHERE USER_ID = 18 AND GAME_ID = 'kentucky-wildcats-at-georgia-bulldogs';


SELECT * FROM PICKS WHERE USER_ID = 18 AND GAME_ID = 'ohio-bobcats-at-ball-state-cardinals';
UPDATE PICKS 
SET TEAM_PICKED = 'ohio-bobcats', PICK_WEIGHT = 'h'
WHERE USER_ID = 18 AND GAME_ID = 'ohio-bobcats-at-ball-state-cardinals';


SELECT * FROM PICKS WHERE USER_ID = 18 AND GAME_ID = 'boise-state-broncos-at-notre-dame-fighting-irish';
UPDATE PICKS 
SET TEAM_PICKED = 'notre-dame-fighting-irish', PICK_WEIGHT = 'h'
WHERE USER_ID = 18 AND GAME_ID = 'boise-state-broncos-at-notre-dame-fighting-irish';


SELECT * FROM PICKS WHERE USER_ID = 18 AND GAME_ID = 'florida-international-panthers-at-uconn-huskies';
UPDATE PICKS 
SET TEAM_PICKED = 'florida-international-panthers', PICK_WEIGHT = 'l'
WHERE USER_ID = 18 AND GAME_ID = 'florida-international-panthers-at-uconn-huskies';


SELECT * FROM PICKS WHERE USER_ID = 18 AND GAME_ID = 'texas-tech-red-raiders-at-houston-cougars';
UPDATE PICKS 
SET TEAM_PICKED = 'texas-tech-red-raiders', PICK_WEIGHT = 'h'
WHERE USER_ID = 18 AND GAME_ID = 'texas-tech-red-raiders-at-houston-cougars';


SELECT * FROM PICKS WHERE USER_ID = 18 AND GAME_ID = 'penn-state-nittany-lions-at-ucla-bruins';
UPDATE PICKS 
SET TEAM_PICKED = 'penn-state-nittany-lions', PICK_WEIGHT = 'h'
WHERE USER_ID = 18 AND GAME_ID = 'penn-state-nittany-lions-at-ucla-bruins';


SELECT * FROM PICKS WHERE USER_ID = 18 AND GAME_ID = 'oregon-state-beavers-at-app-state-mountaineers';
UPDATE PICKS 
SET TEAM_PICKED = 'oregon-state-beavers', PICK_WEIGHT = 'l'
WHERE USER_ID = 18 AND GAME_ID = 'oregon-state-beavers-at-app-state-mountaineers';





SELECT * FROM PICKS WHERE USER_ID = 18 
	AND (
    GAME_ID = 'air-force-falcons-at-navy-midshipmen'
	OR GAME_ID = 'kentucky-wildcats-at-georgia-bulldogs'
	OR GAME_ID = 'ohio-bobcats-at-ball-state-cardinals'
	OR GAME_ID = 'boise-state-broncos-at-notre-dame-fighting-irish'
	OR GAME_ID = 'florida-international-panthers-at-uconn-huskies'
	OR GAME_ID = 'texas-tech-red-raiders-at-houston-cougars'
	OR GAME_ID = 'penn-state-nittany-lions-at-ucla-bruins'
	OR GAME_ID = 'oregon-state-beavers-at-app-state-mountaineers'
);


